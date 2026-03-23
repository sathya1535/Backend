import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def list_all_columns():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        cursor.execute("DESCRIBE notifications")
        cols = cursor.fetchall()
        for col in cols:
            print(f"Col: {col[0]}, Type: {col[1]}, Null: {col[2]}, Default: {col[4]}")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    list_all_columns()
