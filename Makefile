up:
	@echo "===================================================================="
	@echo "Start registry in the background"
	@echo "===================================================================="
	@docker-compose up --build -d

stop:
	@echo "===================================================================="
	@echo "Stop registry"
	@echo "===================================================================="
	@docker-compose stop

purge:  stop
	@echo "===================================================================="
	@echo "Down and remove image"
	@echo "===================================================================="
	@docker-compose down
