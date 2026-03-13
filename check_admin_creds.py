import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "", 
    "database": "medisev_db"
}

def check_admin():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id, fullname, email, password FROM doctors WHERE email = 'medisevadmin@gmail.com'")
        admin = cursor.fetchone()
        if admin:
            print(f"Admin found: {admin}")
        else:
            print("Admin not found in 'doctors' table.")
            
        # Also check if there are other admins
        cursor.execute("SELECT id, fullname, email FROM doctors WHERE specialization = 'System Admin'")
        admins = cursor.fetchall()
        print(f"Admins by specialization: {admins}")
        
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    check_admin()
