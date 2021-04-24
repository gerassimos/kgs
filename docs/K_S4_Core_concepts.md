# 1 - Core concepts
---



## yaml file of a Kubernetes object
 - The yaml file of a Kubernetes object always contains the following fields  

```yaml  
apiVersion:  
kind:  
metadata:  
spec:  
```
### **apiVersion** = The version of the Kubernetes API used to create this object
### **kind** = What kind of object to create
### **metadata** = Data that helps uniquely identify the object, including a name string, labels and optional namespace
### **spec** - The state/configuration of the object, (each object type has its own specification)

|kind         |apiVersion  |
|-------------|------------|
|Pod          |v1          |
|Service      |v1          |
|ReplicaSet   |apps/v1     |
|Deployment   |apps/v1     |

---

## yaml file of a Pod (1)
 - The following is an example of a `pod.yml` file
```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels: 
    app: my-web-app
    tier: frontend
spec:
  containers:
  - name: nginx-container
    image: nginx
```
> The value of the `apiVersion` is a **string** 
> The value of the `kind` is a **string** 
> The value of the `metadata` is a **dictionary** - (`name` and `labels` are siblings)
> Note that the number of spaces used for the indentation is very important, we must be consistent.
> In this example  `name` and `labels` are indented with 2 spaces
> The value of the `labels` is a ***dictionary** - (*dictionary* within a *dictionary*)

---

## yaml file of a Pod (2)
 - The following is an example of a yaml file of a Pod
```yml
...
spec:
  containers:
  - name: nginx-container
    image: nginx
```
> The value of the `spec` is a **dictionary** 
> The value of the `containers` is an **array**. The reason this property is an array is because a pod can have multiple containers.  
> In this case there is only one item in the array.  
> The item in the array is a dictionary with a **name** and **image** properties
> The **-** right before the **name** indicates that this is the first item in the list.
  
---

## yaml file of a Pod with 2 containers - Multi-container Pod
```yml
...
spec:
  containers:
  - name: nginx-container
    image: nginx
  - name: log-shipper
    image: alpine
```
> In this case the **containers** value is an array with 2 items related to to different containers (nginx-container and log-shipper)
> This example of a multi-container pod is known as the **sidecar** pattern 

### To create the pod execute:  
### `kubectl apply -f pod.yml`  


