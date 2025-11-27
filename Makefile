.PHONY: swarm stack_host stack_cloud deploy deploy_cloud stack_nginx apply_rules apply_dashboards terraform_init terraform_apply terraform_destroy terraform_fmt

swarm:
	docker swarm init --advertise-addr 127.0.0.1

stack_host:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.yml monitoring

stack_cloud:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.cloud.yml monitoring_cloud

deploy:
	docker service update --force monitoring_nginx

deploy_cloud:
	docker service update --force monitoring_cloud_nginx

stack_nginx:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.yml monitoring

apply_rules:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)/loki_rules":/data \
	-w /data \
	--entrypoint /bin/sh \
	curlimages/curl:latest \
	-c 'curl -v -X POST -H "Content-Type: application/yaml" -u "$$GRAFANA_CLOUD_LOKI_USER:$$GRAFANA_CLOUD_API_KEY" --data-binary @loki-rules.yaml "$$GRAFANA_CLOUD_LOKI_RULES_URL"'

apply_dashboards:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/terraform \
	hashicorp/terraform:light apply -auto-approve

terraform_init:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/terraform \
	hashicorp/terraform:light init

terraform_apply: apply_dashboards

terraform_destroy:
	docker run --rm \
	--env-file .env \
	-v "$(CURDIR)":/workspace \
	-w /workspace/terraform \
	hashicorp/terraform:light destroy -auto-approve

terraform_fmt:
	docker run --rm \
	-v "$(CURDIR)":/workspace \
	-w /workspace/terraform \
	hashicorp/terraform:light fmt
