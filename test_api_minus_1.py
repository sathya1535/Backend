import requests

def test_notifications_api_minus_1():
    # Test for Doctor ID -1
    url = "http://127.0.0.1:5000/notifications?role=doctor&doctor_id=-1"
    try:
        response = requests.get(url)
        print(f"Status: {response.status_code}")
        print(f"Response: {response.json()}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    test_notifications_api_minus_1()
