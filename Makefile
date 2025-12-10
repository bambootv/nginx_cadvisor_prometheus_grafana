.PHONY: swarm stack_full_host stack_nginx_host deploy_nginx_host stack_full_hybrid stack_nginx_hybrid deploy_nginx_hybrid hybrid_terraform_init hybrid_terraform_apply hybrid_terraform_destroy hybrid_terraform_fmt stack_full_cloud stack_nginx_cloud deploy_nginx_cloud apply_rules terraform_init terraform_apply terraform_destroy terraform_fmt

# ==============================================================================
# COMMON COMMANDS
# ==============================================================================
swarm:
	docker swarm init --advertise-addr 127.0.0.1

# ==============================================================================
# SELF-HOSTED STACK (Prometheus + Loki + Grafana on local)
# ==============================================================================
stack_full_host:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.selfhost.yml monitoring_host

stack_nginx_host:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.selfhost.yml monitoring_host

deploy_nginx_host:
	docker service update --force monitoring_host_nginx

# ==============================================================================
# HYBRID STACK (Prometheus + Loki on local, Grafana on Cloud via PDC)
# ==============================================================================
stack_full_hybrid:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.hybrid.yml monitoring_hybrid

stack_nginx_hybrid:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.hybrid.yml monitoring_hybrid

deploy_nginx_hybrid:
	docker service update --force monitoring_hybrid_nginx

# Terraform for Hybrid Mode (VPS Setup)
hybrid_terraform_init:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/hybrid/terraform \
	hashicorp/terraform:light init

hybrid_terraform_apply:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/hybrid/terraform \
	hashicorp/terraform:light apply -auto-approve

hybrid_terraform_destroy:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/hybrid/terraform \
	hashicorp/terraform:light destroy -auto-approve

hybrid_terraform_fmt:
	docker run --rm \
	-v "$(CURDIR)":/workspace \
	-w /workspace/hybrid/terraform \
	hashicorp/terraform:light fmt


# ==============================================================================
# CLOUD STACK (Grafana Cloud)
# ==============================================================================
stack_full_cloud:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.cloud.yml monitoring_cloud

stack_nginx_cloud:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.cloud.yml monitoring_cloud

deploy_nginx_cloud:
	docker service update --force monitoring_cloud_nginx

apply_rules:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)/cloud/loki_rules":/data \
	-w /data \
	--entrypoint /bin/sh \
	curlimages/curl:latest \
	-c 'curl -v -X POST -H "Content-Type: application/yaml" -u "$$GRAFANA_CLOUD_LOKI_USER:$$GRAFANA_CLOUD_API_KEY" --data-binary @loki-rules.yaml "$$GRAFANA_CLOUD_LOKI_RULES_URL"'

# Terraform for Cloud Dashboards
terraform_init:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/cloud/terraform \
	hashicorp/terraform:light init

terraform_apply:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/cloud/terraform \
	hashicorp/terraform:light apply -auto-approve

terraform_destroy:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/cloud/terraform \
	hashicorp/terraform:light destroy -auto-approve

terraform_fmt:
	docker run --rm \
	-v "$(CURDIR)":/workspace \
	-w /workspace/cloud/terraform \
	hashicorp/terraform:light fmt
