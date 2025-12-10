terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 3.0.0"
    }
  }
}

# --- KHAI BÁO CÁC BIẾN ĐẦU VÀO ---

variable "grafana_url" {
  type        = string
  description = "URL của trang Grafana Cloud"
}

variable "grafana_auth" {
  type        = string
  description = "Token Admin Service Account"
  sensitive   = true
}

variable "vps_name" {
  type        = string
  description = "Tên định danh cho VPS này (ví dụ: vps-hanoi-01)"
}

variable "pdc_cluster_id" {
  type        = string
  description = "ID của PDC Cluster kết nối tới VPS này"
}

# --- BẮT ĐẦU CẤU HÌNH ---

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}

# Gọi Module VPS cho VPS hiện tại
module "vps_monitoring" {
  source = "./modules/vps"

  vps_name       = var.vps_name
  pdc_cluster_id = var.pdc_cluster_id
}
