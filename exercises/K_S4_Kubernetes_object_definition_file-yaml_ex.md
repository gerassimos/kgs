
# Section 4 - Kubernetes object definition file - yaml

---
## Exercises   

## Notes
 - If the kubernetes namespace is not specified then it is assumed to be the **default** namespace

### Exercise 1 - Pod definition file
 - Create a new `pod.yml` definition file with the following specifications:
   - Pod name: redis-pod
   - labels: env=dev, tier=backend
   - Docker image: redis:6
   - Container name: redis-container
 - Use the `pod.yml` definition file to actually create the pod
 - Finally delete the pod

### Exercise 2 - Pod definition file - Multi-container Pod
 - Create a new `pod-multi-container.yml` definition file with the following specifications:
   - Pod name: nginx-redis-pod
   - labels: env=sit 
   - Docker image1: nginx:latest
   - Container name1: nginx-container 
   - Docker image2: redis:6
   - Container name: redis-container
 - Use the `pod-multi-container.yml` definition file to actually create the pod
 - Display the logs of the containers 
 - Finally delete the pod
 
### Exercise 3 - Deployment definition file
 - Create a new `deployment.yml` definition file with the following specifications:
   - Deployment name: http-proxy-deploy
   - labels: env=sit
   - Pod template labels: app=http-proxy
   - Docker image: traefik:v2.0
   - Container name: proxy-container 
 - Use the `deployment.yml` definition file to actually create the Deployment
 - List all the Kubernetes objects related with this Deployment
 - Finally delete the Deployment

### Exercise 4 - Generate a Pod definition file
 - Generate a Pod definition file `pod-nginx.yml` by using the `--dry-run=client -o yaml` options with the following specifications:
   - Pod name: nginx
   - Docker image: nginx:latest
 - Remove from the generated `pod-nginx.yml` file the properties that are not needed
 - Use the `pod-nginx.yml` definition file to actually create the pod 
 - Finally delete the Pod

### Exercise 5 - Generate a Deployment definition file 
 - Generate a Deployment definition file `deployment-redis.yml` by using the `--dry-run=client -o yaml` options with the following specifications:
   - Deployment name: redis-deploy
   - Docker image: redis:6-alpine 
 - Remove from the generated `deployment-redis.yml` file the properties that are not needed
 - Use the `deployment-redis.yml` definition file to actually create the Deployment 
 - Finally delete the Deployment

---

## Exercises -  Solution 

### Exercise 1 - Pod definition file
 - Create a new `pod.yml` definition file with the following specifications:
   - Pod name: redis-pod
   - labels: env=dev, tier=backend
   - Docker image: redis:6
   - Container name: redis-container
```console
cat pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
  labels: 
    env: dev
    tier: backend
spec:
  containers:
  - name: redis-container
    image: redis:6
```
 - Use the `pod.yml` definition file to actually create the pod
```console
# kubectl apply -f pod.yml 
pod/redis-pod created

# kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
redis-pod   1/1     Running   0          6s
``` 

 - Finally delete the pod
```console
# kubectl delete pod redis-pod 
pod "redis-pod" deleted
``` 

### Exercise 2 - Pod definition file - Multi-container Pod
 - Create a new `pod-multi-container.yml` definition file with the following specifications:
   - Pod name: nginx-redis-pod
   - labels: env=sit 
   - Docker image1: nginx:latest
   - Container name1: nginx-container 
   - Docker image2: redis:6
   - Container name: redis-container
```console
cat pod-multi-container.yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-redis-pod
  labels: 
    env: dev
    tier: backend
spec:
  containers:
  - name: nginx-container 
    image: nginx:latest
  - name: redis-container 
    image: redis:6
```

 - Use the `pod-multi-container.yml` definition file to actually create the pod
```console
# kubectl apply -f pod-multi-container.yml 
pod/nginx-redis-pod created

# kubectl get pods
NAME              READY   STATUS    RESTARTS   AGE
nginx-redis-pod   2/2     Running   0          23s
```
 - Display the logs of the containers 
```console
$ kubectl logs nginx-redis-pod nginx-container 
...
/docker-entrypoint.sh: Configuration complete; ready for start up

# kubectl logs nginx-redis-pod redis-container 
...
1:M 25 Apr 2021 19:57:44.852 * Ready to accept connections
``` 
 - Finally delete the pod
```
# kubectl delete pod nginx-redis-pod 
pod "nginx-redis-pod" deleted
``` 

### Exercise 3 - Deployment definition file
 - Create a new `deployment.yml` definition file with the following specifications:
   - Deployment name: http-proxy-deploy
   - labels: env=sit
   - Pod template labels: app=http-proxy
   - Docker image: traefik:v2.0
   - Container name: proxy-container 
```console
cat deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: http-proxy-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: http-proxy
  template:
    metadata:
      labels:
        app: http-proxy
    spec:
      containers:
      - image: traefik:v2.0
        name: proxy-container 
```   
 - Use the `deployment.yml` definition file to actually create the Deployment
```console
# kubectl apply -f deployment.yml 
deployment.apps/http-proxy-deploy created
```
 - List all the Kubernetes objects related with this Deployment
```console
# kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/http-proxy-deploy-c4dd9b574-wp8wk   1/1     Running   0          53s
...
NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/http-proxy-deploy   1/1     1            1           53s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/http-proxy-deploy-c4dd9b574   1         1         1       53s
```
 - Finally delete the Deployment
```console
# kubectl delete deployment http-proxy-deploy 
deployment.apps "http-proxy-deploy" deleted
```

### Exercise 4 - Generate a Pod definition file
 - Generate a Pod definition file `pod-nginx.yml` by using the `--dry-run=client -o yaml` options with the following specifications:
   - Pod name: nginx
   - Docker image: nginx:latest
```console
# kubectl run nginx --image=nginx:latest --dry-run=client -o yaml > pod-nginx.yml
cat pod-nginx.yml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx:latest
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
 - Remove from the generated `pod-nginx.yml` file the properties that are not needed
```console
# kubectl run nginx --image=nginx:latest --dry-run=client -o yaml > pod-nginx.yml
cat pod-nginx.yml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx:latest
    name: nginx
```

 - Use the `pod-nginx.yml` definition file to actually create the pod 
```
# kubectl apply -f pod-nginx.yml 
pod/nginx created

# kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          15s
``` 
 - Finally delete the Pod
```console
# kubectl delete pod nginx 
pod "nginx" deleted
```

### Exercise 5 - Generate a Deployment definition file 
 - Generate a Deployment definition file `deployment-redis.yml` by using the `--dry-run=client -o yaml` options with the following specifications:
   - Deployment name: redis-deploy
   - Docker image: redis:6-alpine 
```console
# kubectl create deployment redis-deploy --image=redis:6-alpine --dry-run=client -o yaml > deployment-redis.yml
cat deployment-redis.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: redis-deploy
  name: redis-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis-deploy
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: redis-deploy
    spec:
      containers:
      - image: redis:6-alpine
        name: redis
        resources: {}
status: {}
```
 - Remove from the generated `deployment-redis.yml` file the properties that are not needed
```console
cat deployment-redis.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: redis-deploy
  name: redis-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis-deploy
  template:
    metadata:
      labels:
        app: redis-deploy
    spec:
      containers:
      - image: redis:6-alpine
        name: redis
``` 
 - Use the `deployment-redis.yml` definition file to actually create the Deployment 
```console
# kubectl apply -f deployment-redis.yml 
deployment.apps/redis-deploy created

# kubectl get all
NAME                                READY   STATUS    RESTARTS   AGE
pod/redis-deploy-56cb695c78-x98p5   1/1     Running   0          9s
...
NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-deploy   1/1     1            1           9s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-deploy-56cb695c78   1         1         1       9s
``` 
 - Finally delete the Deployment
```console
# kubectl delete deployments redis-deploy 
deployment.apps "redis-deploy" deleted
```