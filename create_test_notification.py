import mysql.connector
from datetime import datetime

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def create_test_notification():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        # Get a doctor id to test with
        cursor.execute("SELECT id FROM doctors LIMIT 1")
        doctor = cursor.fetchone()
        if not doctor:
            print("No doctors found in DB.")
            return
            
        doctor_id = doctor[0]
        message = "TEST NOTIFICATION: System check successful."
        
        cursor.execute(
            "INSERT INTO notifications (message, target_role, doctor_id, created_at) VALUES (%s, %s, %s, %s)",
            (message, 'doctor', doctor_id, datetime.now())
        )
        conn.commit()
        print(f"Created test notification for Doctor ID {doctor_id}")
        
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    create_test_notification()
