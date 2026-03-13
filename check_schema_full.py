import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def check_schema_full():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        cursor.execute("DESCRIBE notifications")
        columns = cursor.fetchall()
        print("Field | Type | Null | Key | Default | Extra")
        print("-" * 50)
        for col in columns:
            print(" | ".join(map(str, col)))
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    check_schema_full()
