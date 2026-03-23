import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "", 
    "database": "medisev_db"
}

def update_login_history_table():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    try:
        print("Checking/Updating login_history table...")
        
        # 1. Update Columns: Rename 'name' to 'doctor_name' if it exists to match app.py logic, 
        # or ensure 'name' exists. The user said it currently has 'name'.
        # Let's check existing columns first.
        cursor.execute("SHOW COLUMNS FROM login_history")
        columns = [col[0] for col in cursor.fetchall()]
        
        # User said table has: id, name, timestamp
        # We need: id, name, email, role, timestamp
        
        if 'email' not in columns:
            print("Adding 'email' column...")
            cursor.execute("ALTER TABLE login_history ADD COLUMN email VARCHAR(255) AFTER name")
            
        if 'role' not in columns:
            print("Adding 'role' column...")
            cursor.execute("ALTER TABLE login_history ADD COLUMN role VARCHAR(50) AFTER email")
            
        # Ensure 'doctor_name' vs 'name' consistency. 
        # app.py (line 358) uses 'doctor_name', but user says table has 'name'.
        # Let's standardize on 'doctor_name' to match backend code or keep 'name'.
        # I will add 'doctor_name' and copy 'name' if necessary, then drop 'name' to keep it clean.
        if 'doctor_name' not in columns:
            print("Adding 'doctor_name' column to match backend logic...")
            cursor.execute("ALTER TABLE login_history ADD COLUMN doctor_name VARCHAR(255) AFTER id")
            if 'name' in columns:
                cursor.execute("UPDATE login_history SET doctor_name = name")
        
        conn.commit()
        print("Successfully updated login_history schema.")
        
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    update_login_history_table()
