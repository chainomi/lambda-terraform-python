resource "aws_iam_role" "lambda_role" {
name   = "${var.function_name}-${var.environment}-lambdarole"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

#add all permissions you need for lambda role here 
# example cloud watch for logs, s3 for trigger and permissions for networking subnets and security groups
resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "${var.function_name}-${var.environment}-policy-lambdarole"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "s3:*",
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents",
       "ec2:DescribeSecurityGroups",
       "ec2:DescribeSubnets",
       "ec2:DescribeVpcs",  
       "ec2:CreateNetworkInterface",
       "ec2:DescribeNetworkInterfaces",
       "ec2:DeleteNetworkInterface"
     ],
     "Resource": "*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}