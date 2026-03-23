import mysql.connector
from datetime import datetime

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def create_mohan_notification():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        doctor_id = 20
        message = "PERSONAL ALERT: Dr. Mohan, your dashboard is ready."
        
        cursor.execute(
            "INSERT INTO notifications (message, target_role, doctor_id, created_at) VALUES (%s, %s, %s, %s)",
            (message, 'doctor', doctor_id, datetime.now())
        )
        conn.commit()
        print(f"Created notification for Doctor ID {doctor_id}")
        
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    create_mohan_notification()
