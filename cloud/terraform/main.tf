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

variable "loki_ds_name" {
  type        = string
  description = "Tên Datasource Loki trên Cloud"
}

variable "prom_ds_name" {
  type        = string
  description = "Tên Datasource Prometheus trên Cloud"
}

variable "folder_title" {
  type        = string
  description = "Tên thư mục Dashboard muốn tạo"
  default     = "Infrastructure Dashboards" # Giá trị mặc định nếu quên điền
}

# --- BẮT ĐẦU CẤU HÌNH ---

provider "grafana" {
  url  = var.grafana_url  # <--- Đọc từ biến
  auth = var.grafana_auth # <--- Đọc từ biến
}

# 1. Lấy thông tin Datasource từ tên biến truyền vào
data "grafana_data_source" "loki" {
  name = var.loki_ds_name
}

data "grafana_data_source" "prom" {
  name = var.prom_ds_name
}

# 2. Tạo Folder với tên động
resource "grafana_folder" "dynamic_folder" {
  title = var.folder_title
}

# 3. Đẩy Dashboard
resource "grafana_dashboard" "deploy_dashboards" {
  for_each = fileset("${path.module}/../../common/dashboards", "*.json")
  folder   = grafana_folder.dynamic_folder.id

  # Magic Replace UID
  config_json = replace(
    replace(
      file("${path.module}/../../common/dashboards/${each.key}"),
      "\"uid\": \"loki\"", "\"uid\": \"${data.grafana_data_source.loki.uid}\""
    ),
    "\"uid\": \"prometheus\"", "\"uid\": \"${data.grafana_data_source.prom.uid}\""
  )
}
