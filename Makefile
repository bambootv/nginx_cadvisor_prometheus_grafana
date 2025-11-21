swarm:
	docker swarm init --advertise-addr 127.0.0.1
stack:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --compose-file docker-compose.prod.yml monitoring
deploy:
	docker service update --force monitoring_nginx
stack_nginx_only:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --compose-file docker-compose.prod.yml monitoring
