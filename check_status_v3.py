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
        for col in cols:
            print(f"{col[0]}|{col[1]}|{col[2]}|{col[3]}|{col[4]}|{col[5]}")
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Database error: {e}")

if __name__ == "__main__":
    check_table()
