
## kubectl
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/

## eksctl tar.gz
wget https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz
tar -zxvf eksctl_Linux_amd64.tar.gz

## .aws set credentials and config
cd ~/.aws/
vim credentials
vim config

## aws cli install
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
cd aws/
./install

## aws-iam-authenticator
# curl -o aws-iam-authenticator https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64

chmod +x ./aws-iam-authenticator
mv aws-iam-authenticator /usr/local/bin/

## aws cli examples 
aws s3 ls

## aws eks
aws eks list-clusters
aws eks update-kubeconfig --name=gm-eks-01

