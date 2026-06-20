locals {
  common_tags = {
    Project = "terraform-lambda-blue-green-canary"
  }
}

data "archive_file" "create_note" {
  type        = "zip"
  source_dir  = "${path.root}/src/create_note"
  output_path = "${path.root}/dist/create_note.zip"
}

data "archive_file" "get_note" {
  type        = "zip"
  source_dir  = "${path.root}/src/get_note"
  output_path = "${path.root}/dist/get_note.zip"
}

data "archive_file" "update_note" {
  type        = "zip"
  source_dir  = "${path.root}/src/update_note"
  output_path = "${path.root}/dist/update_note.zip"
}

data "archive_file" "list_notes" {
  type        = "zip"
  source_dir  = "${path.root}/src/list_notes"
  output_path = "${path.root}/dist/list_notes.zip"
}

data "archive_file" "delete_note" {
  type        = "zip"
  source_dir  = "${path.root}/src/delete_note"
  output_path = "${path.root}/dist/delete_note.zip"
}

module "create_note" {
  source = "./modules/lambda_function"

  function_name    = "notes-create"
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.create_note.output_path
  source_code_hash = data.archive_file.create_note.output_base64sha256

  environment_variables = {
    TABLE_NAME = aws_dynamodb_table.notes.name
  }

  dynamodb_table_arn = aws_dynamodb_table.notes.arn
  tags               = merge(local.common_tags, { Function = "create-note" })
}

module "get_note" {
  source = "./modules/lambda_function"

  function_name    = "notes-get"
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.get_note.output_path
  source_code_hash = data.archive_file.get_note.output_base64sha256

  environment_variables = {
    TABLE_NAME = aws_dynamodb_table.notes.name
  }

  dynamodb_table_arn = aws_dynamodb_table.notes.arn
  tags               = merge(local.common_tags, { Function = "get-note" })
}

module "list_notes" {
  source = "./modules/lambda_function"

  function_name    = "notes-list"
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.list_notes.output_path
  source_code_hash = data.archive_file.list_notes.output_base64sha256

  environment_variables = {
    TABLE_NAME = aws_dynamodb_table.notes.name
  }

  dynamodb_table_arn = aws_dynamodb_table.notes.arn
  tags               = merge(local.common_tags, { Function = "list-notes" })
}

module "update_note" {
  source = "./modules/lambda_function"

  function_name    = "notes-update"
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.update_note.output_path
  source_code_hash = data.archive_file.update_note.output_base64sha256

  environment_variables = {
    TABLE_NAME = aws_dynamodb_table.notes.name
  }

  dynamodb_table_arn = aws_dynamodb_table.notes.arn
  tags               = merge(local.common_tags, { Function = "update-note" })
}

module "delete_note" {
  source = "./modules/lambda_function"

  function_name    = "notes-delete"
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.delete_note.output_path
  source_code_hash = data.archive_file.delete_note.output_base64sha256

  environment_variables = {
    TABLE_NAME = aws_dynamodb_table.notes.name
  }

  dynamodb_table_arn = aws_dynamodb_table.notes.arn
  tags               = merge(local.common_tags, { Function = "delete-note" })
}
