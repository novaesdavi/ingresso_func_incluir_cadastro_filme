
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
  required_version = ">= 1.0.4"
}


data "aws_iam_role" "lambda_role" {
  name = "lambda_ingresso_incrluir_cadastro_role"
}

# resource "aws_iam_role" "lambda_role" {
#   name = "lambda_ingresso_incrluir_cadastro_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       },
#     ]
#   })

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = data.aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = path.module
  output_path = "${path.module}/IncluirCadastroFilmeFunction.zip"
}


resource "null_resource" "force_deploy" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo 'Forcing Lambda deployment'"
  }
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "IncluirCadastroFilmeFunction"
  role          = data.aws_iam_role.lambda_role.arn
  handler       = "IncluirCadastroFilmeFunction::IncluirCadastroFilmeFunction.Function::FunctionHandler"
  runtime       = "dotnet8"
  filename      = data.archive_file.lambda_zip.output_path
  depends_on    = [null_resource.force_deploy]

  environment {
    variables = {
      # Add any environment variables your Lambda function needs here
    }
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
}
