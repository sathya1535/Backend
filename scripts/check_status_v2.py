import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def check_table():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        cursor.execute("DESC analysis_results")
        cols = cursor.fetchall()
        print("COLUMNS:")
        for col in cols:
            print(col[0])
        
        cursor.execute("SELECT * FROM analysis_results LIMIT 1")
        data = cursor.fetchall()
        print(f"Sample data rows: {len(data)}")
        
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Database error: {e}")

if __name__ == "__main__":
    check_table()
