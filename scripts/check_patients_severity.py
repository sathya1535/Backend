import mysql.connector

def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="medisev"
    )

def check_patients():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, name, severity_level, severity_score FROM patients ORDER BY id DESC LIMIT 5")
    patients = cursor.fetchall()
    for p in patients:
        print(f"ID: {p['id']}, Name: {p['name']}, Severity: {p['severity_level']}, Score: {p['severity_score']}")
    conn.close()

if __name__ == "__main__":
    check_patients()
