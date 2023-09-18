## eksctl 01 - create / get / delete
```shell
eksctl create cluster --name gm-eks-01 --region us-east-1 
eksctl create cluster --name gm-eks-02 --nodes=3 --version 1.22 --region us-east-1 --zones us-east-1a,us-east-1c
eksctl create cluster -f cluster.yml
eksctl get cluster
eksctl delete cluster --name gm-eks-01
```

 - Notes:
 - aws console -> CloudFormation -> Stacks (events)
 - Dedicated new VPC and components are created  
   - Security groups
   - Elastic IPs
   - EC2 Autoscaling group
   - nodes with public IPs 
 - The `eksctl create` will update automatically update the kubeconfig file

## eksctl 01b - kube config
```shell
eksctl utils write-kubeconfig --cluster=gm-eks-01 --kubeconfig=/tmp/config
```

## eksctl 02 - scale nodegroup
 - Scaling a nodegroup
 - Adding a nodegroup
 - Deleting a nodegroup (drain nodes) 

## eksctl 03 - create/list/delete nodegroup
 - [Adding a nodegroup](https://eksctl.io/usage/managing-nodegroups/#creating-a-nodegroup-from-a-config-file)
 - Notes:
   - Our yaml file `cluster-02-add-ng.yml` contains the original nodegroup (used during cluster creation)
   - and an a new nodegroup `ng-2-dynamic`
   - Because we are using the `--include` option other node nodegroup defined in the yaml file are ignored
   - Another way is to use a yaml file which contains only the new nodegroup that we want to create 

```shell
eksctl get nodegroup --cluster gm-eks-01
eksctl create nodegroup --config-file=cluster-02-add-ng.yml  
eksctl create nodegroup --config-file=cluster-02-add-ng.yml  --include=ng-2-dynamic
eksctl delete nodegroup --cluster=gm-eks-01 --name=ng-1
```

- [Scaling a nodegroup](https://eksctl.io/usage/managing-nodegroups/#scaling-a-single-nodegroup)
  The `scale` command can be executed on an existing nodegroup (only between min and max)
```shell
eksctl scale nodegroup --cluster=gm-eks-01 --nodes=1 --name=ng-2-dynamic
```


## csi setup (old not valid anymore)
 - [csi-readly](csi/readme.md)

## csi setup (new)
 - From EKS web console -> Addons -> add `Amazon EBS CSI Driver`  Version v1.22.0-eksbuild.2
 - Add policy to worker node role
 - Find the worker node role 
```shell
kubectl -n kube-system describe configmap aws-auth | grep role
  rolearn: arn:aws:iam::536686139266:role/eksctl-kubeflow-test-03-nodegroup--NodeInstanceRole-qqI6B4b67Jse
```
- Add this policy to the role. 
```json
{
 "Version": "2012-10-17",
 "Statement": [{
  "Sid": "VisualEditor0",
  "Effect": "Allow",
  "Action": [
   "ec2:CreateVolume",
   "ec2:DeleteVolume",
   "ec2:DetachVolume",
   "ec2:AttachVolume",
   "ec2:DescribeInstances",
   "ec2:CreateTags",
   "ec2:DeleteTags",
   "ec2:DescribeTags",
   "ec2:DescribeVolumes"
  ],
  "Resource": "*"
 }]
}
```
 - In case of the sandbox account there already a policy `AmazonEKS_EBS_CSI_Driver_Policy` that can be used instead of the custom policy above.
 - From the web console Add the policy to the worker node role
 - [info](https://adil.medium.com/how-to-solve-kubernetes-ebs-csi-driver-unauthorizedoperation-error-d7d82c1e8eaa)
  
## Add IAM user to the cluster
- List user and roles defined in the ConfigMap
```shell
eksctl get iamidentitymapping --cluster kubeflow-test-03 --region=eu-central-1
eksctl create iamidentitymapping --cluster kubeflow-test-03 --region=eu-central-1 \
    --arn <user-arn or role-arn> --username gerassimos_cli --group system:masters \
    --no-duplicate-arns
```