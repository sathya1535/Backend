import mysql.connector
from datetime import datetime

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def create_admin_notification():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        message = "ADMIN ALERT: System maintenance at midnight."
        
        cursor.execute(
            "INSERT INTO notifications (message, target_role, doctor_id, created_at) VALUES (%s, %s, %s, %s)",
            (message, 'admin', None, datetime.now())
        )
        conn.commit()
        print("Created admin notification.")
        
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    create_admin_notification()
