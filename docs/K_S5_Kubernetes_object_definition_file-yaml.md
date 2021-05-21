class: center, middle
# Section 5 
## Kubernetes object definition file - yaml
---
## The yaml file of a Kubernetes object (1)
 - The yaml file of a Kubernetes object always contains the following fields (sections)  
 ![kubernetes_yml_base_fields](images/kubernetes_yml_base_fields.png)
---
## The yaml file of a Kubernetes object (2)
 - **apiVersion** = The version of the Kubernetes API used to create this object
 - **kind** = What kind of object to create (Pod, ReplicaSet, Deployment etc.)
 - **metadata** = Data that helps uniquely identify the object, including a `name` string, `labels` and optional `namespace`
 - **spec** - The state/configuration of the object, (each object type has its own specification)
---
## The yaml file of a Kubernetes object (3)
 - The following table contains the **apiVersion**(s) of common deployment objects  
 ![img_width_80](images/K_apiVersion_common_deployment_objects.png)


---

## Pod definition file (1a)  
 - The following is an example of a `pod.yml` [ref](https://github.com/gerassimos/kgs/blob/main/resources/lectures/pod-3l.yml) definition file  
 ![K_pod-3l](images/K_pod-3l.png)  

---
 
## Pod definition file (1b)
 - The value of the `apiVersion` is a **string** 
 - The value of the `kind` is a **string** 
 - The value of the `metadata` is a **dictionary** - (`name` and `labels` are siblings)
 - Note that the number of spaces used for the indentation is very important, we must be consistent.
 - In this example  `name` and `labels` are indented with 2 spaces
 - The value of the `labels` is a ***dictionary** - (*dictionary* within a *dictionary*)

---

## Pod definition file (2) - containers section
 - The value of the `spec` is a **dictionary** 
 - The value of the `containers` is an **array**. The reason this property is an array is because a pod can have multiple containers.  
 - In this case there is only one item in the array.  
 - The item in the array is a dictionary with a `name` and `image` properties
 - The `-` right before the `name` indicates that this is the first item in the list.  
  ![K_pod-3l](images/K_pod-3lc1.png)
  
---

## Pod definition file - Multi-container Pod

 - In this case the **containers** value is an array with 2 items related to to different containers (nginx-container and log-shipper)
 - This example of a multi-container pod is known as the **sidecar** pattern
 - Example `pod.yml` [ref](https://github.com/gerassimos/kgs/blob/main/resources/lectures/pod-2c.yml)  
 ![K_pod-2c](images/K_pod-2c.png)  
  
---
## Create Kubernetes object with kubectl apply -f
 - Use the `pod.yml` file to create the `pod` with the **declarative** approach
 - `kubectl apply -f pod.yml`
 
```console
# kubectl apply -f https://raw.githubusercontent.com/gerassimos/kgs/main/resources/lectures/pod.yml
pod/pod-nginx created 

or

git clone https://github.com/gerassimos/kgs.git
cd kgs/resources/lectures/
kubectl apply -f pod.yml
pod/pod-nginx created
```

> Note that we can use directly a remote yml file located on a web server (GitHub)
---

## ReplicaSet definition file (1)
 - The following is an example of a `ReplicaSet.yml` [ref](https://github.com/gerassimos/kgs/blob/main/resources/lectures/rs.yml) definition file
 - As with any Kubernetes yaml definition file there are 4 sections  
 ![K_rs-empty](images/K_rs-empty.png) 

> - `replicas` = The the number of desired replicas. Remember a ReplicaSet creates multiple instances of a **Pod**  
> - `selector` = Used as a glue to determine which Pod are managed from the ReplicaSet  
> - `template` = Used for the Pod definition 

---

## ReplicaSet definition file (2)
 - `template` = Used for the Pod definition
![img_width_100](images/pod-vs-rs.png)

---

## ReplicaSet definition file (3)
<table>
  <tr>
    <td> 
        <ul>
          <li>But why we need a <code>selector</code> since the <code>template</code> section already contains the Pod managed from the ReplicaSet?</li>
          <li>Because can also manage Pods (of the same type) that are not created part of the ReplicaSet,</li>
          <li>Pods that were created before the ReplicaSet</li>
        </ul> 
    </td>
    <td><img src="images/K_rs-selector.png"></td>
  </tr>
</table> 

---
## ReplicaSet definition file (4)

 - To **create** the `ReplicaSet` execute:  
   - `kubectl apply -f ReplicaSet.yml`  
<br> 
<br>
 - To **list** all the existing ReplicaSet objects on the default namespace
   - `kubectl get replicaset`  
   - `kubectl get rs`  

---

## Deployment definition file (1)
 - The following is an example of a `deployment.yml` [ref](https://github.com/gerassimos/kgs/blob/main/resources/lectures/deployment.yml) definition file
 - As with any Kubernetes yaml definition file there are 4 sections  
 ![K_deploy-empty](images/K_deploy-empty.png)


>The contents of the deployment definition file are exactly similar to the ReplicaSet  definition file except for the `kind` that is `Deployment`

---

## Deployment definition file - rs vs deployment
![img_width_100](images/rs-vs-deployment-01.png)
---

## Deployment definition file - labels sections
![img_width_100](images/rs-vs-deployment-02.png)
---

## Deployment definition file - spec sections
![img_width_100](images/rs-vs-deployment-03.png)
---

## Deployment cmd (1)
 - `kubectl apply -f deployment.yml` to create the Deployment
 - `kubectl get deployments` to list the Deployments
 - `kubectl get replicasets` to list the ReplicaSets
 - `kubectl get pods` to list the Pods
 
```console
# kubectl apply -f deployment.yml 
deployment.apps/nginx-deploy created

controlplane $ kubectl get deployments
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/1     1            1           72s

controlplane $ kubectl get replicasets
NAME                      DESIRED   CURRENT   READY   AGE
nginx-deploy-7d9b76dbf7   1         1         1       101s
controlplane $ 

controlplane $ kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
nginx-deploy-7d9b76dbf7-gz6hx   1/1     Running   0          114s

```
---

## Deployment cmd (2)
 - `kubectl get all` - list all resources in the current (default) namespace  

```console
# kubectl get all
NAME                                READY   STATUS    RESTARTS   AGE
pod/nginx-deploy-7d9b76dbf7-gz6hx   1/1     Running   0          2m19s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   8m2s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deploy   1/1     1            1           2m19s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deploy-7d9b76dbf7   1         1         1       2m19s
```
---
## Generate a Kubernetes object definition file
 - We can generate a Kubernetes object definition file by using the: `--dry-run=client -o yaml`
 - We use the `--dry-run=client` option to preview the object that we would like to create
 - With the `--dry-run=client` option we do not actually send the request to the cluster
 - We use the `-o yaml` option to set the output format to be a yaml file

---

## Generate a Pod definition file (1a) - dry-run
 - To generate a `Pod` definition file:
   - `kubectl run nginx --image=nginx --dry-run=client -o yaml`

---

## Generate a Pod definition file (1b) - dry-run
```console
# kubectl run nginx --image=nginx --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null  
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
> In the output of the commands there are properties, such as the `creationTimestamp: null`, that can be ignored or eventually removed from the final result
> In this example the properties that can be removed are: `creationTimestamp: null, resources: {}, dnsPolicy: ClusterFirst, restartPolicy: Always, status: {}`
  
---

## Generate a Pod definition file (2)
 - Finally we can redirect the output to a file:

```console
# kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yml
# cat pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
...

``` 
---
## Generate a Deployment definition file (2)
 - In similar way as above we can create a `Deployment` definition file  
   - `kubectl create deployment nginx --image=nginx \`  
   `--dry-run=client -o yaml > deployment.yml`

```console
# kubectl create deployment nginx --image=nginx \
  --dry-run=client -o yaml > deployment.yml
```
---

## Generate a Deployment definition file (2)

```console
# kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > deployment.yml
# cat deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  strategy: {}
  template:
...
```
> Also in this output there are properties, such as the `creationTimestamp: null`, that can be ignored or eventually removed from the final result

---

## Extract the definition file of an existing object
 - We can extract the pod definition file of an existing pod 
 - `kubectl get pod <pod-name> -o yaml > pod-definition.yaml`

```console
# kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
pod-nginx   1/1     Running   0          10s

# kubectl get pod pod-nginx -o yaml
apiVersion: v1
kind: Pod
metadata:
...

# kubectl get pod pod-nginx -o yaml > pod.yaml
# cat pod.yaml
apiVersion: v1
kind: Pod
metadata:
...
```
---

## Edit an existing Kubernetes object
 - We can edit the pod definition file of an existing pod
 - `kubectl edit pod <pod-name>`

```console
# kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
pod-nginx   1/1     Running   0          10s

# kubectl edit pod pod-nginx
apiVersion: v1
kind: Pod
metadata:

``` 