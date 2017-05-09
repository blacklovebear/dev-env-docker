# 环境启动命令
```
bash ./start-all.sh main
```

# GitLab 
## 访问地址
http://<host-ip>:8929
default username:passwd root:exmind2017

# sonarqube
## 访问地址
http://172.18.84.231:9000
default username:passwd admin:admin

# nexus
## 访问地址
http://172.18.84.231:8081
default username:passwd admin:admin123

# tomcat
## 访问地址
http://172.18.84.231
## deploy 时用户名:密码
admin:admin

# jenkins
## 访问地址
http://172.18.84.231:8080

## Get Password
```
docker exec jenkins sh -c "cat /var/jenkins_home/secrets/initialAdminPassword"
```

## docker 镜像中已经安装插件，不需再安装

# mvn config sonar
$SONAR_MAVEN_GOAL -Dsonar.host.url=$SONAR_HOST_URL