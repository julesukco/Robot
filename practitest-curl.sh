curl -H "Content-Type:application/json" \
-u <email>:<api_token> \
-X POST https://api.practitest.com/api/v2/projects/29507/runs.json \
-d '{"data": { "type": "instances", "attributes": {"instance-id": 104848515, "exit-code": 0, "automated-execution-output": "THIS IS MY OUTPUT" }}} '
