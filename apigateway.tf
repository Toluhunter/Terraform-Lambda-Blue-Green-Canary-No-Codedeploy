resource "aws_apigatewayv2_api" "notes" {
  name          = "notes-api"
  protocol_type = "HTTP"

  tags = local.common_tags
}

# Integrations

resource "aws_apigatewayv2_integration" "create_note" {
  api_id                 = aws_apigatewayv2_api.notes.id
  integration_type       = "AWS_PROXY"
  integration_uri        = module.create_note.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "get_note" {
  api_id                 = aws_apigatewayv2_api.notes.id
  integration_type       = "AWS_PROXY"
  integration_uri        = module.get_note.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "list_notes" {
  api_id                 = aws_apigatewayv2_api.notes.id
  integration_type       = "AWS_PROXY"
  integration_uri        = module.list_notes.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "update_note" {
  api_id                 = aws_apigatewayv2_api.notes.id
  integration_type       = "AWS_PROXY"
  integration_uri        = module.update_note.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "delete_note" {
  api_id                 = aws_apigatewayv2_api.notes.id
  integration_type       = "AWS_PROXY"
  integration_uri        = module.delete_note.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Routes

resource "aws_apigatewayv2_route" "create_note" {
  api_id    = aws_apigatewayv2_api.notes.id
  route_key = "POST /notes"
  target    = "integrations/${aws_apigatewayv2_integration.create_note.id}"
}

resource "aws_apigatewayv2_route" "get_note" {
  api_id    = aws_apigatewayv2_api.notes.id
  route_key = "GET /notes/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.get_note.id}"
}

resource "aws_apigatewayv2_route" "list_notes" {
  api_id    = aws_apigatewayv2_api.notes.id
  route_key = "GET /notes"
  target    = "integrations/${aws_apigatewayv2_integration.list_notes.id}"
}

resource "aws_apigatewayv2_route" "update_note" {
  api_id    = aws_apigatewayv2_api.notes.id
  route_key = "PUT /notes/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.update_note.id}"
}

resource "aws_apigatewayv2_route" "delete_note" {
  api_id    = aws_apigatewayv2_api.notes.id
  route_key = "DELETE /notes/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.delete_note.id}"
}

# Lambda permissions

resource "aws_lambda_permission" "create_note" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.create_note.function_name
  qualifier     = "live"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.notes.execution_arn}/*/*"
}

resource "aws_lambda_permission" "get_note" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.get_note.function_name
  qualifier     = "live"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.notes.execution_arn}/*/*"
}

resource "aws_lambda_permission" "list_notes" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.list_notes.function_name
  qualifier     = "live"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.notes.execution_arn}/*/*"
}

resource "aws_lambda_permission" "update_note" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.update_note.function_name
  qualifier     = "live"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.notes.execution_arn}/*/*"
}

resource "aws_lambda_permission" "delete_note" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.delete_note.function_name
  qualifier     = "live"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.notes.execution_arn}/*/*"
}

# Stage

resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.notes.id
  name        = "prod"
  auto_deploy = true

  tags = local.common_tags
}
