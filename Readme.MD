# Python app with dependencies deployed via Terraform

## Requirements
1. Python 3
2. PIP
3. Terraform



## Notes for `terraform/env/dev.tfvars`
1. Adjust `code_directory` paramter to the folder with the python code
2. Adjust `function_name` parameter to desired name of function
3. Adjust `handler` parameter according to name of python file and function in python file e.g. `<file_name_without_extension>.<name_of_function>`


## Commands
1. `cd terraform`
2. `terraform init`
3. `terraform plan -var-file=env/dev.tfvars`
4. `terraform apply -var-file=env/dev.tfvars --auto-approve`