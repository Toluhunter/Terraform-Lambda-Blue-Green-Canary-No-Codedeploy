import json
import os

import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def handler(event, context):
    note_id = event["pathParameters"]["id"]

    existing = table.get_item(Key={"id": note_id}).get("Item")
    if not existing:
        return {
            "statusCode": 404,
            "headers": {
                "Content-Type": "application/json",
                "X-Function-Version": context.function_version,
            },
            "body": json.dumps({"message": "Note not found"}),
        }

    table.delete_item(Key={"id": note_id})

    return {
        "statusCode": 204,
        "headers": {
            "X-Function-Version": context.function_version,
        },
        "body": "",
    }
