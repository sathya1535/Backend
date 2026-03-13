import requests

def test_notifications_api():
    # Test for Doctor ID 20
    url = "http://127.0.0.1:5000/notifications?role=doctor&doctor_id=20"
    try:
        response = requests.get(url)
        print(f"Status: {response.status_code}")
        print(f"Response: {response.json()}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    test_notifications_api()
