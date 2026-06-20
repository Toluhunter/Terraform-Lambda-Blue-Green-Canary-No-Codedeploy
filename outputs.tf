output "api_url" {
  description = "Base invoke URL for the notes API"
  value       = aws_apigatewayv2_stage.prod.invoke_url
}
