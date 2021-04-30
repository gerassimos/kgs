
# Section 3 - Basic Deployment objects
---

### Question 1
 - Which are the main Kubernetes deployment objects?

### Question 2
 - What is a kubernetes `namespace` and how can be used (describe use case examples)?  

---
## Quiz Solution

### Question 1
 - Which are the main Kubernetes deployment objects?

<details>
  <summary>answer</summary>
  
 1. ### `Pod` -> The smallest deployable unit
 1. ### `ReplicaSet` -> Used to provide self-healing and scaling
 1. ### `Deployment` -> Used to provide zero-downtime rolling-updates
 1. ### `Service`    -> Provide stable reliable networking for Pods (cannot relay on Pod IP)
 1. ### `Namespace`  -> logically divide the cluster in multiple virtual clusters
</details> 

 
### Question 2
 - What is a kubernetes `namespace` and how can be used (describe use case examples)?  
 - It is used to logically divide the cluster in multiple virtual clusters
 - Example: we can have namespace for the `prod` environment and one for the `test` environment
 - Example: we can have a namespace to separate independent application stacks
 - `kube-system` namespace is used for the control plane applications
 - `default` namespace is used for our workloads 
