# 1 - First kubectl commands
---
## Common commands (pods)
 - ### `kubectl run` - create a pod
 - ### `kubectl get` - list resources.
 - ### `kubectl describe` - show detailed information about a resource.
 - ### `kubectl logs` - print the logs from a container in a pod.
 - ### `kubectl exec` - execute a command on a container in a pod.
 - ### `kubectl delete` - delete a resource.
[reference](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

---

## kubectl run - create a pod

### `kubectl run <pod-name> --image=<docker-image>`

```console
# kubectl run nginx --image=nginx
pod/nginx created
```
### `kubectl get <resource-type>`
```console
# kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          6m42s
```
---

## kubectl describe - show detailed information
### `kubectl describe <resource-type> <resource-name>`
```console
# kubectl describe pod nginx
TODO
```
> Note
> See info about Namespace, Node, **Labels** etc..
---

## kubectl logs - display logs
### `kubectl logs <pod-name> [container-name]`
```console
# kubectl logs nginx
TODO
```

---

## kubectl exec - execute a command 
### `kubectl exec -it <pod-name> [container-name] -- <cmd>`
```console
# kubectl exec -it nginx -- sh
root@nginx:/# ...
root@nginx:/# exit
# 
```
> Note 
> The `-it` option is used to create a terminal and attache it to the pod
> We are inside the container now, we need to type `exit` to return to the node terminal

```console
# kubectl exec nginx -- sh -c "env"
...
NGINX_VERSION=1.19.9
...
```

> Note 
> The command is execute in the container and the output is displayed in the node.
> We are NOT inside the container

---

## kubectl delete - delete a resource
### `kubectl delete <resource-type> nginx`
```console
# kubectl delete pod nginx
pod "nginx" deleted
```

## Common commands (deployment)
 - ### `kubectl create deployment nginx-deploy --image=nginx` - 
 - ### `kubectl get all` - 
 - ### `kubectl delete pod nginx-deploy-d4789f999-rs9vf ` - 
 - ### `kubectl get all` -  
 - ### `kubectl scale deployment nginx-deploy --replicas=2` - 
 - `kubectl scale deploy nginx-deploy --replicas=3` - use deploy instead of deployment
 - `kubectl scale deploy/nginx-deploy --replicas=3` - use "/" instead of a space
 - kubectl logs deployment/nginx-deploy => only one pod
 - kubectl get pod --show-labels 
 - kubectl logs --selector app=nginx-deploy => up to 5 pods
 - kubectl logs -l app=nginx-deploy 
 - In production we need a 3rd party monitoring system like `prometheus`
 - `kubectl delete deployment nginx-deploy` 

kubectl create deployment nginx-deploy --image=nginx

...
multiple ways to execute a command

Resource types and their abbreviated aliases
...
https://kubernetes.io/docs/reference/kubectl/overview/#resource-types

---

## kubernetes imperative vs declarative
TODO