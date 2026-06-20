import json
import os

import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def handler(event, context):
    note_id = event["pathParameters"]["id"]

    response = table.get_item(Key={"id": note_id})
    item = response.get("Item")

    if not item:
        return {
            "statusCode": 404,
            "headers": {
                "Content-Type": "application/json",
                "X-Function-Version": context.function_version,
            },
            "body": json.dumps({"message": "Note not found"}),
        }

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "X-Function-Version": context.function_version,
        },
        "body": json.dumps(item),
    }
