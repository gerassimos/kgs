## Description 
 - Everything about my development VM on AWS

## Software
 - [eks-cmd-01-init](../pg-eks/eks-cmd-01-init.md)

## kubectl/eksctl completion bash 
```shell 
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc

# eksctl
eksctl completion bash | sudo tee /etc/bash_completion.d/eksctl> /dev/null
```

