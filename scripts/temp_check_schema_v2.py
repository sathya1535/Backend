import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def check_schema():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    tables = ["analysis_results", "advanced_assessments"]
    try:
        for table in tables:
            print(f"\n--- TABLE: {table} ---")
            cursor.execute(f"DESCRIBE {table}")
            cols = cursor.fetchall()
            for col in cols:
                print(f"Col: {col[0]}")
    except Exception as e:
                print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    check_schema()
