import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "", 
    "database": "medisev_db"
}

def check_schema():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()
    print("Tables in medisev_db:")
    for (table,) in tables:
        print(f"- {table}")
        cursor.execute(f"DESCRIBE {table}")
        columns = cursor.fetchall()
        for col in columns:
            print(f"  {col[0]} ({col[1]})")
    cursor.close()
    conn.close()

if __name__ == "__main__":
    try:
        check_schema()
    except Exception as e:
        print(f"Error: {e}")
