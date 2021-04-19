
# Section 2 - First kubectl commands 

---
## Exercises   

## Notes
 - If the kubernetes namespace is not specified then it is assumed to be the **default** namespace

### Exercise 1 - Pod lifecycle
 - Create a new **Pod** with the nginx Docker image.
 - Verify the number of pods available in the default namespace.
 - What is the STATUS and the READY state of the Pod ?
 - What is the meaning of `1/1` in the READY state column ?
 - Verify the detailed (describe) information of the pod.
 - Which node is this this pod placed on?
 - Which is the IP address of the pod?
 - Which are the labels of the Pod?
 - Describe the Container(s) created. 
 - Which is the name of the container that is created from the Pod.
 - Describe the **Conditions** and the **Events** of the Pod.
 - Display the logs of the pod
 - From the master node of the cluster use the `curl` command and the IP address of the Pod to retrieve the index.html page of the nginx webserver
 - Display the content of the file `/run/secrets/kubernetes.io/serviceaccount/token` which is located in the nginx pod
 - Delete the Pod

### Exercise 2 - Deployment lifecycle
 - Create a new **Deployment** with the nginx Docker image.
 - List all resources in the *default* namespace.
 - Describe all the resources that are part of the Deployment.
 - Scale the **Deployment** up to 5 replicas 
 - Display all the Pods in the *default* namespace and the related labels.
 - Display the logs of all the Pods that are part of the Deployment.
 - Delete the **Deployment**

### Exercise 3 - Create a pod with yml file - The Declarative way 
 - Create a new **Pod** with the **redis** Docker image by using the Declarative way. The name of the Pod should be *redis-pod* and the name of the container should be *redis-container*
 - List the *redis-pod* pod in the *default* namespace. 
 - Display the logs of the **redis-container**


---

## Exercises -  Solution

### Exercise 1 - Pod
 - Create a new pod with the nginx Docker image.
```console
# kubectl run nginx --image=nginx
pod/nginx created
```

 - Verify the number of pods available in the default namespace ?
```console
# kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          6m42s
```
> From the above output we can see that there is one pod in the **default** namespace.  

   - But if we want to calculate the number of pods programmatically and assign the result to a variable we can :
```console
# nrOfPods=$(kubectl get pods --no-headers=true | wc -l)
# echo $nrOfPods
2
```
> Note that we can use the `kubectl get pods --help` command to get help on all available options.  
> In this case we can see from the help page that we can use the option `--no-headers=true` to avoid displaying the table headers from the output of the `kubectl get pods` command  
> Finally we redirect the output to the `wc -l` (*word count*) command to count the number of lines 

 - What is the STATUS and the READY state of the Pod ?
```console
# kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          6m42s
```
> From the above output we can see that **READY** state is **1/1** and the **STATUS** is **Running**

 - What is the meaning of `1/1` in the READY state column ?
>  There is one container in ready state out of off 1 total container(s) in the pod  
> Remember we can have more than one container in the pod  

 - Verify the detailed (describe) information of the pod.
```console
# kubectl describe pod nginx
Name:         nginx
Namespace:    default
...
```
> In this case we use the `kubectl describe <resource-type> <resource-name>` command to get detailed information about a kubernetes object  

 - Which node is this this pod placed on?
```console
# kubectl describe pod nginx
...
Node:         node01/172.17.0.36
...
```

 - Which is the IP address of the pod?
```console
# kubectl describe pod nginx
...
IP:           10.244.1.3
...
```

> We can also use the `kubectl get pods -o wide` command to display IP and NODE information of our pods
```console
 # kubectl get pods -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE  
nginx   1/1     Running   0          20s   10.244.1.3   node01
```
 - Which are the labels of the Pod?
```console
# kubectl describe pod nginx
...
Labels:       run=nginx
...
```
> We can also use the `kubectl get pods --show-labels` command to display the labels of the pods  
```console
$ kubectl get pods --show-labels 
NAME    READY   STATUS    RESTARTS   AGE     LABELS
nginx   1/1     Running   0          7m32s   run=nginx
```


 - Describe the Container(s) created. 
 - Which is the name of the container that is created from the Pod. 
```console
# kubectl describe pod nginx
...
Containers:
  nginx:
    Container ID:   docker://9a3...
    Image:          nginx
...
```
> The name of the container is **nginx** *(the same as the pod name)* and it is automatically defined from the kubernetes cluster  

 - Describe the **Conditions** and the **Events** of the Pod.
 ```console
# kubectl describe pod nginx
...
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
...
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  10m   default-scheduler  Successfully assigned default/nginx to node01
  Normal  Pulling    10m   kubelet, node01    Pulling image "nginx"
  Normal  Pulled     10m   kubelet, node01    Successfully pulled image "nginx"
  Normal  Created    10m   kubelet, node01    Created container nginx
  Normal  Started    10m   kubelet, node01    Started container nginx
...
```
> The pods Events is the first place to look when there are problems with the deployment.  

 - Display the logs of the pod
```console
# kubectl logs nginx
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
...
```

> There is not need to specify the container name since there is only one container in the pod  
> In case there is more than one container in the pod then the syntax of this command is 
> ### `kubectl logs <pod-name> [container-name]`  


 - From the master node of the cluster use the `curl` command and the IP address of the Pod to retrieve the index.html page of the nginx webserver

```console
# curl 10.244.1.3
<html>
<head>
<title>Welcome to nginx!</title>
...
</html>
```

> The Pod is accessible from any node of the cluster via the POD's IP address  


 - Display the content of the file `/run/secrets/kubernetes.io/serviceaccount/token` which is located in the nginx pod
```console 
kubectl exec nginx -- cat /run/secrets/kubernetes.io/serviceaccount/token
```

> In case there is more than one container in the pod then the syntax of this command is:  
> ### `kubectl exec <pod-name> <container-name> -- <cmd>`

 - Delete the Pod
```console
# kubectl delete pod nginx
pod "nginx" deleted
```

---

### Exercise 2 - Deployment lifecycle
 - Create a new **Deployment** with the nginx Docker image.
```console
# kubectl create deployment nginx-deploy --image=nginx
deployment.apps/nginx-deploy created
```   

 - List all resources in the *default* namespace.
```console
$ kubectl get all 
NAME                               READY   STATUS    RESTARTS   AGE
pod/nginx-deploy-d4789f999-7t29b   1/1     Running   0          32s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   47m

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deploy   1/1     1            1           32s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deploy-d4789f999   1         1         1       32s
```

 - Describe all the resources that are part of the Deployment.
> Deployment -> nginx-deploy 
> ReplicaSet -> nginx-deploy-d4789f999
> Pod        -> nginx-deploy-d4789f999-7t29b

 - Scale the **Deployment** up to 5 replicas 
```console
$ kubectl scale deployment --replicas=5 nginx-deploy 
deployment.apps/nginx-deploy scaled
``` 
  
 - Display all the Pods in the *default* namespace and the related labels.
```console
$ kubectl get pods --show-labels 
NAME                           READY   STATUS    RESTARTS   AGE     LABELS
nginx-deploy-d4789f999-7t29b   1/1     Running   0          2m24s   app=nginx-deploy
nginx-deploy-d4789f999-f6pk5   1/1     Running   0          34s     app=nginx-deploy
nginx-deploy-d4789f999-kjhnb   1/1     Running   0          34s     app=nginx-deploy
nginx-deploy-d4789f999-nmj5v   1/1     Running   0          34s     app=nginx-deploy
nginx-deploy-d4789f999-z2gf9   1/1     Running   0          34s     app=nginx-deploy
```
  
 - Display the logs of all the Pods that are part of the Deployment.
```
# kubectl logs -l app=nginx-deploy
...
/docker-entrypoint.sh: Configuration complete; ready for start up
...
/docker-entrypoint.sh: Configuration complete; ready for start up
...
/docker-entrypoint.sh: Configuration complete; ready for start up
...
/docker-entrypoint.sh: Configuration complete; ready for start up
...
/docker-entrypoint.sh: Configuration complete; ready for start up
```
> Logs from all 5 Pods is displayed in the output 

 - Delete the **Deployment**
```console
$ kubectl delete deployment nginx-deploy 
deployment.apps "nginx-deploy" deleted
```  

---

### Exercise 3 - Create a pod with yml file - The Declarative way 
 - Create a new **Pod** with the redis Docker image by using the Declarative way. The name of the Pod should be *redis-pod* and the name of the container should be *redis-container*

   - Create the pod.yml: 
```yml
apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
spec:
  containers:
  - image: redis
    name: redis-container
```
   - Create the pod by executing the `kubectl apply -f pod.yml` command
```console
# ls -1
pod.yml

# kubectl apply -f pod.yml 
pod/redis-pod created
```

 - List the *redis-pod* pod in the *default* namespace. 
```console
# kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
redis-pod   1/1     Running   0          9s
```
  

 - Display the logs of the **redis-container**
```
$ kubectl logs redis-pod redis-container 
...
1:M 19 Apr 2021 19:52:20.036 * Ready to accept connections
``` 