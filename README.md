# Simple Web Application and database deployed on eks cluster

This repo contain following 
  - Terraform script to create infra in AWS like vpc, subnets, EKS etc.
  - simple web application using [Python Flask] Dockerfile and corresponding helm chart (statefull with rolling update) 
  - [MySQL] database Dockerfile and corresponding helm chart (with persistent volume)
  - This repo is used to demonstrate of deployment of those application in EKS cluster.


## 1. Install all required dependencies
- Login as root (sudo su -)
- clone the repo: git clone https://github.com/mrinmoymena/demoapp-k8
- Setup AWS credentials file on Linux machine (~/.aws/credentials)
- Sample content:
     
     [default]
     
     aws_access_key_id=
     
     aws_secret_access_key=
- Install following dependencies by running dependencies.sh
    
    ./dependencies.sh

## 2. Create infra and Install application

    run ./runme.sh

    
## 3. verify the app

run following command to get EXTERNAL-IP
  
   kubectl get nodes -o wide

Verify following on browser

  http://{EXTERNAL-IP}:31000
  http://{EXTERNAL-IP}:31000/how%20are%20you

Important: Before you access NodeIP:NodePort from an outside cluster, you must enable the security group of the nodes to allow incoming traffic through port 31000.

## 4. Additional Information
Build docker image and run mysqldb image locally
    
    cd mysqldb
    
    docker build -t my-mysql .
    
    docker run -d -p 3306:3306 --name my-mysql -e MYSQL_ROOT_PASSWORD=supersecret my-mysql

Build docker image and run webapp image locally
    
    cd webapp
    
    docker build -t my-app .
    
    docker run -d -p 5000:5000 --name my-app my-app

## 5. Features under developement

  -- Install third party framework like istio to support canary deployment and prometheus for monitoring ( ./third_party_framework/install_me.sh)
  
  -- create terraform module for AWS infra deployment in multiple region and remote state management in s3
  
  -- Jenkinsfile for multi branch pipeline
