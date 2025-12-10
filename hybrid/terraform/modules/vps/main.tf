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

# 3. Create Folder for this VPS
resource "grafana_folder" "vps_folder" {
  title = "VPS Monitoring (${var.vps_name})"
}

# 4. Deploy Dashboards to this Folder
resource "grafana_dashboard" "dashboards" {
  for_each = fileset("${path.module}/../../../../common/dashboards", "*.json")

  folder = grafana_folder.vps_folder.id

  # Replace UIDs in the JSON to match the newly created Datasources
  config_json = replace(
    replace(
      file("${path.module}/../../../../common/dashboards/${each.key}"),
      "\"uid\": \"loki\"", "\"uid\": \"${grafana_data_source.loki.uid}\""
    ),
    "\"uid\": \"prometheus\"", "\"uid\": \"${grafana_data_source.prometheus.uid}\""
  )
}
