
# API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name = "ResumeCounterAPI"
}

resource "aws_api_gateway_resource" "resource" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "counter"
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "get_method" {
   
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.resource.id
  rest_api_id   = aws_api_gateway_rest_api.api.id

 
}

resource "aws_api_gateway_method" "put_method" {
  
  authorization = "NONE"
  http_method   = "PUT"
  resource_id   = aws_api_gateway_resource.resource.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_integration" "get_integration" {
  
  http_method = aws_api_gateway_method.get_method.http_method
  resource_id = aws_api_gateway_resource.resource.id
  rest_api_id = aws_api_gateway_rest_api.api.id
  type        = "AWS_PROXY"
  uri         = "arn:aws:apigateway:${var.REGION}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda.arn}/invocations"
  
}

resource "aws_api_gateway_integration" "put_integration" {
  
  http_method = aws_api_gateway_method.put_method.http_method
  resource_id = aws_api_gateway_resource.resource.id
  rest_api_id = aws_api_gateway_rest_api.api.id
  type        = "AWS_PROXY"
   uri        = "arn:aws:apigateway:${var.REGION}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda.arn}/invocations"


}

resource "aws_api_gateway_deployment" "deploy" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.resource.id,
      aws_api_gateway_method.get_method.id,
      aws_api_gateway_integration.get_integration.id,
      aws_api_gateway_method.put_method.id,
      aws_api_gateway_integration.put_integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deploy.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "Prod"
}






