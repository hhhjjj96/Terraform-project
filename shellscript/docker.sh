#!/bin/bash
docker push hhhjjj96/webserver:latest
docker run -d -p 80:80 -p 3306:3306 --privileged --name web hhhjjj96/webserver init
