# EFS

## What is EFS
 - Managed NFS (network file system) that can be mounted on many EC2
 - EFS works with EC2 instances in multi-AZ
 - Highly available, scalable expensive (3xgp2), pay per use
 - We need a dedicated SG attached to the EFS that will allow EC2 instances to access

##  Enable EFS from AWS console
 - TODO

## amazon-efs-utils on worker nodes
 - Install `amazon-efs-utils` on each worker node of the cluster
 - ssh -i <my-key.pem> ec2-user@<node-DNS-name> "sudo yum install -y " amazon-efs-utils

## Install EFS-CSI-Driver/Provisioner via helm
 - `helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver`
 - `helm install aws-efs-csi-driver aws-efs-csi-driver/aws-efs-csi-driver`

## K8S application namespace side
 - Create namespace
 - Create StorageClass `provisioner: efs.csi-aws.com` (cannot find documentation on this)
 - Create RBAC `default` ServiceAccount -> `cluster-admin` ClusterRole 
 - Create PV with storageClassName 
 - Create PVC with storageClassName 

## K8S verify the mount
 - ssh into the worker node (pod using pvc)
 - `mount | grep csi`
 - ls /var/lib/kubelet/pods/xyz/volumes/...