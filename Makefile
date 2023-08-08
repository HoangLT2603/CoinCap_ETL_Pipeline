docker-spin-up:
	docker compose --env-file env up --build -d

sleeper:
	sleep 15

up: docker-spin-up sleeper warehouse-migration

down: 
	docker compose --env-file env down

db-migration:
	@read -p "Enter migration name:" migration_name; docker exec pipelinerunner yoyo new ./migrations -m "$$migration_name"

warehouse-migration:
	docker exec pipelinerunner yoyo develop --no-config-file --database postgres://nvhuser:123456@datawarehouse:5432/finance ./migrations