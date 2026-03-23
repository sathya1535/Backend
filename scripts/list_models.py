import requests
import json

GEMINI_API_KEY = "AIzaSyDYyXV19Nv1Pjg-p7_fCM-rep1efaRW0eY"
url = f"https://generativelanguage.googleapis.com/v1beta/models?key={GEMINI_API_KEY}"

for version in ["v1", "v1beta"]:
    print(f"\n--- Checking {version} ---")
    url = f"https://generativelanguage.googleapis.com/{version}/models?key={GEMINI_API_KEY}"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            models = response.json().get('models', [])
            for model in models:
                if "generateContent" in model.get("supportedGenerationMethods", []):
                    print(f"- {model['name']}")
        else:
            print(f"Error {version}: {response.status_code}")
    except Exception as e:
        print(f"Exception {version}: {e}")
