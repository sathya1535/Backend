import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def fix_notifications_defaults():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        # Give defaults to columns to prevent insertion failures
        cursor.execute("ALTER TABLE notifications MODIFY title VARCHAR(255) DEFAULT 'Alert'")
        cursor.execute("ALTER TABLE notifications MODIFY message TEXT") # Keep it mandatory but check nullability
        cursor.execute("ALTER TABLE notifications MODIFY is_read BOOLEAN DEFAULT FALSE")
        cursor.execute("ALTER TABLE notifications MODIFY target_role VARCHAR(20) DEFAULT 'admin'")
        conn.commit()
        print("Table defaults updated to prevent insertion failures.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    fix_notifications_defaults()
