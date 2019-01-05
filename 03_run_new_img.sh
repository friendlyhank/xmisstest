#!/bin/bash

docker stop xmiss

docker rm xmiss

docker run -d --name=xmiss -p 8111:8888 xmiss