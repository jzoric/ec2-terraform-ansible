#!/usr/bin/env bash
echo "Create directory for ssh keys"
mkdir keys
echo "Generate ssh keys"
ssh-keygen -t rsa -b 4096 -f keys/dev-key
echo "Init terraform"
terraform init
echo "Run terraform"
terraform apply -auto-approve
echo "Wait before running ansible playbook (Sleep for 30s)"
sleep 30
cd ansible || exit 1
echo "Run ansible playbook"
TF_STATE=../terraform.tfstate ansible-playbook playbook.yml "--inventory-file=$(which terraform-inventory)"
echo "Done."