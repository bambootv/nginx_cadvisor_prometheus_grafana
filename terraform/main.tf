# ./terraform/main.tf

variable "grafana_url" {
  type        = string
}
variable "grafana_auth" {
  type        = string
  sensitive   = true
}

terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 3.0"
    }
  }
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}

# --- QUẢN LÝ DASHBOARDS ---

resource "grafana_folder" "provisioned_dashboards" {
  title = "Provisioned Dashboards"
}

resource "grafana_dashboard" "all_dashboards" {
  for_each = fileset("${path.module}/dashboards", "*.json")

  folder      = grafana_folder.provisioned_dashboards.uid
  config_json = file("${path.module}/dashboards/${each.value}")
  overwrite   = true
}
