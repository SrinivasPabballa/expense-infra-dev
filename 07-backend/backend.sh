#!/bin/bash
component=$1
environment=$2
dnf install ansible -y
# sudo yum  install ansible -y
pip3.9 install botocore boto3
ansible-pull -i localhost, -U  https://github.com/SrinivasPabballa/expense-ansible-roles-test.git main.yaml -e COMPONENT=backend -e ENVIRONMENT=$1
 