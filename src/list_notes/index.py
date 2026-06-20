import json, os
import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])

def handler(event, context):
    result = table.scan(ProjectionExpression="id, title")
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "X-Function-Version": context.function_version,
        },
        "body": json.dumps(result["Items"]),
    }
