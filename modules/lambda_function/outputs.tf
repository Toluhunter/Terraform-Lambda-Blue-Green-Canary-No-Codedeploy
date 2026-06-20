output "function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "alias_arn" {
  description = "ARN of the live alias"
  value       = aws_lambda_alias.live.arn
}

output "invoke_arn" {
  description = "Invoke ARN of the live alias. Use this in API Gateway integrations"
  value       = aws_lambda_alias.live.invoke_arn
}

output "function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "version" {
  description = "Latest published version number"
  value       = aws_lambda_function.this.version
}
