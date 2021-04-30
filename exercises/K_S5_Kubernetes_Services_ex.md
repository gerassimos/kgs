# Section 5 - Kubernetes Services

---
## Exercises   

## Notes
 - If the kubernetes namespace is not specified then it is assumed to be the **default** namespace

### Exercise 1 - Explore the services in the **default** namespace
 - How many Services exist on the system? in the current(default) namespace?
 - What is the type of the default kubernetes service?
 - What is the targetPort configured on the kubernetes service?
 - How many Endpoints are attached on the kubernetes service?
---

### Exercise 2 - Service NodePort
 - Use the `deployment-front-end.yml` definition file available in the `resources/lectures` directory to created the PODs of a web application related to the `front-end` stack.
 - Verify that the kubernetes objects of the `front-end` deployment are created successfully. How many PODs are created ?
 - Create a `service-front-end.yml` definition file of a NodePort Service with the following specifications:
   - type: NodePort
   - port: 8080, targetPort: 80, nodePort: 30008
   - selector: app=myapp, type=front-end
   - name: front-end
 - Use the `service-front-end.yml` definition file to actually create the service and view the details of the service, which are the Endpoints attached on the `front-end` service? which are the IP addresses of the front-end POD(s)
 - Use the IP address of a Kubernetes Node to access the *front-end* web stack
 - Use the IP address of the `front-end` service to access the *front-end* web stack
 - Use the IP address of a front-end POD to access the *front-end* web stack
---

### Exercise 3 - Service ClusterIP
 - Use the `deployment-back-end.yml` definition file available in the `resources/lectures` directory to created the PODs of a web application related to the `back-end` stack.
 - Verify that the kubernetes objects of the `back-end` deployment are created successfully. 
 - Create a Service by using the `kubectl expose` command with the following specifications:
   - type: ClusterIP
   - port: 8090, targetPort: 80
   - selector: app=myapp, type=back-end
   - name: back-end
 - Use the IP address of the `back-end` service to access the *back-end* web stack
 - Use the IP address of a back-end POD to access the *back-end* web stack
 - [Optional] Use the [Debugging DNS Resolution](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/) tutorial to test the DNS resolution of the `back-end` service

---

## Exercises -  Solution 
### Exercise 1 - Explore the services in the **default** namespace
 - How many Services exist on the system? in the current(default) namespace?
 - What is the type of the default kubernetes service?
```console
# kubectl get services
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   34m
```
> There one `ClusterIP` Service with name `kubernetes` 
> NOTE:  
> This is a *default* service created by Kubernetes at cluster creation time.

 - What is the targetPort configured on the kubernetes service?
 - How many Endpoints are attached on the kubernetes service?
```console
# kubectl describe service kubernetes 
Name:              kubernetes
Namespace:         default
Labels:            component=apiserver
                   provider=kubernetes
Annotations:       <none>
Selector:          <none>
Type:              ClusterIP
IP:                10.96.0.1
Port:              https  443/TCP
TargetPort:        6443/TCP
Endpoints:         172.17.0.14:6443
Session Affinity:  None
Events:            <none>
```
> The `targetPort` of the `kubernetes` Service is 6443
> There is one `Endpoint` with IP address 172.17.0.14:6443

---

### Exercise 2 - Service NodePort
 - Use the `deployment-front-end.yml` definition file available in the `resources/lectures` directory to created the PODs of a web application related to the `front-end` stack.
```console
# git clone https://github.com/gerassimos/kgs.git
Cloning into 'kgs'...

# cd kgs/
# kubectl apply -f resources/lectures/deployment-front-end.yml 
deployment.apps/front-end created
``` 

 - Verify that the kubernetes objects of the `front-end` deployment are created successfully. 
```console
controlplane $ kubectl get all
NAME                             READY   STATUS    RESTARTS   AGE
pod/front-end-5bfcc74c4c-4q4xv   1/1     Running   0          8m38s
pod/front-end-5bfcc74c4c-csvv4   1/1     Running   0          8m38s
pod/front-end-5bfcc74c4c-p7r2x   1/1     Running   0          8m38s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          53m

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/front-end   3/3     3            3           8m38s

NAME                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/front-end-5bfcc74c4c   3         3         3       8m38s
```
> The front-end Deployment has created 3 replica PODs (front-end-5bfcc74c4c-4q4xv, front-end-5bfcc74c4c-csvv4 and front-end-5bfcc74c4c-p7r2x)

 - Create a `service-front-end.yml` definition file of a NodePort Service with the following specifications:
   - type: NodePort
   - port: 8080, targetPort: 80, nodePort: 30008
   - selector: app=myapp, type=front-end
   - name: front-end
 - Use the `service-front-end.yml` definition file to actually create the service and view the details of the service, which are the Endpoints attached on the `front-end` service? which are the IP addresses of the front-end POD(s)

service-front-end.yml
---------------------
```yaml
apiVersion: v1
kind: Service
metadata:
  name: front-end
spec:
  type: NodePort
  ports:
    - port: 8080
      targetPort: 80
      nodePort: 30008
  selector:
    app: myapp
    type: front-end
```

```console
# kubectl apply -f service-front-end.yml 
service/front-end created

# kubectl get services
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
front-end    NodePort    10.109.67.213   <none>        8080:30008/TCP   9m42s
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          59m
```

 - Use the IP address of a Kubernetes Node to access the *front-end* web stack
```console
$ kubectl get nodes -o wide
NAME           STATUS   ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
controlplane   Ready    master   60m   v1.18.0   172.17.0.14   <none>        Ubuntu 18.04.5 LTS   4.15.0-122-generic   docker://19.3.13
node01         Ready    <none>   55m   v1.18.0   172.17.0.18   <none>        Ubuntu 18.04.5 LTS   4.15.0-122-generic   docker://19.3.13

# curl 172.17.0.14:30008
<!DOCTYPE html>
<html>
...

or
# curl 172.17.0.18:30008
<!DOCTYPE html>
<html>
...
```
> From the output of the `kubectl get nodes -o wide` command we can see that the IP addresses of the Kubernetes nodes are 172.17.0.14 and 172.17.0.18

 - Use the IP address of the `front-end` service to access the *front-end* web stack
```console
 $ kubectl get service
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
front-end    NodePort    10.109.67.213   <none>        8080:30008/TCP   14m
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          64m

# curl 10.109.67.213:8080
<!DOCTYPE html>
<html>
...
```
 - Use the IP address of a front-end POD to access the *front-end* web stack
```console
$ kubectl get pods -o wide
NAME                         READY   STATUS    RESTARTS   AGE   IP           NODE     NOMINATED NODE   READINESS GATES
front-end-5bfcc74c4c-4q4xv   1/1     Running   0          21m   10.244.1.4   node01   <none>           <none>
front-end-5bfcc74c4c-csvv4   1/1     Running   0          21m   10.244.1.5   node01   <none>           <none>
front-end-5bfcc74c4c-p7r2x   1/1     Running   0          21m   10.244.1.3   node01   <none>           <none>

# curl 10.244.1.3:80
or
# curl 10.244.1.4:80
or 
# curl 10.244.1.5:80
<!DOCTYPE html>
<html>
...
```
> In this case we have used the `kubectl get pods -o wide` command to display the IP addressed of the PODs
---

### Exercise 3 - Service ClusterIP
 - Use the `deployment-back-end.yml` definition file available in the `resources/lectures` directory to created the PODs of a web application related to the `back-end` stack.
```console
# git clone https://github.com/gerassimos/kgs.git
Cloning into 'kgs'...

# cd kgs/
# kubectl apply -f resources/lectures/deployment-back-end.yml 
deployment.apps/back-end created
```  

 - Verify that the kubernetes objects of the `back-end` deployment are created successfully. 
```console 
# kubectl get all
NAME                           READY   STATUS    RESTARTS   AGE
pod/back-end-675bbd589-bwj6v   1/1     Running   0          114s
pod/back-end-675bbd589-hpwgf   1/1     Running   0          114s
pod/back-end-675bbd589-lvrl8   1/1     Running   0          114s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   10m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/back-end   3/3     3            3           114s

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/back-end-675bbd589   3         3         3       114s
```
 - Create a Service by using the `kubectl expose` command with the following specifications:
   - type: ClusterIP
   - port: 8090, targetPort: 80
   - selector: app=myapp, type=back-end
   - name: back-end
```console
# kubectl expose deployment back-end \
  --port=8090 --target-port=80 --name=back-end \
  --dry-run=client -o yaml > service-back-end.yml 
# cat service-back-end.yml 
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  name: back-end
spec:
  ports:
  - port: 8090
    protocol: TCP
    targetPort: 80
  selector:
    app: myapp
    type: back-end
status:
  loadBalancer: {}
# kubectl apply -f service-back-end.yml 
service/back-end created
```

 - Use the IP address of the `back-end` service to access the *back-end* web stack
```
# kubectl get services
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
back-end     ClusterIP   10.111.1.46   <none>        8090/TCP   88s
kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP    20m

curl 10.111.1.46:8090
<!DOCTYPE html>
<html>
...
``` 
 - Use the IP address of a back-end POD to access the *back-end* web stack
```console
$ kubectl get pods -o wide
NAME                       READY   STATUS    RESTARTS   AGE   IP           NODE     NOMINATED NODE   READINESS GATES
back-end-675bbd589-bwj6v   1/1     Running   0          15m   10.244.1.3   node01   <none>           <none>
back-end-675bbd589-hpwgf   1/1     Running   0          15m   10.244.1.4   node01   <none>           <none>
back-end-675bbd589-lvrl8   1/1     Running   0          15m   10.244.1.5   node01   <none>           <none>

# curl 10.244.1.3:80
or
# curl 10.244.1.4:80
or 
# curl 10.244.1.5:80
<!DOCTYPE html>
<html>
...
```

 - [Optional] Use the [Debugging DNS Resolution](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/) tutorial to test the DNS resolution of the `back-end` service

```console
# kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
pod/dnsutils created
controlplane $ kubectl get pods dnsutils
NAME       READY   STATUS    RESTARTS   AGE
dnsutils   1/1     Running   0          10s

controlplane $ kubectl exec -i -t dnsutils -- nslookup back-end
Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   back-end.default.svc.cluster.local
Address: 10.111.1.46
``` 