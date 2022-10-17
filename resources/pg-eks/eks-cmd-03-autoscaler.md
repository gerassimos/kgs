## Cluster autoscaler
 - The cluster autoscaler automatically launches additional worker nodes if more resources are needed, 
 - and shutdown worker nodes if they are underutilized. 
 - The autoscaling works within a nodegroup, hence create a nodegroup first which has this feature enabled.
 - It requires to deploy the cluster-autoscaler in the cluster
 - Based on CPU and RAM availability/request
 - Nodegroup with single AZ => for stateful workloads (EBS volumes not shared across AZ)
 - Nodegroup with multi AZ => for stateless workloads

## create nodegroup with autoscaler enabled
 - [Enable Auto Scaling on nodegroup](https://eksctl.io/usage/autoscaling/#auto-scaling)
 - [AWS autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md)
```yaml
iam:
  withAddonPolicies:
    autoScaler: true
``` 
```bash
eksctl create nodegroup --config-file=cluster-03-autoscaler.yml
```

## deploy the autoscaler
 - [cluster-autoscaler-autodiscover.yaml](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml)
 - copy the cluster-autoscaler-autodiscover.yaml file locally and update the: 
   - `k8s.io/cluster-autoscaler/<YOUR CLUSTER NAME>` => `k8s.io/cluster-autoscaler/gm-eks-01`
   - image cluster-autoscaler tag to math the Kubenetes version => `cluster-autoscaler:v1.22.2`
```bash
kubectl apply -f eks-yaml/03-cluster-autoscaler-autodiscover-gm-eks-01-v1.22.2.yaml
```

## deploy the autoscaler
 - To make sure Kubernetes autoscaler do not delete the node which runs autoscaler deployment
 - [safe to evict](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-types-of-pods-can-prevent-ca-from-removing-a-node)
 - [use safe to evict or PodDisruptionBudget](https://stackoverflow.com/questions/63871413/how-to-make-sure-kubernetes-autoscaler-not-deleting-the-nodes-which-runs-specifi)
put required annotation to the deployment:
```bash
kubectl -n kube-system annotate deployment.apps/cluster-autoscaler cluster-autoscaler.kubernetes.io/safe-to-evict="false" --overwrite
```

## view cluster autoscaler logs
```bash
kubectl -n kube-system logs deployment.apps/cluster-autoscaler
```

## test the autoscaler
 - create a deployment of nginx with request 512Mi `03-nginx-deploy-test-as.yaml`
 - scale the deployment `kubectl scale --replicas=3 deployment/test-autoscaler`
 - check pods `kubectl get pods -o wide --watch`
 - check nodes `kubectl get nodes`
### logs - Expanding Node Group (scale out)
 - view cluster autoscaler logs (scale out) search for `Expanding Node Group`
 - `kubectl -n kube-system logs deployment.apps/cluster-autoscaler | grep -A5 "Expanding Node Group"`
### logs - reducing Node Group (scale in)
 - view cluster autoscaler logs (scale in)
   ```shell
   kubectl -n kube-system logs deployment.apps/cluster-autoscaler 
   ...
   "ip-192-168-44-39.ec2.internal was unneeded for 9m53.739534481s"
   "Fast evaluation: node ip-192-168-15-74.ec2.internal may be removed"
   "Scale-down: removing empty node ip-192-168-44-39.ec2.internal"
   ```
 - look for `was unneeded for` and for `Scale-down: removing`
 - `kubectl -n kube-system logs deployment.apps/cluster-autoscaler | grep  "was unneeded for"`
 - `kubectl -n kube-system logs deployment.apps/cluster-autoscaler | grep  "Scale-down: removing"`

## Default cooldown
 - Auto Scaling Groups -> ng-03 -> Details -> Advanced configuration 
 - Default cooldown period: 300sec (5 minutes to scale in-> delete nodes)