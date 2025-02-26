Step1: attach the cloudwatch policies to nodegroup role


aws iam attach-role-policy \
--role-name eksctl-odoo-nodegroup-odoo-ng-NodeInstanceRole-mmdEz6E3RYuz \
--policy-arn arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy \ 
--policy-arn arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess


Step2: run cloudwatch.sh under cloudwatch folder.
