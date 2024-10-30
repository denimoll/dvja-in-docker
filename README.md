# dvja in docker
## Description
Summary: dvja in tomcat on https in docker space.

Project which build [dvja](https://github.com/appsecco/dvja) and deploy in tomcat server. Dvja connect with mysql from another docker container. And tomcat is behind the nginx proxy (nginx in one more container also).

## Getting started
First you must create your own certificates in 'ssl' directory:
```
mkdir ssl
cd ssl/
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout tool.key -out tool.crt
```
Then you can start app in the main directory with command:
```
docker-compose up -d
```
