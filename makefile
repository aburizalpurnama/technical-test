run_postgres:
	docker run --name postgres14 -p 5434:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14

createdb:
	docker exec -it postgres14 createdb --username=postgres --owner=postgres technical_test

dropdb:
	docker exec -it postgres14 dropdb --username=postgres technical_test

migrateup:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5434/technical_test?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5434/technical_test?sslmode=disable" -verbose down

up:
	docker compose up -d

down:
	docker compose down