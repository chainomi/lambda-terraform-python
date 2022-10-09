# Python app with dependencies deployed via Terraform
1. Adjust terraform/env/dev.tfvars to your liking
2. 
## Commands
1. `cd terraform`
2. `terraform init`
3. `terraform plan -var-file=env/dev.tfvars`
4. `terraform apply -var-file=env/dev.tfvars --auto-approve`