class: center, middle
# Section 9  
## Helm Getting Started  

---
## Section topics
 - What is Helm 
 - Helm Installation
 - Quickstart Guide 
 - Chart template basic example
 - 
 
---
## What is Helm
 - Helm is used to manage our Kubernetes Deployments
 - Deployments = All k8s objects (Pod, Services etc..) of an applications
 - Single command to deploy an Application
 - Single command to upgrade an Application
 - Single command to delete an Application
 - Client side tool (on top of kubectl)
 - "Package manager for Kubernetes"
 - Next tool to learn after Docker and Kubernetes
 - Helm via [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)

---
## Helm Installation
 - TODO

---
## Chart template basic example
 - [helm-basic-example]() => minimal Helm application deployment  
 - To develop if Helm Chart  => [Chart Template Guide](https://helm.sh/docs/chart_template_guide/getting_started/)
---
## Chart directory structure
```console
➜  helm-basic-example git:(main) ✗ tree .
.
├── Chart.yaml
├── templates
│       ├── _helpers.tpl
│       ├── deployment.yaml
│       └── service.yaml
└── values.yaml
```
---
## Chart reference to values.yaml
 - We use the double curly braces to reference our values.yaml file
 - Example in deployment.yaml we use `{{ .Values.deployment.replicaCount }}`
 - For the container image we concatenated 2 templated values separated with `:`
 - `"{{ .Values.deployment.image.repository }}:{{ .Values.deployment.image.tag }}"`
---

## Deploy Chart 