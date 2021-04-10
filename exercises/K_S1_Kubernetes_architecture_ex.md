
# Section 1 - Kubernetes architecture 

---
## Quiz  

### Question 1
 - In the context of Kubernetes, How many node `types` are there?

### Question 2
 - I possible to run *regular* application workloads on master nodes ? 

### Question 3
 - Which is the main cli tool to manager the kubernetes cluster ?
 - Where can be installed?

### Question 4
 - Which are the main Kubernetes deployment objects?

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
 - Where can be installed?
 - The main cli tool to manage the kubernetes cluster is `kubectl`
 - The `kubectl` tool is usually installed our pc/laptop systems, but can be also installed on the master nodes 

### Question 4
 - Which are the main Kubernetes deployment objects?
 - TODO 