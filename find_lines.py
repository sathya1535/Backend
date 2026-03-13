import os

file_path = r"c:\Users\dhoni\OneDrive\Desktop\medisev_backend\app.py"
with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()
    for i, line in enumerate(lines):
        if "INSERT INTO notifications (message, target_role, doctor_id) VALUES (%s, %s, %s)" in line:
            print(f"Line {i+1}: '{line.strip()}'")
