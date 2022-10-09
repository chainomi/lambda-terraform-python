# Python app with dependencies deployed via Terraform

## Requirements
1. Python 3
2. PIP
3. Terraform

# Pre deployment
1. Setup s3 or terraform cloud as backend for state files.

## Notes for `terraform/env/dev.tfvars`
1. Adjust `code_directory` paramter to the folder with the python code.
2. Adjust `function_name` parameter to desired name of function.
3. Adjust `handler` parameter according to name of python file and function.in python file e.g. `<file_name_without_extension>.<name_of_function>`

## Notes for Lambda


## Deploy Commands
1. `cd terraform`
2. Configure aws credentials
3. `terraform init`
4. `terraform plan -var-file=env/dev.tfvars`
5. `terraform apply -var-file=env/dev.tfvars --auto-approve`