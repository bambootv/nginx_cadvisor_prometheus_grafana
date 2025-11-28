.PHONY: swarm stack_host stack_cloud deploy_host deploy_cloud apply_rules terraform_init terraform_apply terraform_destroy terraform_fmt

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
