import boto3
import json

dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
  
  
  table = dynamodb.Table('web_visitors')
  response = table.update_item(
      Key={
          "visitor_id" : 1
   },
      UpdateExpression='SET visit_count = visit_count + :val',
      ExpressionAttributeValues={
          ':val' : 1
   },
   ReturnValues="UPDATED_NEW"
  )
  

  updated_count = response['Attributes']['visit_count']
    
    # Returning the visit_count in a format the JavaScript expects
  return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
      
        'body': json.dumps({
            'visit_count': updated_count
        })
    }