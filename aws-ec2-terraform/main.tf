
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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

resource "aws_lambda_function" "my_lambda" {
  function_name = "IncluirCadastroFilmeFunction"
  role          = aws_iam_role.lambda_role.arn
  handler       = "IncluirCadastroFilmeFunction::IncluirCadastroFilmeFunction.Function::FunctionHandler"
  runtime       = "dotnet8"

  # Assuming your Lambda code is in a file called "lambda_function.zip"
  filename         = "../src/IncluirCadastroFilmeFunction/bin/Release/net8.0/IncluirCadastroFilmeFunction.zip"
  source_code_hash = filebase64sha256("../src/IncluirCadastroFilmeFunction/bin/Release/net8.0/IncluirCadastroFilmeFunction.zip")

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
