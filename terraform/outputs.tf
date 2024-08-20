output "function_url" {
  value = aws_lambda_function_url.test_latest.function_url
}


output "api_endpoint" {
  value       = aws_api_gateway_stage.stage.invoke_url
  description = "Endpoint URL of the deployed API"
}