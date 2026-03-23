import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def check_analysis_results_schema():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SHOW COLUMNS FROM analysis_results")
        columns = cursor.fetchall()
        print("COLUMNS IN analysis_results:")
        for col in columns:
            print(f"- {col['Field']} ({col['Type']})")
            
        cursor.execute("SELECT * FROM analysis_results LIMIT 1")
        sample = cursor.fetchone()
        print("\nSAMPLE RECORD:")
        print(sample)
    except Exception as e:
        print(f"ERROR: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    check_analysis_results_schema()
