.PHONY: swarm stack_central stack_common deploy_common_nginx deploy_common_alloy

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
