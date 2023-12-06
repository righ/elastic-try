
.PHONY: up
up:
	docker compose up

.PHONY: python 
python:
	docker compose exec data python3

.PHONY: bash-es
bash-es:
	docker compose exec elasticsearch bash

.PHONY: bash-data
bash-data:
	docker compose exec data bash

.PHONY: generate
generate:
	docker compose exec data python3 fake_data.py

.PHONY: data
data:
	curl -H "Content-Type: application/json" -X POST http://localhost:9200/profile1/_bulk?pretty --data-binary @data/fake_data.jsonl

.PHONY: truncate-1
truncate-1:
	curl -H "Content-Type: application/json" -X DELETE http://localhost:9200/profile1/

.PHONY: reset-1
reset-1: truncate-1 data

.PHONY: indices
indices:
	curl -H "Content-Type: application/json" -X GET http://localhost:9200/_cat/indices?v

.PHONY: aliases
aliases:
	curl -H "Content-Type: application/json" -X GET http://localhost:9200/_cat/aliases?v

.PHONY: mapping
mapping:
	curl -H "Content-Type: application/json" -X GET http://localhost:9200/profile1/_mapping?pretty

.PHONY: sql
sql:
	curl -H "Content-Type: application/json" -X POST http://localhost:9200/_sql?pretty --data-binary @queries/sql.json

.PHONY: all-1
all-1:
	curl -H "Content-Type: application/json" -X POST http://localhost:9200/profile1/_search?pretty -d '{"query": {"match_all": {}}}'

.PHONY: search-1
search-1:
	curl -H "Content-Type: application/json" -X POST http://localhost:9200/profile1/_search?pretty --data-binary @queries/search.json

.PHONY: search-2
search-2:
	curl -H "Content-Type: application/json" -X POST http://localhost:9200/profile2/_search?pretty --data-binary @queries/@search.json


