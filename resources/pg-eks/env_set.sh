#!/bin/bash
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
export AWS_PROFILE=aws-my-eks-pg-2
env | grep -i -e AWS_PROFILE -e KUBECONFIG