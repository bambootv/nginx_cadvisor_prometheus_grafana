build:
	docker build -t nginx:stub_status .
down:
	docker compose down
up:
	docker compose down && docker compose up -d nginx node_exporter nginx_prometheus_exporter cadvisor telegraf prometheus grafana
dev:
	docker compose down && docker compose up nginx node_exporter nginx_prometheus_exporter cadvisor telegraf prometheus grafana
prod:
	docker compose down && docker compose -f docker-compose.prod.yml up -d nginx nginx_prometheus_exporter cadvisor telegraf prometheus grafana
swarm:
	docker swarm init --advertise-addr 127.0.0.1
stack:
	docker stack deploy --detach=false --compose-file docker-compose.swarm.yml monitoring
deploy:
	docker service update --force monitoring_nginx
