#!/bin/bash

################################
# Author: Rois 
# Date: 12th-june-24
# Version: v1
# This script will report the AWS resource usage 
# We will monitor EC2, s3, IAM, Lambda
######################################################

set -x

# list s3 buckets
echo "Print list of S3 buckets:"
aws s3 ls

# list EC2 instances
echo "Print list of E2 instances"
aws ec2 describe-instances

# list aws lambda
echo "Print list of Lambda functions"
aws lambda list-functions

# list IAM users
echo "Print list of IAM users"
aws iam list-users
