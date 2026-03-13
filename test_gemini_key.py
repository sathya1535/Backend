import requests
import json

GEMINI_API_KEY = "AIzaSyD0vvHBsGZz2dYpmNrRuJjDyAMviWBupkM"
url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key={GEMINI_API_KEY}"

payload = {
    "contents": [{
        "parts": [{"text": "Hello, are you working?"}]
    }]
}

try:
    response = requests.post(url, headers={"Content-Type": "application/json"}, json=payload)
    print(f"Status: {response.status_code}")
    print(f"Response: {response.text}")
except Exception as e:
    print(f"Error: {e}")
