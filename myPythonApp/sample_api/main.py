#!/usr/bin/python3

import os
import pickle
import random
import sys
import time

import uvicorn
import yaml
from fastapi import FastAPI
from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel
from redis import Redis

yaml_settings = dict()
local_path = os.path.abspath(os.path.dirname(__file__))

if os.path.isfile(os.path.join(local_path, "config.yaml")):
    with open(os.path.join(local_path, "config.yaml"), "r") as ymlfile:
        yaml_settings = yaml.load(ymlfile, Loader=yaml.FullLoader)

    redis_password = yaml_settings['redis_password']
    redis_host = yaml_settings['redis_host']
    app_listen = yaml_settings['app_listen']
    app_port = yaml_settings['app_port']

else:
    print("ERROR - config.yaml file no found")
    sys.exit(1)


class Person(BaseModel):
    name: str
    city: str
    age: int


seconds = [0.5, 1, 1.5, 3]

app = FastAPI()

redis = Redis(
    host=redis_host,
    password=redis_password,
    db=0,
    socket_timeout=5
)


@app.get('/api/health')
def health():
    return jsonable_encoder({"message": "response ok"})


@app.get('/api/delay')
def delay():
    rnd_delay = random.choice(seconds)
    time.sleep(rnd_delay)
    return jsonable_encoder({"delay": str(rnd_delay) + "s"})


@app.post('/api/v1/people', response_model=Person)
def insert(p: Person):
    data = {"name": p.name, "city": p.city, "age": p.age}
    bin_data = pickle.dumps(data)

    redis.set(p.name, bin_data)
    return p


@app.get('/api/v1/people')
def list_all():
    response = []
    for key in redis.scan_iter():
        response.append(key.decode("utf-8"))
    return jsonable_encoder(response)


@app.get('/api/v1/people/{name}')
def person(name: str):
    print(name)
    bin_data = redis.get(name)
    if bin_data:
        data = pickle.loads(bin_data)
    else:
        data = {"message": "user unknown"}
    return jsonable_encoder(data)


@app.delete('/api/v1/people')
def clean_keys():
    count = 0
    for key in redis.scan_iter():
        redis.delete(key)
        count += 1
    response = {"elements deleted": count}
    return jsonable_encoder(response)


if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host=app_listen,
        port=app_port,
        log_level="debug"
    )
