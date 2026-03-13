import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "medisev_db"
}

def list_cols():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    cursor.execute("DESCRIBE notifications")
    for col in cursor.fetchall():
        print(f"COL:{col[0]} | NULL:{col[2]} | DEF:{col[4]}")
    conn.close()

if __name__ == "__main__":
    list_cols()
