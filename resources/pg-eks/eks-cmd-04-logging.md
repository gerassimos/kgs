# Cloudwatch logging of an EKS cluster

 - There 5 types of logs that we may wish to enable:
   - api
   - audit
   - authenticator
   - controllerManager
   - scheduler
 - Cloudwatch logging adds additional cost (storage and collection)

## enable via yaml config file
```yaml
cloudWatch:
  clusterLogging:
    enableTypes: ["api", "audit", "authenticator"]
```

```bash
eksctl utils update-cluster-logging --config-file cluster-04-cloudwatch.yml
eksctl utils update-cluster-logging --enable-types="api,audit" --cluster gm-eks-01 
```

## disable via plain commandline call

```bash
eksctl utils update-cluster-logging --name=gm-eks-01 --disable-types all
```
