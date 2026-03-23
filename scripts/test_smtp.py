import smtplib
try:
    print("Testing SMTP connection to smtp.gmail.com:465...")
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465, timeout=10)
    print("Connection successful! Attempting login...")
    server.login('medisev.app@gmail.com', 'mrtu cshg wknr gvlb')
    print("Login successful!")
    server.quit()
    print("Test finished.")
except Exception as e:
    print(f"SMTP Test Failed: {e}")
