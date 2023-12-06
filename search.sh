#!/bin/bash

set -x

if [ ! -f "$1" ]; then
  exit 1
fi

curl --data-binary "@$1" -H "Content-Type: application/yaml" -H "Accept: application/json" -X POST http://localhost:9200/profile1/_search?pretty
