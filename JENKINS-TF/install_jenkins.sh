#!/bin/bash

# Update the package manager
sudo yum update -y

# Install Temurin 17 JDK
sudo rpm --import https://packages.adoptium.net/artifactory/api/gpg/key/public
sudo curl -o /etc/yum.repos.d/adoptium.repo https://packages.adoptium.net/artifactory/rpm/temurin.repo
sudo yum install temurin-17-jdk -y
/usr/bin/java --version

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# Install Docker
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
newgrp docker
sudo chmod 777 /var/run/docker.sock
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# Install Trivy
sudo yum install wget -y
sudo rpm --import https://aquasecurity.github.io/trivy-repo/rpm/public.key
sudo curl -s -o /etc/yum.repos.d/trivy.repo https://aquasecurity.github.io/trivy-repo/rpm/releases.repo
sudo yum install trivy -y

