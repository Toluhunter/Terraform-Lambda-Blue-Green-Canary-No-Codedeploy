import json
import os
import uuid
from datetime import datetime, timezone

import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def handler(event, context):
    body = json.loads(event.get("body") or "{}")

    item = {
        "id": str(uuid.uuid4()),
        "title": body.get("title", ""),
        "content": body.get("content", ""),
        "created_at": datetime.now(timezone.utc).isoformat(),
    }

    table.put_item(Item=item)

    return {
        "statusCode": 201,
        "headers": {
            "Content-Type": "application/json",
            "X-Function-Version": context.function_version,
        },
        "body": json.dumps(item),
    }
