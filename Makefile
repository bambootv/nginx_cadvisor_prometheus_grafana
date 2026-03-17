.PHONY: swarm stack_central stack_common deploy_common_nginx deploy_common_alloy deploy_central_grafana dashboards_project dashboards_sync_all

# ==============================================================================
# COMMON COMMANDS
# ==============================================================================
swarm:
	docker swarm init --advertise-addr 127.0.0.1

# ==============================================================================
# CENTRALIZED STACK (Central: Prometheus + Loki + Grafana)
# ==============================================================================
stack_central:
	COMMON_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.central.yml monitoring_central

# ==============================================================================
# COMMON STACK (Common: Nginx + Alloy)
# ==============================================================================
stack_common:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.common.yml monitoring_common

deploy_common_nginx:
	docker service update --force monitoring_common_nginx

deploy_common_alloy:
	docker service update --force monitoring_common_alloy

deploy_central_grafana:
	docker service update --force monitoring_central_grafana

# ==============================================================================
# DASHBOARDS
# ==============================================================================
dashboards_project:
	@test -n "$(PROJECT)" || (echo "PROJECT is required. Example: make dashboards_project PROJECT=my_stack" && exit 1)
	python3 scripts/new_project_dashboards.py "$(PROJECT)" $(if $(VPS),--vps "$(VPS)",) --overwrite

dashboards_sync_all:
	python3 scripts/sync_all_project_dashboards.py
