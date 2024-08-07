
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

resource "random_pet" "lambda_bucket_name" {
  prefix = "ingresso-lambda-bucket"
  length = 4
}


resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lambda_bucket_name.id
}

resource "aws_s3_bucket_ownership_controls" "lambda_bucket" {
  bucket = aws_s3_bucket.lambda_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "lambda_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.lambda_bucket]

  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}


resource "aws_s3_object" "lambda_s3_ingresso" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "IncluirCadastroFilmeFunction.zip"
  source = data.archive_file.lambda_zip.output_path

  etag = filemd5(data.archive_file.lambda_zip.output_path)
}


resource "aws_lambda_function" "lambda_cadastro_filme" {
  function_name = "IncluirCadastroFilmeFunction"
  s3_bucket     = aws_s3_bucket.lambda_bucket.id
  s3_key        = aws_s3_object.lambda_s3_ingresso.key

  role             = data.aws_iam_role.lambda_role.arn
  handler          = "IncluirCadastroFilmeFunction::IncluirCadastroFilmeFunction.Function::FunctionHandler"
  runtime          = "dotnet8"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  depends_on = [null_resource.force_deploy]


  environment {
    variables = {
    }
  }
}


resource "aws_cloudwatch_log_group" "lambda_log_ingresso" {
  name = "/aws/lambda/${aws_lambda_function.lambda_cadastro_filme.function_name}"

  retention_in_days = 30
}

