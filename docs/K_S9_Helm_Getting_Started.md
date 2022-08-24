class: center, middle
# Section 9  
## Helm Getting Started  

---
## Section topics
 - What is Helm 
 - Helm Installation
 - Chart template basic example
 - Quickstart Guide
 
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
 - [helm-basic-example](https://github.com/gerassimos/kgs/tree/main/resources/helm-basic-example) => minimal Helm application deployment  
 - To develop if Helm Chart  => [Chart Template Guide](https://helm.sh/docs/chart_template_guide/getting_started/)
 - To set our development environment for this example  
   - Clone the `kgs` repository from github
   - cd in to the `helm-basic-example` directory  
```console
git clone https://github.com/gerassimos/kgs.git
cd kgs/resources/helm-basic-example
```
---
## Chart directory structure
```console
$ helm-basic-example: tree .
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
 - Example in deployment.yaml we use 
```yaml
{{ .Values.deployment.replicaCount }}
```
 - For the container image we concatenated 2 templated values separated with `:`
```yaml
{{ .Values.deployment.image.repository }}:{{ .Values.deployment.image.tag }}
```
---

## Deploying The Chart
 - To install a chart, we can run the `helm install` command
```console
helm install my-first-chart .
NAME: my-first-chart
LAST DEPLOYED: Wed Aug 24 17:25:46 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
```
 - Note that in the installation command we used `.` 
 - This is to specify the local directory where the chart's yaml files are located
 - We can also upload the chart to a helm registry
---
## View the deployed objects
 - Run the `kubectl get` commands to verify that the expected Kubernetes objects are actually deployed
```console
$ kubectl get deployments
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
nginx           0/1     0            0           5m54s
$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
nginx        ClusterIP   10.98.16.33     <none>        80/TCP     5m59s
```
---
## View Helm installation
- The `helm list` (or `helm ls`) command will show us the list of all deployed releases
```console
helm list
NAME          	NAMESPACE	REVISION	UPDATED                              	STATUS  	CHART                   	APP VERSION
my-first-chart	default  	1       	2022-08-24 17:25:46.849402 +0300 EEST	deployed	helm-basic-example-0.1.0	1.16.0
```
---
## Uninstall a Release
 - To uninstall a release, use the `helm uninstall` command

```console
helm uninstall my-first-chart
release "my-first-chart" uninstalled

$ kubectl get deployments
NAME            READY   UP-TO-DATE   AVAILABLE   AGE

$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
```
 - In production cases a helm deployment will contain a bigger number of Kubernetes objects
