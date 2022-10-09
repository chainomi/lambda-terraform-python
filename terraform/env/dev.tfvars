#general
region = "us-east-1"
environment = "dev"

#lambda
function_name = "basic-python-lambda"
handler = "index.lambda_handler"
runtime = "python3.8"
package_directory = "python_code_package"
archive_name="python_code_package.zip"
code_directory ="python"

#networking - optional
# subnet_ids = ["subnet-b84c9299", "subnet-e553b4d4"]
# security_group_ids = ["sg-a9bf618f"]
