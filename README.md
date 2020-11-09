# Simple Web Application and database deployed on eks cluster

This repo contain following 
  - Terraform script to create infra in AWS like vpc, subnets, EKS etc.
  - mediawiki app and corresponding helm chart 
  - Sample web app using python and own Dockerfile (statefullset with rolling update) 
  - [MySQL] database Dockerfile and corresponding helm chart (Deployment with persistent volume)
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

    run following command to create vpc, subnets and eks cluster and install webapp and mysqldb helm chart 
   
    ./runme.sh

    
## 3. verify the app

 1. Get the MediaWiki URL by running:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w mediawiki'

  export SERVICE_IP=$(kubectl get svc --namespace default mediawiki --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
  
  export SERVICE_PORT=$(kubectl get svc --namespace default mediawiki -o jsonpath="{.spec.ports[0].nodePort}")
  
  echo "Mediawiki URL: http://$SERVICE_IP:$SERVICE_PORT/"

 2. Get your MediaWiki login credentials by running:

    echo Username: user
    
   echo Password: $(kubectl get secret --namespace default mediawiki -o jsonpath="{.data.mediawiki-password}" | base64 --decode)

Important: Before you access NodeIP:NodePort from an outside cluster, you must enable the security group of the nodes to allow incoming traffic through port SERVICE_PORT.

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
  
  -- Own dockerfile for mediawiki and resolve crashloopback error of mediawiki pod

  -- Install third party framework like istio to support canary deployment and prometheus for monitoring ( ./third_party_framework/install_me.sh)
  
  -- create terraform module for AWS infra deployment in multiple region and remote state management in s3
  
  -- Jenkinsfile for multi branch pipeline
