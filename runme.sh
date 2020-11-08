echo "Creating EKS cluster"
cd terraform-eks/
terraform init;
terraform plan;
terraform apply -auto-approve;

/usr/local/aws-cli/v2/current/bin/aws eks --region ap-south-1 update-kubeconfig --name eks-demo

echo "installing mysql service in EKS"
cd ../helm
helm install mysql ./mysql

count=0
ready=$(kubectl get pods | awk '{print $2}' | tail -n +2) # prints 1/1 or 0/1 for each pod
until [[ ${ready} == "1/1" ]]
do
  echo "Waiting for pods to be ready."
  sleep 3
  if [ $count -eq 5 ]
   then
      break
   fi
  count=`expr $count + 1`
done

echo "installing webapp service in EKS"

helm install webapp ./webapp
