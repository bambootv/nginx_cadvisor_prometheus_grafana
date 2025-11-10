# VPS Intel/AMD 64-bit (Linux)
build_linux:
	docker build -t nginx:stub_status --platform linux/amd64 .
# VPS Apple Silicon (Mac)
build_mac:
	docker build -t nginx:stub_status --platform linux/arm64 .

# ============== Original Stack (7 containers) ==============
up:
	docker compose down && docker compose up -d nginx node_exporter nginx_prometheus_exporter cadvisor telegraf prometheus grafana
dev:
	docker compose down && docker compose up nginx node_exporter nginx_prometheus_exporter cadvisor telegraf prometheus grafana

# ============== Optimized Stack: Alloy + Telegraf (4 containers) ==============
up-optimized:
	@echo "🚀 Starting Optimized Stack: Alloy + Telegraf"
	@echo "   ✅ Alloy: node_exporter + cadvisor"
	@echo "   ✅ Telegraf: nginx metrics + access logs"
	@echo "   ❌ Removed: node_exporter, cadvisor, nginx_prometheus_exporter"
	docker compose -f docker-compose.optimized.yml down
	docker compose -f docker-compose.optimized.yml up -d
	@echo ""
	@echo "✅ Stack is running!"
	@echo "   • Alloy UI: http://localhost:12345"
	@echo "   • Telegraf metrics: http://localhost:9273/metrics"
	@echo "   • Prometheus: http://localhost:9090"
	@echo "   • Grafana: http://localhost:3456"

dev-optimized:
	@echo "🚀 Starting Optimized Stack in foreground..."
	docker compose -f docker-compose.optimized.yml down
	docker compose -f docker-compose.optimized.yml up

down-optimized:
	docker compose -f docker-compose.optimized.yml down

logs-optimized:
	docker compose -f docker-compose.optimized.yml logs -f

down:
	docker compose down

# ============== Docker Swarm - Original Stack (7 containers) ==============
swarm:
	docker swarm init --advertise-addr 127.0.0.1

stack:
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.swarm.yml monitoring

deploy:
	docker service update --force monitoring_nginx

stack_nginx_only:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.swarm.yml monitoring

# ============== Docker Swarm - Optimized Stack (4 containers) ==============
stack-optimized:
	@echo "🚀 Deploying Optimized Stack to Swarm: Alloy + Telegraf"
	@echo "   ✅ Alloy: node_exporter + cadvisor"
	@echo "   ✅ Telegraf: nginx metrics + access logs"
	@echo "   ❌ Removed: node_exporter, cadvisor, nginx_prometheus_exporter"
	COMMON_REPLICAS=1 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.loki.swarm.yml monitoring
	@echo ""
	@echo "✅ Stack deployed!"
	@echo "   • Alloy UI: http://localhost:12345"
	@echo "   • Telegraf metrics: http://localhost:9273/metrics"
	@echo "   • Prometheus: http://localhost:9090"
	@echo "   • Grafana: http://localhost:3456"

stack-optimized-nginx-only:
	COMMON_REPLICAS=0 NGINX_REPLICAS=1 docker stack deploy --detach=false --compose-file docker-compose.swarm.loki.optimized.yml monitoring

stack-remove:
	docker stack rm monitoring

stack-ps:
	docker stack ps monitoring

stack-services:
	docker stack services monitoring
