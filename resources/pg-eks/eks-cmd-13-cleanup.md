# Cleanup

## Delete all AWS resources of the course 
 - The EKS clusters were deleted (in section 12) with the `eksctl delete cluster` command
 - All Kubernetes resources were deleted via the k8s-dashboard (pvc,pv etc..)
 - The EFS resource was deleted from AWS web console
 - CloudFormation Stacks -> deleted  from AWS web console
 - [My notes] Delete IAM roles created for the EKS clusters 