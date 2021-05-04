class: center, middle
# Section 3  
## Basic Deployment objects  

---

## Basic Deployment objects
 - `Pod` -> The smallest deployable unit
 - `ReplicaSet` -> Used to provide **self-healing** and **scaling**
 - `Deployment` -> Used to provide zero-downtime **rolling-updates**
 - `Service`    -> Provide stable **reliable networking** for Pods (cannot relay on Pod IP)
 - `Namespace`  -> **logically divide** the cluster in multiple virtual clusters
<br>  
<br>  

![img_width_90](images/k8s_drawio_icons_02.png)


---

## Basic Deployment objects - Deployment 
<table style="width:100%">
  <tr>
    <td>A <b>Pod</b> is managed by a <b>ReplicaSet</b> which is managed by a <b>Deployment</b></td>
    <td><img src="images/k8s_drawio_icons_02-Page-2.png" height="450px"></td>
  </tr>
</table>  

---

## Pod (1) 

<table>
  <tr>
    <td> 
        <ul>
          <li>With Kubernetes our ultimate aim is to deploy our <b>applications</b> in the form of <b>containers</b> on a set of machines that are configured as <b>worker nodes</b> in a cluster</li>
          <li>However, it is does not deploy containers directly on the worker nodes</li>
          <li>The containers are <b>encapsulated</b> into a kubernetes object known as pods</li>
        </ul> 
    </td>
    <td><img src="images/k8s_drawio_icons_02-Page-3.png"></td>
  </tr>
</table>
  
---

## Pod (2)

<table>
  <tr>
    <td> 
      <ul>
        <li>Pod is the smallest <b>deployable</b> unit</li>
        <li>At high level a <b>container</b> is wrapped in a <b>Pod</b> so it can run on kubernetes</li>
        <li>Pod do not <b>serf-heal</b> and the do not <b>scale</b></li>
        <li>Pod do not support easy updates and <b>rollbacks</b> (undo the update)</li>
      </ul> 
    </td>
    <td><img src="images/k8s_drawio_icons_02-Page-3.png"></td>
  </tr>
</table>
  
---

## ReplicaSet - self-healing and scalability
 - If a Pod managed be a ReplicaSet fails, it will be replaced **(self-healing)**
 - We can easily increase the number of Pods **(scaling)** to handle more load (static site example)
 - It is common not to create ReplicaSet directly but use **Deployment** to manage the ReplicaSet
![img_width_90](images/k8s_drawio_icons_02-Page-4.png)  

---

## Deployment
 - Used to provide zero-downtime rolling-updates
 - Every time that we create a Deployment we automatically get a ReplicaSet that manages the Deployment's Pods
 - It important to understand that a Deployment object can only manage a **single** Pod template
![img_width_90](images/k8s_drawio_icons_02-Page-5.png)  
  
---

## Multi-container Pod 
 - We can have more that one container in Pod
 - Containers deployed in a Pod are always **co-located** 
 - They share the same **network** stack and **volumes**
![img_width_70](images/k8s_drawio_icons_02-Page-6.png) 
  
---
## Namespace
 - It is used to logically divide the cluster in multiple virtual clusters
 - For example we can have namespace for the `prod` environment and one for the `test` environment
 - For example we can have a namespace to separate independent application stacks
 - `kube-system` namespace is used for the control plane applications
 - `default` namespace is used for our workloads

 > Note:  
 > Not All kubernetes objects are in a `namespace`
