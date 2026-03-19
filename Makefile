.PHONY: swarm gateway_network stack_central stack_common deploy_central deploy_common deploy_common_nginx deploy_common_alloy deploy_central_grafana dashboards_project dashboards_sync_all

# ==============================================================================
# COMMON COMMANDS
# ==============================================================================
swarm:
	docker swarm init --advertise-addr 127.0.0.1

gateway_network:
	@docker network inspect nginx_gateway_net >/dev/null 2>&1 || docker network create --driver overlay --attachable nginx_gateway_net

# ==============================================================================
# CENTRALIZED STACK (Central: Prometheus + Loki + Grafana)
# ==============================================================================
deploy_central: gateway_network
	COMMON_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.central.yml monitoring_central

stack_central: gateway_network
	COMMON_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.central.yml monitoring_central

# ==============================================================================
# COMMON STACK (Common: Nginx + Alloy)
# ==============================================================================
deploy_common: gateway_network
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.common.yml monitoring_common

stack_common: gateway_network
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.common.yml monitoring_common

deploy_common_nginx:
	# Chỉ force rolling update service nginx hien tai.
	# Khong ap dung cho thay doi compose nhu network/mount/ports.
	docker service update --force monitoring_common_nginx

deploy_common_alloy:
	# Chỉ force rolling update service alloy hien tai.
	# Khong ap dung cho thay doi compose nhu network/mount/ports.
	docker service update --force monitoring_common_alloy

deploy_central_grafana:
	# Chỉ force rolling update service grafana hien tai.
	# Khong ap dung cho thay doi compose nhu network/mount/ports.
	docker service update --force monitoring_central_grafana

# ==============================================================================
# DASHBOARDS
# ==============================================================================
dashboards_project:
	@test -n "$(PROJECT)" || (echo "PROJECT is required. Example: make dashboards_project PROJECT=my_stack" && exit 1)
	python3 scripts/new_project_dashboards.py "$(PROJECT)" $(if $(VPS),--vps "$(VPS)",) --overwrite

dashboards_sync_all:
	python3 scripts/sync_all_project_dashboards.py
