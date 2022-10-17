## EKS Load Balancer
 - EKS supports 
   - Classic Load Balancer
   - Application Load Balancer
   - Network Load Balancer

 - *Classic&Network Load Balancer* is for Service of type `LoadBalancer`
   - [loadbalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer) 
 - Application Load Balancer is for Ingress  Controller

## Service LoadBalancer
 - Through the service of type  `LoadBalancer` EKS will create a
   - `Classic Load Balancer` (default) [mitge tested ok 2022-10-09]
   - `Network Load Balancer` (annotation `service.beta.kubernetes.io/aws-load-balancer-type: "nlb"`)
     ```yaml
     metadata:
       name: my-service
       annotations:
         service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
     ```
   - Internal Load Balancer
   - (annotation `service.beta.kubernetes.io/aws-load-balancer-internal: 0.0.0.0/0"`)
   - Control configuration via annotation

## Application Load Balancer (Ingress Controller)
 - AWS Load Balancer Controller (formerly AWS ALB Ingress Controller)
 - [aws-load-balancer-controller](https://github.com/kubernetes-sigs/aws-load-balancer-controller)
 - ALB Ingress is supported by he EKS team
 - Supports target group of instance mode (hooked into NodePort)
 - Supports target group of IP mode (directly communicating with the pod)
 - Supports Application Load Balancer Listener rules