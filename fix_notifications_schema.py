import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def fix_schema():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        # Change doctor_id to allow NULL
        cursor.execute("ALTER TABLE notifications MODIFY doctor_id INT NULL")
        conn.commit()
        print("Schema fixed: doctor_id now allows NULL.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    fix_schema()
