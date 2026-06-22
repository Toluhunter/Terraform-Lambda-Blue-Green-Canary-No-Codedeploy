output "api_url" {
  description = "Base invoke URL for the notes API"
  value       = aws_apigatewayv2_stage.prod.invoke_url
}

output "create_note_version" {
  description = "Latest published version of the CreateNote function"
  value       = module.create_note.version
}

output "get_note_version" {
  description = "Latest published version of the GetNote function"
  value       = module.get_note.version
}
