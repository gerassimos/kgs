## Description 
 - Everything about my development VM on AWS

## Software
 - [eks-cmd-01-init](../pg-eks/eks-cmd-01-init.md)

## kubectl completion bash 
```shell 
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
```