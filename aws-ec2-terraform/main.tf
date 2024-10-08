
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

provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}


resource "aws_iam_role" "lambda_role" {
  name = "lambda_ingresso_incrluir_cadastro_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
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
  role          = aws_iam_role.lambda_role.arn
  handler       = "IncluirCadastroFilmeFunction::IncluirCadastroFilmeFunction.Function::FunctionHandler"
  runtime       = "dotnet8"
  filename      = "./IncluirCadastroFilmeFunction.zip"
  depends_on    = [null_resource.force_deploy]

}


