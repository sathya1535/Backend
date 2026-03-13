import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def check_notifications():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM notifications ORDER BY created_at DESC LIMIT 10")
        rows = cursor.fetchall()
        print(f"Total notifications found: {len(rows)}")
        for row in rows:
            print(row)
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    check_notifications()
