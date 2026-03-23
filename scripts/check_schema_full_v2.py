import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def check_schema_full_v2():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        cursor.execute("DESCRIBE notifications")
        columns = cursor.fetchall()
        for col in columns:
            print(f"Column: {col[0]}, Nullable: {col[2]}, Default: {col[4]}")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    check_schema_full_v2()
