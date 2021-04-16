
# Section 2 - First kubectl commands 

---
## Exercises   

## Notes
 - If the kubernetes namespace is not specified then it is assumed to be the **default** namespace

### Exercise 1 - Pod lifecycle
 - Create a new pod with the nginx Docker image.
 - Verify the number of pods available in the default namespace ?
 - What is the STATUS and the READY state of the Pod ?
 - What is the meaning of `1/1` in the READY state column ?
 - Verify the detailed (describe) information of the pod.
 - Which node is this this pod placed on?
 - Which is the IP address of the pod?
 - Which are the labels of the Pod?
 - Describe the Container(s) created. 
 - Which is the name of the container that is created from the Pod. (Note that this is automatically crated from the kubernetes cluster)
 - Describe the **Conditions** and the **Events** of the Pod.
 - Display the logs of the pod
 - From the master node of the cluster use the `curl` command and the IP address of the Pod to retrieve the index.html page of the nginx webserver
 - Display the content of the file `/run/secrets/kubernetes.io/serviceaccount/token` which is located in the nginx pod
`kubectl exec nginx -- cat /run/secrets/kubernetes.io/serviceaccount/token`
Note in case there is more than one container in the pod then the syntax of this command is 
`kubectl exec <pod-name> <container-name> -- <cmd>`
 - Delete the Pod

### Exercise 2 - Deployment

### Exercise 3 - Create a pod with yml file - The Declarative way 
create a yml ???
use the yml file deployment.yml available at ... to deploy 

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
nginx   1/1     Running   0          20s   10.244.1.4   node01
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

TODO

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
