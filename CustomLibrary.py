import requests
import base64
import json
import sys
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

api_token = os.getenv("PRACTITEST_API_TOKEN")


class CustomLibrary:
    def capture_test_case_status(self, test_name, status, execution_time, log_file):
        print(f"Recording test case: {test_name}")
        print(f"Status: {status}")
        print(f"Execution time: {execution_time}")

        # instance_id = "104848515"
        instance_id = test_name.split()[0]
        if status == "PASS":
            int_status = 0
        else:
            int_status = 1

        url = f"https://api.practitest.com/api/v2/projects/29507/runs.json"
        headers = {
            "Content-Type": "application/json",
            "PTToken": api_token
        }

        print(f"Received file name: {log_file}")

        # Read file as binary
        with open(log_file, 'rb') as f:
            os.fsync(f.fileno())
            log_file_content = f.read()

        # Encode the binary content in base64
        log_file_content_encoded = base64.b64encode(log_file_content).decode('utf-8')

        # Construct the payload
        payload = {
            "data": {
                "type": "instances",
                "attributes": {
                    "instance-id": instance_id,
                    "exit-code": int_status, 
                    "automated-execution-output": execution_time
                },
                "files": {
                    "data": [
                        {
                            "filename": "log.html",
                            "content_encoded": log_file_content_encoded  # Base64 encoded content
                        }
                    ]
                }
            }
        }


        # print(payload)
        response = requests.post(url, json=payload, headers=headers)
        if response.status_code == 200:
            print("Test case status recorded successfully.")
        else:
            print(f"Failed to record test case status. Status code: {response.status_code}, Response: {response.text}")

