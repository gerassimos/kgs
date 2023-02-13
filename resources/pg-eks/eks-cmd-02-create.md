## eksctl 01 - create / get / delete
```shell
eksctl create cluster --name gm-eks-01 --region us-east-1 
eksctl create cluster --name gm-eks-02 --nodes=3 --version 1.22 --region us-east-1 --zones us-east-1a,us-east-1c
eksctl create cluster -f cluster.yml
eksctl get cluster
eksctl delete cluster --name gm-eks-01 --region us-east-1
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