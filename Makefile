# VPS Intel/AMD 64-bit (Linux)
build_linux:
	docker build -t nginx:stub_status --platform linux/amd64 .
# VPS Apple Silicon (Mac)
build_mac:
	docker build -t nginx:stub_status --platform linux/arm64 .

swarm:
	docker swarm init --advertise-addr 127.0.0.1
stack:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.prod.yml monitoring
deploy:
	docker service update --force monitoring_nginx
stack_nginx_only:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.prod.yml monitoring
