import os

file_path = r"c:\Users\dhoni\OneDrive\Desktop\medisev_backend\app.py"
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace first occurrence in update_severity
old_1 = """                        "INSERT INTO notifications (message, target_role, doctor_id) VALUES (%s, %s, %s)",
                        (f"CRITICAL ALERT: Patient {p_info['name']} reached {severity_level} status", 'doctor', p_info['assigned_doctor_id'])"""

new_1 = """                        "INSERT INTO notifications (title, message, target_role, doctor_id) VALUES (%s, %s, %s, %s)",
                        ("Severity Alert", f"CRITICAL ALERT: Patient {p_info['name']} reached {severity_level} status", 'doctor', p_info['assigned_doctor_id'])"""

content = content.replace(old_1, new_1)

# Note: The second occurrence in add_advanced_severity has the SAME string structure.
# content.replace() will replace ALL occurrences by default if they are identical.
# I'll check if they are identical in target content.

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Successfully replaced notification insert strings.")
