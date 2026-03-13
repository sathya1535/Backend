import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def migrate():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        
        # Make legacy columns nullable to prevent 500 errors
        for col in ['vitals_id', 'severity_score', 'severity_level']:
            cursor.execute(f"SHOW COLUMNS FROM analysis_results LIKE '{col}'")
            if cursor.fetchone():
                print(f"Modifying {col} to be NULL...")
                if col == 'vitals_id':
                    cursor.execute("ALTER TABLE analysis_results MODIFY COLUMN vitals_id INT NULL")
                elif col == 'severity_score':
                    cursor.execute("ALTER TABLE analysis_results MODIFY COLUMN severity_score FLOAT NULL")
                elif col == 'severity_level':
                    cursor.execute("ALTER TABLE analysis_results MODIFY COLUMN severity_level VARCHAR(20) NULL")
        
        # Add missing columns if they aren't there
        cursor.execute("SHOW COLUMNS FROM analysis_results LIKE 'doctor_id'")
        if not cursor.fetchone():
            print("Adding doctor_id...")
            cursor.execute("ALTER TABLE analysis_results ADD COLUMN doctor_id INT")
            
        cursor.execute("SHOW COLUMNS FROM analysis_results LIKE 'severity_result'")
        if not cursor.fetchone():
            print("Adding severity_result...")
            cursor.execute("ALTER TABLE analysis_results ADD COLUMN severity_result VARCHAR(50)")
            
        conn.commit()
        print("Migration successful.")
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    migrate()
