#!/usr/bin/bash

open-host-port() {
    # tomcat
    firewall-cmd --zone=public --add-port=80/tcp --permanent
    # jenkins
    firewall-cmd --zone=public --add-port=8080/tcp --permanent
    # gitlab
    firewall-cmd --zone=public --add-port=8929/tcp --permanent
    firewall-cmd --zone=public --add-port=2289/tcp --permanent
    # sonarqube
    firewall-cmd --zone=public --add-port=9000/tcp --permanent
    # nexus
    firewall-cmd --zone=public --add-port=8081/tcp --permanent
    firewall-cmd --reload
}

start-compose() {
    set -a
    # get host ip : 172.18.84.231
    local host_ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

    if [ -e ./docker-compose.yml ]; then
        GITLAB_EXTERNAL_IP=$host_ip docker-compose up -d
    else
        echo "docker-compose.yml doesn't exist"
    done
}

clean-all-container() {
    docker stop $(docker ps -a -q) && docker rm -v $(docker ps -a -q)
}


main() {
    open-host-port
    clean-all-container
    start-compose
}

$@