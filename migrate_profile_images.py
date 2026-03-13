import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "", 
    "database": "medisev_db"
}

def migrate():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    
    print("Checking for profile_image column in doctors...")
    cursor.execute("DESC doctors")
    columns = [col[0] for col in cursor.fetchall()]
    if "profile_image" not in columns:
        print("Adding profile_image to doctors...")
        cursor.execute("ALTER TABLE doctors ADD COLUMN profile_image VARCHAR(255) DEFAULT NULL")
        conn.commit()
    else:
        print("profile_image already exists in doctors")

    print("Checking for profile_image column in patients...")
    cursor.execute("DESC patients")
    columns = [col[0] for col in cursor.fetchall()]
    if "profile_image" not in columns:
        print("Adding profile_image to patients...")
        cursor.execute("ALTER TABLE patients ADD COLUMN profile_image VARCHAR(255) DEFAULT NULL")
        conn.commit()
    else:
        print("profile_image already exists in patients")

    # Add a sample profile picture for testing if none exists
    cursor.execute("UPDATE doctors SET profile_image = 'https://ui-avatars.com/api/?name=Doctor+Sample&background=random' WHERE profile_image IS NULL")
    cursor.execute("UPDATE patients SET profile_image = 'https://ui-avatars.com/api/?name=Patient+Sample&background=random' WHERE profile_image IS NULL")
    conn.commit()

    print("Migration successful.")
    cursor.close()
    conn.close()

if __name__ == "__main__":
    try:
        migrate()
    except Exception as e:
        print(f"Error: {e}")
