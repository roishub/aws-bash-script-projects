# AWS Resource Usage Reporting Script Features

## Debug Mode
Prints each command before executing it for easier debugging.

## AWS Region and Profile Configuration
Allows specifying AWS region and profile for the CLI commands.

## Formatted Output
Provides a clear, formatted header for the report including date and region.

## Error Handling
Includes an error handler function that prints the line number where an error occurs and exits the script.

## S3 Bucket Listing and Size Calculation
Lists all S3 buckets and calculates their total sizes.

## EC2 Instances Listing
Lists all EC2 instances, displaying their ID, type, state, and tags.

## Lambda Functions Listing
Lists all AWS Lambda functions along with their names and memory sizes.

## IAM Users Listing
Lists all IAM users with their usernames and creation dates.

## IAM Roles Listing
Lists all IAM roles with their names and creation dates.

## Email Notification (Commented Out)
Example command for sending an email notification using AWS SES.

## Logging
Redirects the output to a log file with a timestamp for later review.

## CSV Export
Exports the list of EC2 instances to a CSV file for further analysis.
