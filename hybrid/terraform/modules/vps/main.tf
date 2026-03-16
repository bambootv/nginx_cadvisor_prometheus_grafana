terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 3.0.0"
    }
  }
}

variable "vps_name" {
  type = string
}

variable "pdc_cluster_id" {
  type = string
}

# 1. Create Prometheus Datasource via PDC
resource "grafana_data_source" "prometheus" {
  name = "Prometheus-${var.vps_name}"
  type = "prometheus"
  url  = "http://prometheus:9090" # Local URL inside the VPS network

  # PDC Configuration
  json_data_encoded = jsonencode({
    enableSecureSocksProxy   = true
    secureSocksProxyUsername = var.pdc_cluster_id
  })

  http_headers = {
    "X-Pdc-Connection" = var.pdc_cluster_id
  }
}

# 1b. Create VictoriaMetrics Datasource via PDC (Prometheus-compatible)
resource "grafana_data_source" "victoriametrics" {
  name = "VictoriaMetrics-${var.vps_name}"
  type = "prometheus"
  url  = "http://victoria-metrics:8428" # Local URL inside the VPS network

  # PDC Configuration
  json_data_encoded = jsonencode({
    enableSecureSocksProxy   = true
    secureSocksProxyUsername = var.pdc_cluster_id
  })

  http_headers = {
    "X-Pdc-Connection" = var.pdc_cluster_id
  }
}

# 2. Create Loki Datasource via PDC
resource "grafana_data_source" "loki" {
  name = "Loki-${var.vps_name}"
  type = "loki"
  url  = "http://loki:3102" # Local URL inside the VPS network

  # PDC Configuration
  json_data_encoded = jsonencode({
    enableSecureSocksProxy   = true
    secureSocksProxyUsername = var.pdc_cluster_id
  })

  http_headers = {
    "X-Pdc-Connection" = var.pdc_cluster_id
  }
}

# 2b. Create VictoriaLogs Datasource via PDC (requires Grafana plugin)
# Plugin: https://grafana.com/grafana/plugins/victoriametrics-logs-datasource/
resource "grafana_data_source" "victorialogs" {
  name = "VictoriaLogs-${var.vps_name}"
  type = "victoriametrics-logs-datasource"
  url  = "http://victoria-logs:9428" # Local URL inside the VPS network

  # PDC Configuration
  json_data_encoded = jsonencode({
    enableSecureSocksProxy   = true
    secureSocksProxyUsername = var.pdc_cluster_id
  })

  http_headers = {
    "X-Pdc-Connection" = var.pdc_cluster_id
  }
}

# 3. Create Folder for this VPS
resource "grafana_folder" "vps_folder" {
  title = "VPS Monitoring (${var.vps_name})"
}

locals {
  dashboards_dir = "${path.module}/../../../../common/dashboards"
  dashboards = {
    for f in fileset(local.dashboards_dir, "*.json") :
    f => jsondecode(file("${local.dashboards_dir}/${f}"))
  }
}

# 4. Deploy Dashboards to this Folder
resource "grafana_dashboard" "dashboards" {
  for_each = local.dashboards

  folder = grafana_folder.vps_folder.id

  # Replace UIDs in the JSON to match the newly created Datasources
  # AND update the Dashboard UID/Title to be unique per VPS
  config_json = jsonencode(merge(
    jsondecode(
      replace(
        replace(
          replace(
            replace(
              file("${local.dashboards_dir}/${each.key}"),
              "\"uid\": \"loki\"", "\"uid\": \"${grafana_data_source.loki.uid}\""
            ),
            "\"uid\": \"victorialogs\"", "\"uid\": \"${grafana_data_source.victorialogs.uid}\""
          ),
          "\"uid\": \"prometheus\"", "\"uid\": \"${grafana_data_source.prometheus.uid}\""
        ),
        "\"uid\": \"victoriametrics\"", "\"uid\": \"${grafana_data_source.victoriametrics.uid}\""
      )
    ),
    {
      # Grafana dashboard UID max length is 40 chars.
      # Keep the readable UID when it fits; otherwise fall back to a stable short hash.
      uid = length("${each.value.uid}-${var.vps_name}") <= 40 ? "${each.value.uid}-${var.vps_name}" : substr(md5("${each.value.uid}-${var.vps_name}"), 0, 32)
    }
  ))
}
