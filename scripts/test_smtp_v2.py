import smtplib
import traceback

def test():
    try:
        print("Testing SMTP connection to smtp.gmail.com:587...")
        server = smtplib.SMTP('smtp.gmail.com', 587, timeout=20)
        print("Connected. Sending EHLO...")
        server.ehlo()
        print("Sending STARTTLS...")
        server.starttls()
        print("EHLO again...")
        server.ehlo()
        print("Attempting login for medisev.app@gmail.com...")
        server.login('medisev.app@gmail.com', 'mrtu cshg wknr gvlb')
        print("LOGIN SUCCESSFUL!")
        server.quit()
        print("Test finished successfully.")
    except Exception as e:
        print(f"SMTP TEST FAILED!")
        traceback.print_exc()

if __name__ == "__main__":
    test()
