import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "", 
    "database": "medisev_db"
}

def get_pass():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT email, password FROM doctors")
        results = cursor.fetchall()
        for r in results:
            print("---START---")
            print(f"EMAIL: {r['email']}")
            print(f"PASS: {r['password']}")
            print("---END---")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    get_pass()
