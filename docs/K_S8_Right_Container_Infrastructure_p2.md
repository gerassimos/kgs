class: center, middle
# Section x - 
## Choosing the Right Container Infrastructure

---

## Kubernetes vs Swarm
 - Kubernetes and Swarm are both container orchestrators based on Docker runtime 
 - Both are solid platforms with vendor backing
 - Swarm: **Easy** to deploy and manage 
 - Swarm: does NOT cover all use cases 
 - Kubernetes: **More features** and flexible   
 - Kubernetes: complex and difficult
 
---
 
## Swarm Advantages (1)
 - Swarm is a orchestration solution built inside Docker (no need to install any additional tool other that Docker) 
 - Follows 80/20 rule, 20% of features for 80% of use cases 
 - Has less features compared to Kubernetes that cover the majority of use cases 
 - Swarm Run anywhere;
    - Linux, Windows
    - Raspberry Pi
    - ARM 64bit, ARM 32bit etc...

---

## Swarm Advantages (2)    
 - Secure out-of-the-box
    - All nodes have mutual TLC authentication
    - The **control plan** is encrypted
    - Provides encrypted distributed DB (secrets)
 - Easier to use and troubleshoot  
 - Swarm is the **recommended starting point** if you want to learn an container orchestration solution
 - A small team of DevOps persons (even one person) could manage a swarm cluster 

---

## Kubernetes Advantages 
 - Kubernetes is **the most popular** orchestration solution  
 - Has the widest vendor support
 - Has the widest community 
 - Flexible: Cover widest set of use cases
 - A dedicated team of DevOps persons is needed to manage a Kubernetes cluster
 
---

## Kubernetes Installation options for local dev
 - **Docker Desktop** (Kubernetes is included as option) 
 - **Minikube** (Based on VirtualBox) 
    - Portable executable: `kubectl.exe minikube.exe`
 - **MicroK8S** for linux system `snap install microk8s --classic`
 - **k3s** Lightweight Kubernetes `curl -sfL https://get.k3s.io | sh -`
 
---

## Kubernetes In a Browser
 - [play-with-k8s](https://labs.play-with-k8s.com/)
 - [katacoda](https://www.katacoda.com/)
 
    