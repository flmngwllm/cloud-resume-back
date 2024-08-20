import boto3


def lambda_handler(event, context):
  dynamodb = boto3.resource('dynamodb')
  
  table = dynamodb.Table('webvisit')
  response = table.update_item(
      Key={
          "visitor_id" : "1"
   },
      UpdateExpression='SET visit_count = visit_count + :val',
      ExpressionAttributeValues={
          ':val' : 1
   },
   ReturnValues="UPDATED_NEW"
  )
  return response

