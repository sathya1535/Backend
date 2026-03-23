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
        cursor.execute("SHOW TABLES LIKE 'analysis_results'")
        table = cursor.fetchone()
        if table:
            print("Table 'analysis_results' exists.")
            cursor.execute("DESC analysis_results")
            cols = cursor.fetchall()
            for col in cols:
                print(f"Column: {col}")
        else:
            print("Table 'analysis_results' does NOT exist.")
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Database error: {e}")

if __name__ == "__main__":
    check_table()
