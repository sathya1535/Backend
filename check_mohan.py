import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def check_mohan():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id, fullname, email FROM doctors WHERE email LIKE '%aanagalamohan%'")
        row = cursor.fetchone()
        print(f"Logged in user info: {row}")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    check_mohan()
