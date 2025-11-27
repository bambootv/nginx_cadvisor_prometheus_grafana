swarm:
	docker swarm init --advertise-addr 127.0.0.1
stack_full:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.yml monitoring
deploy:
	docker service update --force monitoring_nginx
stack_nginx:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.yml monitoring
