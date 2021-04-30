
# Section 2 - Kubernetes architecture 

---
## Quiz  

### Question 1
 - In the context of Kubernetes, How many node `types` are there?

### Question 2
 - I possible to run *regular* application workloads on master nodes ? 

### Question 3
 - Which is the main cli tool to manager the kubernetes cluster ?
 - Where can be installed?
 - Which command is used to list the kubernetes nodes ?

### Question 4
 - Which are the main Kubernetes deployment objects?

### Question 5
 - What is a kubernetes `namespace` and how can be used (describe use case examples)?  

---
## Quiz Solution

### Question 1
 - In the context of Kubernetes, How many node `types` are there?
 - There are 2 types nodes `master` and `workers`. 
 - Master Nodes => run the control plane components
 - Worker Nodes => run application workloads

### Question 2
 - I possible to run *regular* application workloads on master nodes ?
 - Can run also application workloads
 - However, a best practice is not to deploy application workloads on a master nodes 

### Question 3
 - Which is the main cli tool to manager the kubernetes cluster ?  
 💡 The main cli tool to manage the kubernetes cluster is `kubectl`

 - Where can be installed?  
 💡 The `kubectl` tool is usually installed our pc/laptop systems, but can be also installed on the master nodes 

 - Which command is used to list the kubernetes nodes ?  
 💡 `kubectl get nodes` 

### Question 4
 - Which are the main Kubernetes deployment objects?

<details>
  <summary>answer</summary>
  
 1. ### `Pod` -> The smallest deployable unit
 1. ### `ReplicaSet` -> Used to provide self-healing and scaling
 1. ### `Deployment` -> Used to provide zero-downtime rolling-updates
 1. ### `Service`    -> Provide stable reliable networking for Pods (cannot relay on Pod IP)
 1. ### `Namespace`  -> logically divide the cluster in multiple virtual clusters
</details> 

 
### Question 5
 - What is a kubernetes `namespace` and how can be used (describe use case examples)?  
 - It is used to logically divide the cluster in multiple virtual clusters
 - Example: we can have namespace for the `prod` environment and one for the `test` environment
 - Example: we can have a namespace to separate independent application stacks
 - `kube-system` namespace is used for the control plane applications
 - `default` namespace is used for our workloads 
