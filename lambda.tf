 resource "null_resource" "install_python_dependencies" {

  # use triggers to for re-run bash script everytime so code changes can be applied
    triggers = {
     always_run = timestamp()
   }
   provisioner "local-exec" {
     command = "bash ${path.module}/scripts/create_pkg.sh"


     environment = {
      source_code_dir = var.code_directory
      package_directory = var.package_directory
      path_cwd = path.cwd
     }
   }
 }



data "archive_file" "zip_the_python_code" {
type        = "zip"
source_dir  = "${path.module}/${var.package_directory}/" #source folder to zip
output_path = "${path.module}/${var.archive_name}" #zip file output directory

depends_on = [null_resource.install_python_dependencies]

}


resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = data.archive_file.zip_the_python_code.output_path
function_name                  = var.function_name
role                           = aws_iam_role.lambda_role.arn
handler                        = var.handler #<filename_without extension>.<function in file name>
runtime                        = var.runtime


  environment {
    variables = {
      foo = "bar"
    }
  } 

  #   vpc_config {
  #   subnet_ids         = var.subnet_ids
  #   security_group_ids = var.security_group_ids
  # }
source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role, data.archive_file.zip_the_python_code]
}



#S3 trigger 

#create random suffix
resource "random_string" "suffix" {
  length  = 6
  lower = true
  upper = false
  special = false
}

resource "aws_s3_bucket" "bucket" {
  #bucket name with random string as suffix
  bucket = "${var.function_name}-${var.environment}-${random_string.suffix.result}"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.terraform_lambda_func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}




resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.terraform_lambda_func.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "/" #folder path e.g. "path/to/folder/"
    filter_suffix       = ".MP4" #file type e.g. ".csv"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}