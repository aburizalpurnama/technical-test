run_postgres:
	docker run --name postgres14 -p 5434:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14

createdb:
	docker exec -it postgres14 createdb --username=root --owner=root technical-test

dropdb:
	docker exec -it postgres14 dropdb technical-test