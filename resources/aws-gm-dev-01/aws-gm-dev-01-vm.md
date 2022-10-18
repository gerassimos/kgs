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

## Associate an elastic IP and DNS name
 - [Elastic IP addresses](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#using-instance-addressing-eips-allocating)
 - The DNS name is automatically defined from the IP and visible only after is assigned to the ec2 instance

