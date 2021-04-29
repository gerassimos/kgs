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
 - Verify that the kubernetes objects of the `front-end` deployment are created successfully. 
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
 - Use the busybox "helper" POD to test the DNS resolution of the `back-end` service

---

## Exercises -  Solution 
TODO