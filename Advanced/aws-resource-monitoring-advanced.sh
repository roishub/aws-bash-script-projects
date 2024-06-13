#!/bin/bash

################################
# Author: Rois 
# Date: 12th-june-24
# Version: v2
# This script will report the AWS resource usage 
# We will monitor EC2, S3, IAM, Lambda
######################################################


# Define AWS region and profile (if any)
REGION="us-east-1"
PROFILE="default"

# Enhanced output formatting
echo "========================================="
echo "AWS Resource Usage Report"
echo "Date: $(date)"
echo "Region: $REGION"
echo "========================================="

# Error handling function
error_handler() {
    echo "Error occurred in script at line: $1"
    exit 1
}

trap 'error_handler $LINENO' ERR

# List S3 buckets with sizes
echo "Print list of S3 buckets:"
aws s3 ls --profile $PROFILE --region $REGION
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text --profile $PROFILE --region $REGION); do
    echo "Bucket: $bucket"
    aws s3 ls s3://$bucket --recursive --summarize --human-readable --profile $PROFILE --region $REGION | grep "Total Size"
done

# List EC2 instances with status
echo "Print list of EC2 instances:"
aws ec2 describe-instances --profile $PROFILE --region $REGION --query "Reservations[].Instances[].{ID:InstanceId,Type:InstanceType,State:State.Name,Tags:Tags}" --output table

# List AWS Lambda functions with memory size
echo "Print list of Lambda functions:"
aws lambda list-functions --profile $PROFILE --region $REGION --query "Functions[].{Name:FunctionName,MemorySize:MemorySize}" --output table

# List IAM users
echo "Print list of IAM users:"
aws iam list-users --profile $PROFILE --query "Users[].{UserName:UserName,CreateDate:CreateDate}" --output table

# List IAM roles
echo "Print list of IAM roles:"
aws iam list-roles --profile $PROFILE --query "Roles[].{RoleName:RoleName,CreateDate:CreateDate}" --output table

# Send email notification (requires configured AWS SES)
# echo "Sending email notification..."
# aws ses send-email --from "roisthomas@proton.me" --destination "ToAddresses=recipient@example.com" --message "Subject={Data=AWS Resource Usage Report,Charset=utf8},Body={Text={Data=$(cat /path/to/report.log),Charset=utf8}}" --profile $PROFILE --region $REGION

# Redirect output to a log file with timestamp
LOG_FILE="aws_resource_report_$(date +'%Y%m%d_%H%M%S').log"
exec > >(tee -a $LOG_FILE) 2>&1

# CSV Export (example for EC2 instances)
echo "Exporting EC2 instance list to CSV..."
aws ec2 describe-instances --profile $PROFILE --region $REGION --query "Reservations[].Instances[].{ID:InstanceId,Type:InstanceType,State:State.Name}" --output text | tr -s '\t' ',' > ec2_instances.csv

echo "AWS Resource Usage Report Completed"
