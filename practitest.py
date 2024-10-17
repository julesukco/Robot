import requests
import sys
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

api_token = os.getenv("PRACTITEST_API_TOKEN")

def record_test_case_status(instance_id, status, execution_time):
    url = f"https://api.practitest.com/api/v2/projects/29507/runs.json"
    headers = {
        "Content-Type": "application/json",
        "PTToken": api_token
    }
    payload = {
        "data": {
            "type": "instances",
            "attributes": {
                "instance-id": instance_id,
                "exit-code": status, 
                "automated-execution-output": execution_time
            }
        }
    }
    print(payload)
    response = requests.post(url, json=payload, headers=headers)
    if response.status_code == 200:
        print("Test case status recorded successfully.")
    else:
        print(f"Failed to record test case status. Status code: {response.status_code}, Response: {response.text}")

# Example usage
instance_id = "104848515"

if len(sys.argv) != 3:
    status = 0  # 0 = passed, 1 = failed
    execution_time = "Test execution time: 10 seconds"
else:
    if int(sys.argv[1]) == "PASS":
        status = 0
    else:
        status = 1
    execution_time = sys.argv[2]
    print(status)
    print(execution_time)

record_test_case_status(instance_id, status, execution_time)