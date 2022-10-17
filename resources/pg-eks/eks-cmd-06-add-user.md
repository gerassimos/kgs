# Providing RBAC to IAM users

## AWS documentation 
 - [IAM user access EKS](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)
 - 
## add a cluster admin

Steps:

 - Create IAM user in AWS console `k8s-cluster-admin` (access-key/secret-key)
 - add user to the `aws-auth` configmap 
 - add user+accesskey to aws credentials file in dedicated section (profile)

Execution: 

fetch current configmap before adding our user mapping

```bash
kubectl -n kube-system get configmap aws-auth -o yaml > cm-aws-auth-original.yml
```

edit the yaml file and add a "mapUsers" section
```bash
  mapUsers: |
    - userarn: arn:aws:iam::xxxxxxxxx:user/k8s-cluster-admin
      username: k8s-cluster-admin
      groups:
        - system:masters
```

add user to ~/.aws/credentials by creating a new section

```bash
[clusteradmin]
aws_access_key_id=.....
aws_secret_access_key=.....
region=us-east-1
output=json
```

check which user is currently active

```bash
aws sts get-caller-identity
export AWS_PROFILE="clusteradmin"
aws sts get-caller-identity
```

 - create appropriate kubeconfig file
 - Using the original IAM user used to create the cluster 
 - we can create the kubeconfig file
 - `eksctl utils write-kubeconfig --cluster=mtvr-dev --kubeconfig=/tmp/config`
 - Then we need to update 
``
```yaml
users:
- name: <your-custom-username>
...
      env:
      - name: AWS_PROFILE
        value: clusteradmin
``` 

 - aas
```shell
eksctl create iamidentitymapping --cluster gm-eks-01 \
--arn arn:aws:iam::2zxxxxxxxxxxx4:user/k8s-cluster-aaa2 \
--group system:masters \
--username k8s-cluster-aaa2
```

## add read-only user for particular namespace
 - Create namespace
 - Create IAM user
 - Create a Role & RoleBinding
 - Update the `aws-auth` configmap with the IAM user

 - Create namespace
```bash
kubectl create namespace production
```

 - Create IAM user
   Create IAM user and grab access-key

- Create a Role & RoleBinding

```yaml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  namespace: production
  name: prod-viewer-role
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["*"]  # can be further limited, e.g. ["deployments", "replicasets", "pods"]
  verbs: ["get", "list", "watch"]
  
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: prod-viewer-binding
  namespace: production
subjects:
  - kind: User
    name: prod-viewer
    apiGroup: ""
roleRef:
  kind: Role
  name: prod-viewer-role
  apiGroup: ""
```


create role and binding

```bash
kubectl apply -f 06-role-rolebinding-user-viewer.yml
```

add user to aws-auth configmap
```yaml
  mapUsers: |
    - userarn: arn:aws:iam::2zxxxxxxxxxxx4:user/eks-pg-2-prod-viewer-iam
      username: prod-viewer-k8s-user
      groups:
        - prod-viewer-role
```

add user to ~/.aws/credentials file

```bash
[clusteradmin]
aws_access_key_id=
aws_secret_access_key=
region=us-east-1
output=json
[productionviewer]
aws_access_key_id=
aws_secret_access_key=
region=us-east-1
output=json
```

set this user as the active one

```bash
aws sts get-caller-identity
export AWS_PROFILE="productionviewer"
aws sts get-caller-identity
```
