swarm:
	docker swarm init --advertise-addr 127.0.0.1
stack_full:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.yml monitoring
deploy:
	docker service update --force monitoring_nginx
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
