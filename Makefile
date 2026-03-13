.PHONY: swarm stack_full_hybrid stack_nginx_hybrid deploy_nginx_hybrid hybrid_terraform_init hybrid_terraform_apply hybrid_terraform_destroy hybrid_terraform_fmt

# ==============================================================================
# COMMON COMMANDS
# ==============================================================================
swarm:
	docker swarm init --advertise-addr 127.0.0.1

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
