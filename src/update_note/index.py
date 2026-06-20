import json
import os

import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def handler(event, context):
    note_id = event["pathParameters"]["id"]
    body = json.loads(event.get("body") or "{}")

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

    updates = {k: body[k] for k in ("title", "content") if k in body}
    if not updates:
        return {
            "statusCode": 400,
            "headers": {
                "Content-Type": "application/json",
                "X-Function-Version": context.function_version,
            },
            "body": json.dumps({"message": "No fields to update"}),
        }

    expression = "SET " + ", ".join(f"#{k} = :{k}" for k in updates)
    response = table.update_item(
        Key={"id": note_id},
        UpdateExpression=expression,
        ExpressionAttributeNames={f"#{k}": k for k in updates},
        ExpressionAttributeValues={f":{k}": v for k, v in updates.items()},
        ReturnValues="ALL_NEW",
    )

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "X-Function-Version": context.function_version,
        },
        "body": json.dumps(response["Attributes"]),
    }
