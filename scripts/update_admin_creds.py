import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "", 
    "database": "medisev_db"
}

def update_admin():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)
    try:
        # Check if old admin exists
        cursor.execute("SELECT * FROM doctors WHERE email = 'admin@medisev.com'")
        old_admin = cursor.fetchone()
        
        if old_admin:
            print("Updating existing old admin...")
            cursor.execute("""
                UPDATE doctors 
                SET email = 'medisevadmin@gmail.com', password = 'adminmedisev', fullname = 'Admin User'
                WHERE email = 'admin@medisev.com'
            """)
        else:
            # Check if new admin exists
            cursor.execute("SELECT * FROM doctors WHERE email = 'medisevadmin@gmail.com'")
            new_admin = cursor.fetchone()
            if not new_admin:
                print("Inserting new admin...")
                cursor.execute("""
                    INSERT INTO doctors (fullname, email, password, specialization, phone, is_active)
                    VALUES ('Admin User', 'medisevadmin@gmail.com', 'adminmedisev', 'System Admin', '9999999999', 1)
                """)
            else:
                print("New admin already exists, updating password just in case...")
                cursor.execute("""
                    UPDATE doctors 
                    SET password = 'adminmedisev'
                    WHERE email = 'medisevadmin@gmail.com'
                """)
        
        conn.commit()
        print("Success: Admin credentials updated in database.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    update_admin()
