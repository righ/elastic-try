#!/usr/bin/env python
import argparse
import json
from decimal import Decimal
from datetime import datetime, date

from faker import Faker

fake = Faker('ja-JP')


def default(obj):
    if isinstance(obj, datetime):
        return obj.isoformat()
    if isinstance(obj, date):
        return obj.isoformat()
    if isinstance(obj, Decimal):
        return float(obj)
    if isinstance(obj, (list, tuple)):
        return [default(o) for o in obj]
    return None


def generate_fake_data(num_records, path):
    data = []
    for i in range(num_records):
        id = fake.uuid4()
        profile = {
            **fake.profile(),
            "id": id,
            "serial_number": i,
            "saving": fake.random_number(),
            "saving": fake.random_number(),
            "married": fake.boolean(),
            "favirite_words": fake.words(),
            "note": fake.text(),
            "ip_address": fake.ipv4(),
            "created_at": fake.date_time_this_year(),
            "updated_at": fake.date_time_this_month(),
        }
        data += [{"index" : {"_id" : id }}, profile]
    
    jsonl = "\n".join(json.dumps(d, ensure_ascii=False, default=default) for d in data) + "\n"
    with open(path, "w") as f:
        f.write(jsonl)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--num", type=int, default=1000)
    parser.add_argument("--path", type=str, default="fake_data.jsonl")
    args = parser.parse_args()

    generate_fake_data(args.num, args.path)
