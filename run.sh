# start jenkins
docker run -itd -p 8080:8080 --name jenkins -v /etc/localtime:/etc/localtime:ro -P stephenreed/java8-jenkins-maven-git-nano 

# open port 
firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload

# run 
docker exec jenkins sh -c "nohup java -jar opt/jenkins.war &"
# jenkins 设置，jdk, maven 配置路径的时候只要使用变量 $JAVA_HOME  $MAVEN_HOME就ok，镜像里面已经定义里这两个变量
# test project 
# https://github.com/bingyue/easy-springmvc-maven

# clean 
docker stop jenkins && docker rm -v jenkins



docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home jenkins


docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home registry.cn-hangzhou.aliyuncs.com/tospur/jenkins


docker exec jenkins sh -c "cat /var/jenkins_home/secrets/initialAdminPassword"


c67c6bac7b714641beabafd582715c47


JENKINS_HOST=localhost:8080
curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'

JENKINS_HOST=admin:8250af2dd26040e1b58cde99258badc4@localhost:8080
curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'


http://172.18.84.231:8080

# start nginx
# more function look: https://hub.docker.com/_/nginx/
# docker run --name some-nginx -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name nginx -d -p 8080:80 nginx
#clean 
docker stop nginx && docker rm -v nginx


# start redis
docker run --name redis -d redis
# test
docker run -it --link redis:redis --rm redis redis-cli -h redis -p 6379


# start tomcat
# more function :https://hub.docker.com/_/tomcat/
docker run -itd --name tomcat -p 8080:8080 tomcat:8.0
#clean 
docker stop tomcat && docker rm -v tomcat


# start mysql 
docker run --name mysql -v /var/lib/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql

# test connection
docker run -it --link mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
# clean
docker stop mysql && docker rm -v mysql


# start gitlab zh
docker run --detach \
    --hostname gitlab.example.com \
    --publish 8929:8929 --publish 2289:22 \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://172.18.84.231:8929'; gitlab_rails['gitlab_shell_ssh_port']=2289;" \
    --name gitlab \
    --restart always \
    --privileged \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    registry.cn-hangzhou.aliyuncs.com/tospur/docker-gitlab-ce

# open port
firewall-cmd --zone=public --add-port=8929/tcp --permanent
firewall-cmd --zone=public --add-port=2289/tcp --permanent
firewall-cmd --reload
# clean
docker stop gitlab && docker rm -v gitlab


# start sonar
docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube
# open port
firewall-cmd --zone=public --add-port=9000/tcp --permanent
firewall-cmd --reload

# analysis code 
# default upload result to localhost:9000
mvn sonar:sonar
# clean
docker stop sonarqube && docker rm -v sonarqube


# start nexus
# use -v have an exception
docker run -d -p 8081:8081 --name nexus sonatype/nexus
# visit
# http://172.18.84.231:8081/nexus/
# name:admin, passwd:admin123

# clean
docker stop nexus && docker rm -v nexus

# open port
firewall-cmd --zone=public --add-port=8081/tcp --permanent
firewall-cmd --reload