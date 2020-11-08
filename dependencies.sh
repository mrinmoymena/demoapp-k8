echo "installing terraform.."
cd /usr/local/bin
wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
unzip terraform_0.13.5_linux_amd64.zip

echo "Installing aws cli"
cd ~
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
mkdir ~/.aws
put aws credentials secret key and access key under ~/.aws/credentials
export PATH=$PATH:/usr/local/aws-cli/v2/current/bin

echo "Installing kubectl.."

cd /usr/local/bin/
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" 
/usr/local/aws-cli/v2/current/bin/aws eks --region ap-south-1 update-kubeconfig --name eks-demo

echo "Installing helm..."
cd /usr/local/bin/
wget https://get.helm.sh/helm-v3.4.0-linux-amd64.tar.gz
tar -xvzf helm-v3.4.0-linux-amd64.tar.gz
mv linux-amd64/helm .
