cd ~/demoapp-k8/terraform-eks/
terraform init;
terraform plan;
terraform apply -auto-approve;


cd ~/demoapp-k8/helm
helm install mysql ./mysql

ready=$(kubectl get pods | awk '{print $2}' | tail -n +2) # prints 1/1 or 0/1 for each pod
until [[ ${ready} == "1/1" ]]
do
  echo "Waiting for pods to be ready."
  sleep 3
done

helm install webapp ./webapp
