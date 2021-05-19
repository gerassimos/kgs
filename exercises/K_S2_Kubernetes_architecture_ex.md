
# Section 2 - Kubernetes architecture 

---
## Quiz  

### Question 1
 - ➡️ In the context of Kubernetes, How many node `types` are there?

### Question 2
 - ➡️ I possible to run *regular* application workloads on master nodes ? 

### Question 3
 - ➡️ Which is the main cli tool to manager the kubernetes cluster ?
 - ➡️ Where can be installed?
 - ➡️ Which command is used to list the kubernetes nodes ?

---

## Quiz Solution

### Question 1
 - ➡️ In the context of Kubernetes, How many node `types` are there?
 - There are 2 types nodes `master` and `workers`. 
 - Master Nodes => run the control plane components
 - Worker Nodes => run application workloads

### Question 2
 - ➡️ I possible to run *regular* application workloads on master nodes ?
 - Can run also application workloads
 - However, a best practice is not to deploy application workloads on a master nodes 

### Question 3
 - ➡️ Which is the main cli tool to manager the kubernetes cluster ?  
 💡 The main cli tool to manage the kubernetes cluster is `kubectl`

 - ➡️ Where can be installed?  
 💡 The `kubectl` tool is usually installed our pc/laptop systems, but can be also installed on the master nodes 

 - ➡️ Which command is used to list the kubernetes nodes ?  
 💡 `kubectl get nodes` 


