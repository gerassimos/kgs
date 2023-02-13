
## Creating an IAM OIDC provider for your cluster
 - (https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)
```shell  
oidc_id=$(aws eks describe-cluster --name kubeflow-test-01 --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
eksctl utils associate-iam-oidc-provider --cluster kubeflow-test-01 --approve
```

## Creating the Amazon EBS CSI driver IAM role for service accounts
 - https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
 - The role `AmazonEKS_EBS_CSI_DriverRole_02` already exists
```shell
aws eks describe-cluster \
  --name kubeflow-test-01 \
  --query "cluster.identity.oidc.issuer" \
  --output text
aws iam create-role \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --assume-role-policy-document file://"aws-ebs-csi-driver-trust-policy.json"
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --role-name AmazonEKS_EBS_CSI_DriverRole_04
aws eks create-addon --cluster-name kubeflow-test-01 --addon-name aws-ebs-csi-driver \
  --service-account-role-arn arn:aws:iam::536686139266:role/AmazonEKS_EBS_CSI_DriverRole_03  
kubectl annotate serviceaccount ebs-csi-controller-sa \
    -n kube-system \
    eks.amazonaws.com/role-arn=arn:aws:iam::536686139266:role/AmazonEKS_EBS_CSI_DriverRole_03
kubectl rollout restart deployment ebs-csi-controller -n kube-system
```
eksctl create addon --name aws-ebs-csi-driver --cluster kubeflow-test-01 --service-account-role-arn arn:aws:iam::536686139266:role/AmazonEKS_EBS_CSI_DriverRole --force

aws eks describe-cluster \
--name kubeflow-test-01 \
--query "cluster.identity.oidc.issuer" \
--output text