from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
from datetime import datetime, date
import joblib
import numpy as np
import os
import random
from flask_mail import Mail, Message
import requests
import base64
import json

app = Flask(__name__)
CORS(app)

# Mail configuration
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USERNAME'] = 'medisev.app@gmail.com'  # Replace with actual email
app.config['MAIL_PASSWORD'] = 'mrtu cshg wknr gvlb'     # Replace with actual app password
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False

mail = Mail(app)

# Dictionary to store OTPs temporarily (in-memory for now, can move to DB)
otp_storage = {}

# MySQL Connection config — reconnect per-request to avoid "Commands out of sync"
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",   # XAMPP default
    "database": "medisev_db"
}

def get_db():
    conn = mysql.connector.connect(**DB_CONFIG)
    return conn

def init_db_schema():
    """Ensure all tables have necessary columns."""
    conn = get_db()
    cursor = conn.cursor()
    try:
        # Notifications initialization (existing logic)
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS notifications (
                id INT AUTO_INCREMENT PRIMARY KEY,
                doctor_id INT NULL,
                title VARCHAR(255) DEFAULT '',
                message TEXT NOT NULL,
                is_read BOOLEAN DEFAULT FALSE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                target_role VARCHAR(20) DEFAULT 'admin'
            )
        """)
        
        # Check and add title if missing
        cursor.execute("SHOW COLUMNS FROM notifications LIKE 'title'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE notifications ADD COLUMN title VARCHAR(255) DEFAULT ''")

        # Check and add is_read if missing
        cursor.execute("SHOW COLUMNS FROM notifications LIKE 'is_read'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE notifications ADD COLUMN is_read BOOLEAN DEFAULT FALSE")

        # Check and add target_role if missing
        cursor.execute("SHOW COLUMNS FROM notifications LIKE 'target_role'")
        if not cursor.fetchone():
            print("Adding target_role column to notifications...")
            cursor.execute("ALTER TABLE notifications ADD COLUMN target_role VARCHAR(20) DEFAULT 'admin'")
        
        # Check and add doctor_id if missing
        cursor.execute("SHOW COLUMNS FROM notifications LIKE 'doctor_id'")
        if not cursor.fetchone():
            print("Adding doctor_id column to notifications...")
            cursor.execute("ALTER TABLE notifications ADD COLUMN doctor_id INT NULL")

        # Login History initialization
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS login_history (
                id INT AUTO_INCREMENT PRIMARY KEY,
                doctor_name VARCHAR(255) NOT NULL,
                email VARCHAR(255) DEFAULT '',
                role VARCHAR(50) DEFAULT 'User',
                timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        """)

        # Add missing columns to login_history
        cursor.execute("SHOW COLUMNS FROM login_history LIKE 'email'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE login_history ADD COLUMN email VARCHAR(255) DEFAULT '' AFTER doctor_name")
            
        cursor.execute("SHOW COLUMNS FROM login_history LIKE 'role'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE login_history ADD COLUMN role VARCHAR(50) DEFAULT 'User' AFTER email")

        # Handle 'name' to 'doctor_name' migration for login_history if needed
        cursor.execute("SHOW COLUMNS FROM login_history LIKE 'name'")
        if cursor.fetchone():
            # Check if 'doctor_name' already exists to avoid error if both 'name' and 'doctor_name' are present
            cursor.execute("SHOW COLUMNS FROM login_history LIKE 'doctor_name'")
            if not cursor.fetchone():
                cursor.execute("ALTER TABLE login_history CHANGE COLUMN name doctor_name VARCHAR(255)")
        # Patients table initialization (ensuring severity columns exist)
        cursor.execute("SHOW COLUMNS FROM patients LIKE 'severity_level'")
        if not cursor.fetchone():
            print("Adding severity_level column to patients...")
            cursor.execute("ALTER TABLE patients ADD COLUMN severity_level VARCHAR(20) DEFAULT 'Mild'")

        cursor.execute("SHOW COLUMNS FROM patients LIKE 'severity_score'")
        if not cursor.fetchone():
            print("Adding severity_score column to patients...")
            cursor.execute("ALTER TABLE patients ADD COLUMN severity_score FLOAT DEFAULT 0")

        cursor.execute("SHOW COLUMNS FROM patients LIKE 'last_vitals_date'")
        if not cursor.fetchone():
            print("Adding last_vitals_date column to patients...")
            cursor.execute("ALTER TABLE patients ADD COLUMN last_vitals_date TIMESTAMP NULL")

        # Analysis Results table initialization
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS analysis_results (
                id INT AUTO_INCREMENT PRIMARY KEY,
                patient_id INT NOT NULL,
                doctor_id INT,
                severity_result VARCHAR(50),
                vitals_id INT NULL,
                severity_score FLOAT NULL,
                severity_level VARCHAR(20) NULL,
                recommendations TEXT NULL,
                analyzed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
            )
        """)
        
        # Ensure older versions of the table have correctly formulated columns
        # (Make sure legacy NOT NULL constraints are relaxed)
        for col_name in ['vitals_id', 'severity_score', 'severity_level']:
            cursor.execute(f"SHOW COLUMNS FROM analysis_results LIKE '{col_name}'")
            if cursor.fetchone():
                if col_name == 'vitals_id':
                    cursor.execute("ALTER TABLE analysis_results MODIFY COLUMN vitals_id INT NULL")
                elif col_name == 'severity_score':
                    cursor.execute("ALTER TABLE analysis_results MODIFY COLUMN severity_score FLOAT NULL")
                elif col_name == 'severity_level':
                    cursor.execute("ALTER TABLE analysis_results MODIFY COLUMN severity_level VARCHAR(20) NULL")

        cursor.execute("SHOW COLUMNS FROM analysis_results LIKE 'doctor_id'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE analysis_results ADD COLUMN doctor_id INT AFTER patient_id")
            
        cursor.execute("SHOW COLUMNS FROM analysis_results LIKE 'severity_result'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE analysis_results ADD COLUMN severity_result VARCHAR(50) AFTER doctor_id")

        # Vitals table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS vitals (
                id INT AUTO_INCREMENT PRIMARY KEY,
                patient_id INT NOT NULL,
                blood_pressure VARCHAR(20),
                heart_rate INT,
                spo2 INT,
                temperature FLOAT,
                respiratory_rate INT,
                blood_glucose FLOAT,
                recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
            )
        """)

        # Symptoms table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS symptoms (
                id INT AUTO_INCREMENT PRIMARY KEY,
                patient_id INT NOT NULL,
                symptom_name VARCHAR(255),
                recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
            )
        """)

        # Advanced Assessments table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS advanced_assessments (
                id INT AUTO_INCREMENT PRIMARY KEY,
                patient_id INT NOT NULL,
                wbc FLOAT,
                platelets FLOAT,
                hemoglobin FLOAT,
                crp FLOAT,
                esr FLOAT,
                creatinine FLOAT,
                urea FLOAT,
                bilirubin FLOAT,
                ast FLOAT,
                alt FLOAT,
                inr FLOAT,
                sodium FLOAT,
                potassium FLOAT,
                map FLOAT,
                troponin_positive BOOLEAN,
                pao2_fio2 FLOAT,
                gcs INT,
                urine_output FLOAT,
                risk_factors TEXT,
                severity_score FLOAT,
                severity_level VARCHAR(20),
                analyzed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
            )
        """)

        conn.commit()
    except Exception as e:
        print(f"Error initializing schema: {e}")
    finally:
        cursor.close()
        conn.close()

def calculate_severity_score(data):
    """
    Unified severity calculation logic based on clinical parameters.
    """
    score = 0
    immediate_severe = False
    
    # Values extraction
    temp = float(data.get("temperature") or 0)
    hr = int(data.get("heart_rate") or 0)
    rr = int(data.get("respiratory_rate") or 0)
    spo2 = int(data.get("spo2") or 0)
    bg = float(data.get("blood_glucose") or 0)
    map_val = float(data.get("map") or 0)
    gcs = int(data.get("gcs") or 15)
    troponin = bool(data.get("troponin_positive", False))
    
    wbc = float(data.get("wbc") or 0)
    platelets = float(data.get("platelets") or 0)
    hemoglobin = float(data.get("hemoglobin") or 0)
    crp = float(data.get("crp") or 0)
    esr = float(data.get("esr") or 0)
    creatinine = float(data.get("creatinine") or 0)
    urea = float(data.get("urea") or 0)
    bilirubin = float(data.get("bilirubin") or 0)
    ast = float(data.get("ast") or 0)
    alt = float(data.get("alt") or 0)
    inr = float(data.get("inr") or 0)
    sodium = float(data.get("sodium") or 0)
    potassium = float(data.get("potassium") or 0)
    pao2_fio2 = float(data.get("pao2_fio2") or 0)
    urine_output = float(data.get("urine_output") or 0)
    
    # CBC
    if wbc > 0:
        if wbc > 15000 or wbc < 3000: score += 3
        elif 11000 <= wbc <= 15000: score += 2
    if platelets > 0:
        if platelets < 100000: score += 3
        elif 100000 <= platelets <= 150000: score += 2
    if hemoglobin > 0:
        if hemoglobin < 8: score += 3
        elif 8 <= hemoglobin <= 11: score += 2
    
    # Inflammation
    if crp > 0:
        if crp > 50: score += 3
        elif 10 <= crp <= 50: score += 2
    if esr > 40: score += 2
    
    # Kidney
    if creatinine > 0:
        if creatinine > 1.8: score += 3
        elif 1.2 <= creatinine <= 1.8: score += 2
    if urea > 80: score += 2
    
    # Liver
    if bilirubin > 0:
        if bilirubin > 3: score += 3
        elif 1.2 <= bilirubin <= 3: score += 2
    if ast > 150 or alt > 150: score += 3
    elif (50 <= ast <= 150) or (50 <= alt <= 150): score += 2
    if inr > 1.5: score += 3
    
    # Electrolytes
    if sodium > 0:
        if sodium < 125 or sodium > 150: score += 3
        elif 125 <= sodium <= 135: score += 2
    if potassium > 0:
        if potassium > 6 or potassium < 3: score += 3
        elif 5 <= potassium <= 6: score += 2
        
    # Organ Function
    if 0 < map_val < 65: score += 4
    if troponin: score += 4
    if 0 < pao2_fio2 < 300: score += 3
    if 0 < gcs < 12: score += 4
    if 0 < urine_output < 0.5: score += 3
    
    # Risk Factors
    risk_factors = data.get("risk_factors", [])
    if isinstance(risk_factors, str):
        risk_factors = [rf.strip() for rf in risk_factors.split(",") if rf.strip()]
    score += len(risk_factors)
    
    # Vitals
    if temp > 0:
        if temp > 38.5 or temp < 35.5: score += 3
        elif temp > 37.5: score += 1
    if hr > 0:
        if hr > 110 or hr < 50: score += 3
        elif hr > 100: score += 2
    if rr > 0:
        if rr > 24 or rr < 10: score += 4
        elif rr > 20: score += 2
    if spo2 > 0:
        if spo2 < 90: score += 5
        elif spo2 < 95: score += 3
    if bg > 0 and (bg > 200 or bg < 60): score += 3
    
    # Immediate Critical Override
    if (0 < map_val < 65) or (0 < gcs < 12) or (0 < spo2 < 90) or troponin:
        immediate_severe = True
        
    level = "CRITICAL" if (immediate_severe or score > 25) else "MODERATE" if score >= 12 else "MILD"
    return score, level

init_db_schema()

@app.route("/analyze_severity", methods=["POST"])
def analyze_severity():
    data = request.json
    if not data:
        return jsonify({"success": False, "error": "No data received"}), 400
    
    patient_id = data.get("patient_id")
    doctor_id = data.get("doctor_id")
    
    # Extract clinical values for calculation (replicating frontend logic)
    score = 0
    immediate_severe = False
    
    try:
        # Vitals extraction with extra safety for None values
        temp = float(data.get("temperature") or 0)
        hr = int(data.get("heart_rate") or 0)
        rr = int(data.get("respiratory_rate") or 0)
        spo2 = int(data.get("spo2") or 0)
        bg = float(data.get("blood_glucose") or 0)
        map_val = float(data.get("map") or 0)
        gcs = int(data.get("gcs") or 15)
        troponin = bool(data.get("troponin_positive", False))
        
        # Labs
        wbc = float(data.get("wbc") or 0)
        platelets = float(data.get("platelets") or 0)
        hemoglobin = float(data.get("hemoglobin") or 0)
        crp = float(data.get("crp") or 0)
        esr = float(data.get("esr") or 0)
        creatinine = float(data.get("creatinine") or 0)
        urea = float(data.get("urea") or 0)
        bilirubin = float(data.get("bilirubin") or 0)
        ast = float(data.get("ast") or 0)
        alt = float(data.get("alt") or 0)
        inr = float(data.get("inr") or 0)
        sodium = float(data.get("sodium") or 0)
        potassium = float(data.get("potassium") or 0)
        pao2_fio2 = float(data.get("pao2_fio2") or 0)
        urine_output = float(data.get("urine_output") or 0)
        
        risk_factors = data.get("risk_factors", [])
        if isinstance(risk_factors, str):
            risk_factors = [rf.strip() for rf in risk_factors.split(",") if rf.strip()]

        # Detailed score tracking
        breakdown = {}
        
        # CBC
        cbc_score = 0
        if wbc > 0:
            if wbc > 15000 or wbc < 3000: cbc_score += 3
            elif 11000 <= wbc <= 15000: cbc_score += 2
        if platelets > 0:
            if platelets < 100000: cbc_score += 3
            elif 100000 <= platelets <= 150000: cbc_score += 2
        if hemoglobin > 0:
            if hemoglobin < 8: cbc_score += 3
            elif 8 <= hemoglobin <= 11: cbc_score += 2
        score += cbc_score
        breakdown['cbc'] = cbc_score
        
        # Inflammation
        inf_score = 0
        if crp > 0:
            if crp > 50: inf_score += 3
            elif 10 <= crp <= 50: inf_score += 2
        if esr > 40: inf_score += 2
        score += inf_score
        breakdown['inflammation'] = inf_score
        
        # Kidney
        kid_score = 0
        if creatinine > 0:
            if creatinine > 1.8: kid_score += 3
            elif 1.2 <= creatinine <= 1.8: kid_score += 2
        if urea > 80: kid_score += 2
        score += kid_score
        breakdown['kidney'] = kid_score
        
        # Liver
        liv_score = 0
        if bilirubin > 0:
            if bilirubin > 3: liv_score += 3
            elif 1.2 <= bilirubin <= 3: liv_score += 2
        if ast > 150 or alt > 150: liv_score += 3
        elif (50 <= ast <= 150) or (50 <= alt <= 150): liv_score += 2
        if inr > 1.5: liv_score += 3
        score += liv_score
        breakdown['liver'] = liv_score
        
        # Electrolytes
        elec_score = 0
        if sodium > 0:
            if sodium < 125 or sodium > 150: elec_score += 3
            elif 125 <= sodium <= 135: elec_score += 2
        if potassium > 0:
            if potassium > 6 or potassium < 3: elec_score += 3
            elif 5 <= potassium <= 6: elec_score += 2
        score += elec_score
        breakdown['electrolytes'] = elec_score
            
        # Organ Function
        org_score = 0
        if 0 < map_val < 65: org_score += 4
        if troponin: org_score += 4
        if 0 < pao2_fio2 < 300: org_score += 3
        if 0 < gcs < 12: org_score += 4
        if 0 < urine_output < 0.5: org_score += 3
        score += org_score
        breakdown['organ_function'] = org_score
        
        # Risk Factors
        rf_score = len(risk_factors)
        score += rf_score
        breakdown['risk_factors'] = rf_score
        
        # Vitals Integration
        vit_score = 0
        if temp > 0:
            if temp > 38.5 or temp < 35.5: vit_score += 3
            elif temp > 37.5: vit_score += 1
        if hr > 0:
            if hr > 110 or hr < 50: vit_score += 3
            elif hr > 100: vit_score += 2
        if rr > 0:
            if rr > 24 or rr < 10: vit_score += 4
            elif rr > 20: vit_score += 2
        if spo2 > 0:
            if spo2 < 90: vit_score += 5
            elif spo2 < 95: vit_score += 3
        if bg > 0 and (bg > 200 or bg < 60): vit_score += 3
        score += vit_score
        breakdown['vitals'] = vit_score
        
        # Immediate Critical Override
        if (0 < map_val < 65) or (0 < gcs < 12) or (0 < spo2 < 90) or troponin:
            immediate_severe = True
            
        severity_level = "CRITICAL" if (immediate_severe or score > 25) else "MODERATE" if score >= 12 else "MILD"
        
        print(f"--- SEVERITY BREAKDOWN (Patient {patient_id}) ---")
        print(f"Breakdown: {breakdown}")
        print(f"Total Score: {score}")
        print(f"Immediate Severe Trigger: {immediate_severe}")
        print(f"Final Level: {severity_level}")
        print("------------------------------------------------")
        
        print(f"DEBUG Analysis: Patient={patient_id}, Score={score}, ImmediateSevere={immediate_severe}, Result={severity_level}")
        
        # Store in database
        conn = get_db()
        cursor = conn.cursor()
        
        # 1. Update analysis_results (history)
        cursor.execute("SHOW COLUMNS FROM analysis_results LIKE 'severity_level'")
        has_legacy_field = cursor.fetchone() is not None
        
        if has_legacy_field:
            cursor.execute("""
                INSERT INTO analysis_results (patient_id, doctor_id, severity_result, severity_score, severity_level)
                VALUES (%s, %s, %s, %s, %s)
            """, (patient_id, doctor_id, severity_level, score, severity_level))
        else:
            cursor.execute("""
                INSERT INTO analysis_results (patient_id, doctor_id, severity_result)
                VALUES (%s, %s, %s)
            """, (patient_id, doctor_id, severity_level))
        
        # 2. Update patients table (current status for list views)
        cursor.execute("""
            UPDATE patients
            SET severity_score = %s, severity_level = %s, last_vitals_date = %s
            WHERE id = %s
        """, (score, severity_level, analyzed_at, patient_id))

        conn.commit()
        
        return jsonify({
            "success": True,
            "severity_level": severity_level,
            "score": int(score),
            "message": "Analysis completed and saved."
        })
        
    except Exception as e:
        print(f"Error in analyze_severity: {e}")
        return jsonify({"success": False, "error": str(e)}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

# -----------------------------
# AUTHENTICATION
# -----------------------------

@app.route("/register", methods=["POST"])
def register():
    data = request.json
    query = """
    INSERT INTO doctors (fullname, email, phone, specialization, password)
    VALUES (%s, %s, %s, %s, %s)
    """
    values = (
        data.get("fullname"),
        data.get("email"),
        data.get("phone"),
        data.get("specialization"),
        data.get("password")
    )
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(query, values)
        
        # Notify Admin about new registration
        try:
            cursor.execute(
                "INSERT INTO notifications (title, message, target_role) VALUES (%s, %s, %s)",
                ("New User", f"New doctor registration: {data.get('fullname')} ({data.get('specialization')})", 'admin')
            )
        except Exception as notify_error:
            print(f"ERROR inserting registration notification: {notify_error}")

        conn.commit()
        return jsonify({"success": True, "message": "Registration Successful"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/login", methods=["POST"])
def login():
    data = request.json
    email = data.get("email")
    password = data.get("password")

    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id, fullname, email, is_active FROM doctors WHERE email=%s AND password=%s", (email, password))
        user = cursor.fetchone()
        
        if user:
            if not user.get('is_active', True):
                return jsonify({"success": False, "message": "Your account is deactivated. Please contact admin."}), 403

            # Record login event in history with role and email
            try:
                cursor.execute(
                    "INSERT INTO login_history (doctor_name, email, role) VALUES (%s, %s, %s)",
                    (user['fullname'], user['email'], 'User')
                )
                
                cursor.execute(
                    "INSERT INTO notifications (title, message, target_role) VALUES (%s, %s, %s)", 
                    ("Security Alert", f"Dr. {user['fullname']} logged in", 'admin')
                )
                conn.commit()
            except Exception as e:
                print(f"Error recording login activity: {e}")

            return jsonify({
                "success": True,
                "message": "Login Successful",
                "doctor_id": user['id'],
                "fullname": user['fullname']
            })
        else:
            return jsonify({"success": False, "message": "Please enter a valid email and password."}), 401
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/log_activity", methods=["POST"])
def log_activity():
    data = request.json
    name = data.get("doctor_name")
    email = data.get("email")
    role = data.get("role", "User")

    conn = get_db()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO login_history (doctor_name, email, role) VALUES (%s, %s, %s)",
            (name, email, role)
        )
        conn.commit()
        return jsonify({"success": True})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/admin/reset-doctor-password", methods=["POST"])
def reset_doctor_password():
    data = request.json
    email = data.get("email")
    new_password = data.get("new_password")
    confirm_password = data.get("confirm_password")

    if not email or not new_password or not confirm_password:
        return jsonify({"success": False, "message": "All fields are required"}), 400

    if new_password != confirm_password:
        return jsonify({"success": False, "message": "Passwords do not match"}), 400

    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Check if doctor exists
        cursor.execute("SELECT id, fullname FROM doctors WHERE email = %s", (email,))
        doctor = cursor.fetchone()
        
        if not doctor:
            return jsonify({"success": False, "message": "Doctor email not found"}), 404

        # Update password
        cursor.execute("UPDATE doctors SET password = %s WHERE email = %s", (new_password, email))
        
        # 1. Notify Admin about password reset action
        try:
            cursor.execute(
                "INSERT INTO notifications (title, message, target_role) VALUES (%s, %s, %s)",
                ("Password Reset", f"Admin reset password for Dr. {doctor['fullname']} ({email})", 'admin')
            )
        except Exception as notify_error:
            print(f"Error inserting admin notification: {notify_error}")

        # 2. Notify Doctor about password reset
        try:
            cursor.execute(
                "INSERT INTO notifications (title, message, target_role, doctor_id) VALUES (%s, %s, %s, %s)",
                ("Account Update", "Your password has been successfully updated by the administrator. Please use your new password when logging in.", 'doctor', doctor['id'])
            )
        except Exception as notify_error:
            print(f"Error inserting doctor notification: {notify_error}")

        conn.commit()
        return jsonify({"success": True, "message": "Password updated successfully"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

# -----------------------------
# ADMIN DASHBOARD ENDPOINTS
# -----------------------------

@app.route("/stats", methods=["GET"])
def get_admin_stats():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT COUNT(*) as total FROM doctors")
        total_doctors = cursor.fetchone()['total']

        cursor.execute("SELECT COUNT(*) as total FROM patients")
        total_patients = cursor.fetchone()['total']

        # Fetch actual counts for alerts and reports
        cursor.execute("SELECT COUNT(*) as total FROM analysis_results WHERE severity_result = 'CRITICAL'")
        critical_alerts = cursor.fetchone()['total']

        cursor.execute("SELECT COUNT(*) as total FROM analysis_results")
        reports_generated = cursor.fetchone()['total']

        # 7-Day Analysis Trend (Daily Patient Analysis)
        cursor.execute("""
            SELECT DATE(analyzed_at) as analysis_date, COUNT(*) as count 
            FROM analysis_results 
            WHERE analyzed_at >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            GROUP BY DATE(analyzed_at)
            ORDER BY DATE(analyzed_at) ASC
        """)
        trend_data = cursor.fetchall()
        
        # Format trend to ensure all 7 days are present
        from datetime import timedelta
        today = date.today()
        daily_analysis_trend = []
        for i in range(6, -1, -1):
            day = today - timedelta(days=i)
            day_str = day.strftime("%Y-%m-%d")
            match = next((item for item in trend_data if str(item['analysis_date']) == day_str), None)
            count = match['count'] if match else 0
            daily_analysis_trend.append({
                "day": day.strftime("%a"),
                "date": day_str,
                "count": count
            })

        # Fetch patient severity distribution
        cursor.execute("""
            SELECT 
                SUM(CASE WHEN severity_level = 'Mild' THEN 1 ELSE 0 END) as mild,
                SUM(CASE WHEN severity_level = 'Moderate' THEN 1 ELSE 0 END) as moderate,
                SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END) as critical
            FROM patients
        """)
        severity_data = cursor.fetchone()
        severity_distribution = {
            "mild": int(severity_data['mild'] or 0),
            "moderate": int(severity_data['moderate'] or 0),
            "critical": int(severity_data['critical'] or 0)
        }

        return jsonify({
            "success": True,
            "stats": {
                "total_doctors": total_doctors,
                "total_patients": total_patients,
                "critical_alerts": critical_alerts,
                "reports_generated": reports_generated,
                "daily_analysis_trend": daily_analysis_trend,
                "severity_distribution": severity_distribution
            }
        })
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/admin/daily-analysis", methods=["GET"])
def get_daily_analysis():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Last 7 days analysis trend
        cursor.execute("""
            SELECT DATE(analyzed_at) as analysis_date, COUNT(*) as count 
            FROM analysis_results 
            WHERE analyzed_at >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            GROUP BY DATE(analyzed_at)
            ORDER BY DATE(analyzed_at) ASC
        """)
        trend_data = cursor.fetchall()
        
        # Format trend to ensure all 7 days are present (zero-filling)
        from datetime import timedelta, date
        today = date.today()
        formatted_data = []
        for i in range(6, -1, -1):
            day = today - timedelta(days=i)
            day_str = day.strftime("%Y-%m-%d")
            match = next((item for item in trend_data if str(item['analysis_date']) == day_str), None)
            count = match['count'] if match else 0
            formatted_data.append({
                "analysis_date": day_str,
                "count": count
            })
                
        return jsonify({"success": True, "data": formatted_data})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/admin/reports", methods=["GET"])
def get_admin_reports():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Fetch reports joined with patient and doctor names
        query = """
        SELECT ar.id, p.name as patient_name, d.fullname as doctor_name, 
               ar.severity_result, ar.analyzed_at, ar.patient_id, ar.recommendations, ar.severity_score
        FROM analysis_results ar
        JOIN patients p ON ar.patient_id = p.id
        LEFT JOIN doctors d ON ar.doctor_id = d.id
        ORDER BY ar.analyzed_at DESC
        """
        cursor.execute(query)
        reports = cursor.fetchall()
        for r in reports:
            if isinstance(r['analyzed_at'], (datetime, date)):
                r['analyzed_at'] = r['analyzed_at'].strftime("%Y-%m-%d %H:%M:%S")
        return jsonify({"success": True, "reports": reports})
    except Exception as e:
        print(f"ERROR get_admin_reports: {str(e)}")
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/admin/reports/<int:report_id>", methods=["GET"])
def get_report_details(report_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Fetch report details
        cursor.execute("""
            SELECT ar.*, p.name as patient_name, p.age, p.gender, p.phone, d.fullname as doctor_name
            FROM analysis_results ar
            JOIN patients p ON ar.patient_id = p.id
            LEFT JOIN doctors d ON ar.doctor_id = d.id
            WHERE ar.id = %s
        """, (report_id,))
        report = cursor.fetchone()
        
        if not report:
            return jsonify({"success": False, "message": "Report not found"}), 404
            
        # 1. Fetch Vitals (Look for records near the analysis timestamp, or most recent)
        cursor.execute("""
            SELECT * FROM vitals 
            WHERE patient_id = %s AND ABS(TIMESTAMPDIFF(SECOND, recorded_at, %s)) < 300
            ORDER BY recorded_at DESC LIMIT 1
        """, (report['patient_id'], report['analyzed_at']))
        vitals = cursor.fetchone()
        
        if not vitals:
            # Fallback to absolute latest vitals for this patient
            cursor.execute("SELECT * FROM vitals WHERE patient_id = %s ORDER BY recorded_at DESC LIMIT 1", (report['patient_id'],))
            vitals = cursor.fetchone()

        # 2. Fetch Symptoms (Near analysis time or most recent batch)
        cursor.execute("""
            SELECT symptom_name FROM symptoms 
            WHERE patient_id = %s AND ABS(TIMESTAMPDIFF(SECOND, recorded_at, %s)) < 300
        """, (report['patient_id'], report['analyzed_at']))
        symptoms_data = cursor.fetchall()
        
        if not symptoms_data:
            # Fallback to latest symptoms recorded
            cursor.execute("""
                SELECT symptom_name FROM symptoms 
                WHERE patient_id = %s AND recorded_at = (SELECT MAX(recorded_at) FROM symptoms WHERE patient_id = %s)
            """, (report['patient_id'], report['patient_id']))
            symptoms_data = cursor.fetchall()
            
        symptoms = [s['symptom_name'] for s in symptoms_data]

        # Format times for JSON
        if isinstance(report['analyzed_at'], (datetime, date)):
            report['analyzed_at'] = report['analyzed_at'].strftime("%Y-%m-%d %H:%M:%S")
        if vitals and isinstance(vitals['recorded_at'], (datetime, date)):
            vitals['recorded_at'] = vitals['recorded_at'].strftime("%Y-%m-%d %H:%M:%S")

        return jsonify({
            "success": True,
            "report": report,
            "vitals": vitals,
            "symptoms": symptoms
        })
    except Exception as e:
        print(f"ERROR get_report_details: {str(e)}")
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/doctors", methods=["GET"])
def get_all_doctors():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Check for activity in the last 24 hours
        query = """
        SELECT d.id, d.fullname, d.email, d.phone, d.specialization, d.profile_image,
               CAST(COALESCE(d.is_active, 1) AS SIGNED) as is_active_int,
               CASE 
                   WHEN MAX(h.timestamp) >= (NOW() - INTERVAL 1 DAY) THEN 'Active'
                   ELSE 'Inactive'
               END as activity_status
        FROM doctors d
        LEFT JOIN login_history h ON d.fullname = h.doctor_name
        GROUP BY d.id
        """
        cursor.execute(query)
        doctors = cursor.fetchall()
        for d in doctors:
            d['is_active'] = bool(d['is_active_int'])
            del d['is_active_int']
        return jsonify({"success": True, "doctors": doctors})
    except Exception as e:
        print(f"ERROR get_all_doctors: {str(e)}")
        return jsonify({"success": False, "message": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/patients", methods=["GET"])
def get_all_patients():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Join with doctors to see who is treating them and check vitals for activity
        query = """
        SELECT p.*, d.fullname as doctor_name,
               CASE 
                   WHEN MAX(v.recorded_at) >= (NOW() - INTERVAL 2 DAY) THEN 'Active'
                   ELSE 'Registered'
               END as activity_status
        FROM patients p
        LEFT JOIN doctors d ON p.assigned_doctor_id = d.id
        LEFT JOIN vitals v ON p.id = v.patient_id
        GROUP BY p.id
        ORDER BY p.created_at DESC
        """
        cursor.execute(query)
        patients = cursor.fetchall()
        for patient in patients:
            for key, val in patient.items():
                if isinstance(val, (datetime, date)):
                    patient[key] = val.strftime("%Y-%m-%d %H:%M:%S")
        return jsonify({"success": True, "patients": patients})
    except Exception as e:
        print(f"ERROR get_all_patients: {str(e)}")
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/notifications", methods=["GET"])
def get_notifications():
    doctor_id = request.args.get('doctor_id')
    role = request.args.get('role', 'admin')
    
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        notifications = [] # Initialize notifications list
        if role == 'admin':
            # For admin, also show legacy notifications where target_role might be NULL
            cursor.execute("SELECT id, title, message, created_at as timestamp FROM notifications WHERE (target_role = 'admin' OR target_role IS NULL) ORDER BY created_at DESC LIMIT 50")
            notifications = cursor.fetchall()
        else:
            # Clean up doctor_id input
            d_id = None
            if doctor_id is not None:
                d_id_str = str(doctor_id).strip()
                if d_id_str and d_id_str.lower() != 'null':
                    try:
                        d_id = int(d_id_str)
                    except:
                        pass
            
            if d_id is not None:
                print(f"DEBUG: Fetching notifications for Doctor ID: {d_id}")
                # Include specific notifications for this doctor AND broadcast notifications (doctor_id is NULL)
                cursor.execute(
                    "SELECT id, title, message, created_at as timestamp FROM notifications WHERE target_role = 'doctor' AND (doctor_id = %s OR doctor_id IS NULL) ORDER BY created_at DESC LIMIT 50",
                    (d_id,)
                )
                notifications = cursor.fetchall()
            else:
                # If no specific doctor ID, maybe just show broadcasts? Requirements say show broadcast to all doctors.
                cursor.execute(
                    "SELECT id, title, message, created_at as timestamp FROM notifications WHERE target_role = 'doctor' AND doctor_id IS NULL ORDER BY created_at DESC LIMIT 50"
                )
                notifications = cursor.fetchall()
        print(f"DEBUG: Found {len(notifications)} notifications for role={role}")
        for note in notifications:
            if isinstance(note['timestamp'], datetime):
                note['timestamp'] = note['timestamp'].strftime("%Y-%m-%d %H:%M:%S")
        return jsonify({"success": True, "notifications": notifications})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/notifications/clear", methods=["DELETE"])
def clear_notifications():
    role = request.args.get('role', 'admin')
    doctor_id = request.args.get('doctor_id')
    
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        if role == 'admin':
            cursor.execute("DELETE FROM notifications WHERE target_role = 'admin'")
        else:
            cursor.execute("DELETE FROM notifications WHERE target_role = 'doctor' AND doctor_id = %s", (doctor_id,))
        conn.commit()
        return jsonify({"success": True, "message": "Notifications cleared"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/notifications/delete", methods=["DELETE"])
def delete_notifications():
    ids = request.args.get('ids')
    if not ids:
        return jsonify({"success": False, "message": "No IDs provided"}), 400
    
    id_list = ids.split(",")
    conn = get_db()
    # Handle the case where ids might be empty or invalid
    if not id_list:
        return jsonify({"success": False, "message": "Invalid ID list"}), 400

    cursor = conn.cursor()
    try:
        # Construct the IN clause safely
        format_strings = ','.join(['%s'] * len(id_list))
        cursor.execute(f"DELETE FROM notifications WHERE id IN ({format_strings})", tuple(id_list))
        conn.commit()
        return jsonify({"success": True, "message": f"Deleted {cursor.rowcount} notifications"})
    except Exception as e:
        print(f"ERROR delete_notifications: {str(e)}")
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/login-history", methods=["GET"])
def get_login_history():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT doctor_name, timestamp FROM login_history ORDER BY timestamp DESC LIMIT 50")
        logins = cursor.fetchall()
        for login in logins:
            if isinstance(login['timestamp'], datetime):
                login['timestamp'] = login['timestamp'].strftime("%Y-%m-%d %H:%M:%S")
        return jsonify({"success": True, "logins": logins})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/toggle-doctor/<int:doctor_id>", methods=["POST"])
def toggle_doctor_status(doctor_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("UPDATE doctors SET is_active = NOT COALESCE(is_active, 1) WHERE id = %s", (doctor_id,))
        conn.commit()
        return jsonify({"success": True, "message": "Doctor status toggled successfully"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

# -----------------------------
# PATIENT MANAGEMENT
# -----------------------------

@app.route("/add_patient", methods=["POST"])
def add_patient():
    data = request.json
    query = """
    INSERT INTO patients (name, age, gender, phone, email, address, assigned_doctor_id, created_at)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        data.get("name"),
        data.get("age"),
        data.get("gender"),
        data.get("phone"),
        data.get("email"),
        data.get("address"),
        data.get("doctor_id"),
        datetime.now()
    )
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(query, values)
        patient_id = cursor.lastrowid
        
        # Notify Admin about new patient
        try:
            cursor.execute(
                "INSERT INTO notifications (title, message, target_role) VALUES (%s, %s, %s)",
                ("Inventory", f"New patient added: {data.get('name')}", 'admin')
            )
        except Exception as notify_error:
            print(f"ERROR inserting patient notification: {notify_error}")

        conn.commit()
        return jsonify({"success": True, "message": "Patient Added Successfully", "patient_id": patient_id})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/patients/doctor/<int:doctor_id>", methods=["GET"])
def get_patients_by_doctor(doctor_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Get patients with their latest vitals joined in and check activity
        query = """
        SELECT 
            p.*,
            v.blood_pressure,
            v.heart_rate,
            v.spo2,
            v.temperature,
            v.respiratory_rate,
            v.blood_glucose,
            v.recorded_at AS last_vitals_date,
            aa.wbc, aa.platelets, aa.hemoglobin, aa.crp, aa.esr,
            aa.creatinine, aa.urea, aa.bilirubin, aa.ast, aa.alt, aa.inr,
            aa.sodium, aa.potassium, aa.map, aa.troponin_positive,
            aa.pao2_fio2, aa.gcs, aa.urine_output, aa.risk_factors,
            (
                SELECT GROUP_CONCAT(s.symptom_name ORDER BY s.recorded_at DESC SEPARATOR ', ')
                FROM symptoms s
                WHERE s.patient_id = p.id
            ) AS symptoms,
            CASE 
                WHEN MAX(v_all.recorded_at) >= (NOW() - INTERVAL 2 DAY) THEN 'Active'
                ELSE 'Registered'
            END as activity_status
        FROM patients p
        LEFT JOIN vitals v ON v.id = (
            SELECT id FROM vitals
            WHERE patient_id = p.id
            ORDER BY recorded_at DESC
            LIMIT 1
        )
        LEFT JOIN vitals v_all ON v_all.patient_id = p.id
        LEFT JOIN advanced_assessments aa ON aa.id = (
            SELECT id FROM advanced_assessments
            WHERE patient_id = p.id
            ORDER BY recorded_at DESC
            LIMIT 1
        )
        WHERE p.assigned_doctor_id = %s
        GROUP BY p.id
        ORDER BY p.created_at DESC
        """
        cursor.execute(query, (doctor_id,))
        patients = cursor.fetchall()

        # Convert datetime objects to strings for JSON serialization
        for patient in patients:
            for key, val in patient.items():
                if isinstance(val, (datetime, date)):
                    patient[key] = val.strftime("%Y-%m-%d %H:%M:%S")

        return jsonify({"success": True, "patients": patients})
    except Exception as e:
        print(f"ERROR get_patients_by_doctor: {str(e)}")
        return jsonify({"success": False, "message": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/patient/<int:patient_id>", methods=["GET"])
def get_patient_details(patient_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # 1. Get patient base info
        cursor.execute("SELECT * FROM patients WHERE id=%s", (patient_id,))
        patient = cursor.fetchone()
        if not patient:
            return jsonify({"success": False, "message": "Patient not found"}), 404

        # 2. Get latest vitals and advanced indicators
        cursor.execute("""
            SELECT blood_pressure, heart_rate, spo2, temperature, respiratory_rate, blood_glucose, recorded_at
            FROM vitals
            WHERE patient_id = %s
            ORDER BY recorded_at DESC
            LIMIT 1
        """, (patient_id,))
        latest_vitals = cursor.fetchone()

        if latest_vitals:
            patient['blood_pressure'] = latest_vitals['blood_pressure']
            patient['heart_rate'] = latest_vitals['heart_rate']
            patient['spo2'] = latest_vitals['spo2']
            patient['temperature'] = latest_vitals['temperature']
            patient['respiratory_rate'] = latest_vitals['respiratory_rate']
            patient['blood_glucose'] = latest_vitals['blood_glucose']
            patient['last_vitals_date'] = latest_vitals['recorded_at'].strftime("%Y-%m-%d %H:%M:%S") if latest_vitals.get('recorded_at') else None

        # 2.5 Get latest advanced assessment
        cursor.execute("""
            SELECT wbc, platelets, hemoglobin, crp, esr, creatinine, urea,
                   bilirubin, ast, alt, inr, sodium, potassium, map, troponin_positive,
                   pao2_fio2, gcs, urine_output, risk_factors
            FROM advanced_assessments
            WHERE patient_id = %s
            ORDER BY recorded_at DESC
            LIMIT 1
        """, (patient_id,))
        adv = cursor.fetchone()
        if adv:
            patient.update(adv)

        # 3. Get all symptoms from the symptoms table
        cursor.execute("""
            SELECT symptom_name
            FROM symptoms
            WHERE patient_id = %s
            ORDER BY recorded_at DESC
        """, (patient_id,))
        symptom_rows = cursor.fetchall()

        if symptom_rows:
            patient['symptoms'] = ', '.join([row['symptom_name'] for row in symptom_rows])
        else:
            patient['symptoms'] = None

        # Convert any remaining datetime objects to strings
        for key, val in patient.items():
            if isinstance(val, datetime):
                patient[key] = val.strftime("%Y-%m-%d %H:%M:%S")

        return jsonify({"success": True, "patient": patient})
    except Exception as e:
        print(f"ERROR get_patient_details: {str(e)}")
        return jsonify({"success": False, "message": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/update_patient/<int:patient_id>", methods=["PUT"])
def update_patient(patient_id):
    data = request.json
    query = """
    UPDATE patients
    SET name=%s, age=%s, gender=%s, phone=%s, email=%s, address=%s
    WHERE id=%s
    """
    values = (
        data.get("name"),
        data.get("age"),
        data.get("gender"),
        data.get("phone"),
        data.get("email"),
        data.get("address"),
        patient_id
    )
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(query, values)
        conn.commit()
        return jsonify({"success": True, "message": "Patient Updated Successfully"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

# -----------------------------
# VITALS & SYMPTOMS
# -----------------------------

@app.route("/add_vitals", methods=["POST"])
def add_vitals():
    data = request.json
    query = """
    INSERT INTO vitals (patient_id, blood_pressure, heart_rate, spo2, temperature, respiratory_rate, blood_glucose, recorded_at)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        data.get("patient_id"),
        data.get("blood_pressure"),
        data.get("heart_rate"),
        data.get("spo2"),
        data.get("temperature"),
        data.get("respiratory_rate"),
        data.get("blood_glucose"),
        datetime.now()
    )
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(query, values)
        conn.commit()
        return jsonify({"success": True, "message": "Vitals Saved"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/add_symptom", methods=["POST"])
def add_symptom():
    data = request.json
    query = "INSERT INTO symptoms (patient_id, symptom_name, recorded_at) VALUES (%s, %s, %s)"
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        if isinstance(data.get("symptoms"), list):
            for s in data.get("symptoms"):
                cursor.execute(query, (data.get("patient_id"), s, datetime.now()))
        else:
            cursor.execute(query, (data.get("patient_id"), data.get("symptom_name"), datetime.now()))

        conn.commit()
        return jsonify({"success": True, "message": "Symptoms Saved"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/patient/<int:patient_id>/symptoms", methods=["GET"])
def get_patient_symptoms(patient_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id, symptom_name, recorded_at FROM symptoms WHERE patient_id = %s ORDER BY recorded_at DESC", (patient_id,))
        symptoms = cursor.fetchall()
        return jsonify({"success": True, "symptoms": symptoms})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/update_symptom/<int:symptom_id>", methods=["PUT"])
def update_symptom(symptom_id):
    data = request.json
    symptom_name = data.get("symptom_name")
    if not symptom_name:
        return jsonify({"success": False, "error": "Symptom name is required"}), 400
    
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("UPDATE symptoms SET symptom_name = %s WHERE id = %s", (symptom_name, symptom_id))
        conn.commit()
        return jsonify({"success": True, "message": "Symptom updated"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route("/delete_symptom/<int:symptom_id>", methods=["DELETE"])
def delete_symptom(symptom_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM symptoms WHERE id = %s", (symptom_id,))
        conn.commit()
        return jsonify({"success": True, "message": "Symptom deleted"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

# -----------------------------
# DASHBOARD STATS
# -----------------------------

@app.route("/dashboard_stats/<int:doctor_id>", methods=["GET"])
def dashboard_stats(doctor_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT COUNT(*) as total FROM patients WHERE assigned_doctor_id=%s", (doctor_id,))
        total_patients = cursor.fetchone()['total']

        cursor.execute("""
            SELECT p.name, v.recorded_at, p.severity_level
            FROM vitals v
            JOIN patients p ON v.patient_id = p.id
            WHERE p.assigned_doctor_id = %s
            ORDER BY v.recorded_at DESC LIMIT 5
        """, (doctor_id,))
        recent_activity = cursor.fetchall()

        for row in recent_activity:
            for key, val in row.items():
                if isinstance(val, datetime):
                    row[key] = val.strftime("%Y-%m-%d %H:%M:%S")

        return jsonify({
            "success": True,
            "stats": {
                "total_patients": total_patients,
                "recent_activity": recent_activity
            }
        })
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

# -----------------------------
# SEVERITY ANALYSIS
# -----------------------------

@app.route("/save_analysis_result", methods=["POST"])
def save_analysis_result():
    data = request.json
    if not data:
        return jsonify({"success": False, "error": "No data received"}), 400

    patient_id = data.get("patient_id")
    if not patient_id:
         return jsonify({"success": False, "error": "Patient ID is required"}), 400

    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        now = datetime.now()

        # Calculate Severity Backend-side to ensure consistency
        score, level = calculate_severity_score(data)

        # Get doctor info for mapping
        cursor.execute("SELECT name, assigned_doctor_id FROM patients WHERE id = %s", (patient_id,))
        p_info = cursor.fetchone()
        doctor_id = p_info['assigned_doctor_id'] if p_info else None

        # 1. Update patients table summary
        cursor.execute("""
            UPDATE patients
            SET severity_score=%s, severity_level=%s, last_vitals_date=%s
            WHERE id=%s
        """, (score, level, now, patient_id))

        # 2. Insert into vitals table
        cursor.execute("""
            INSERT INTO vitals (patient_id, blood_pressure, heart_rate, spo2, temperature, respiratory_rate, blood_glucose, recorded_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            patient_id,
            data.get("blood_pressure"),
            data.get("heart_rate"),
            data.get("spo2"),
            data.get("temperature"),
            data.get("respiratory_rate"),
            data.get("blood_glucose"),
            now
        ))
        vitals_id = cursor.lastrowid

        # 3. Insert specific clinical values into advanced_assessments
        cursor.execute("""
            INSERT INTO advanced_assessments (
                patient_id, wbc, platelets, hemoglobin, crp, esr, creatinine, urea,
                bilirubin, ast, alt, inr, sodium, potassium, map, troponin_positive,
                pao2_fio2, gcs, urine_output, risk_factors, severity_score, severity_level, analyzed_at
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            patient_id,
            data.get("wbc"), data.get("platelets"), data.get("hemoglobin"),
            data.get("crp"), data.get("esr"),
            data.get("creatinine"), data.get("urea"),
            data.get("bilirubin"), data.get("ast"), data.get("alt"), data.get("inr"),
            data.get("sodium"), data.get("potassium"),
            data.get("map"), data.get("troponin_positive"),
            data.get("pao2_fio2"), data.get("gcs"), data.get("urine_output"),
            data.get("risk_factors"), score, level, now
        ))

        # 4. Insert into symptoms table (handle string or list)
        symptoms_data = data.get("symptoms", "")
        if symptoms_data:
            symptoms_list = []
            if isinstance(symptoms_data, list):
                symptoms_list = symptoms_data
            else:
                symptoms_list = [s.strip() for s in symptoms_data.split(",") if s.strip()]
            
            for symptom_name in symptoms_list:
                cursor.execute(
                    "INSERT INTO symptoms (patient_id, symptom_name, recorded_at) VALUES (%s, %s, %s)",
                    (patient_id, symptom_name, now)
                )

        # 5. History tracking in analysis_results
        cursor.execute("""
            INSERT INTO analysis_results 
            (patient_id, doctor_id, severity_result, vitals_id, severity_score, severity_level, analyzed_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            patient_id, doctor_id, level, vitals_id, score, level, now
        ))

        conn.commit()
        
        # 6. Notifications for critical results
        if level == "CRITICAL" and p_info:
            try:
                cursor.execute(
                    "INSERT INTO notifications (title, message, target_role, doctor_id) VALUES (%s, %s, %s, %s)",
                    ("Severity Alert", f"CRITICAL ALERT: Patient {p_info['name']} reached CRITICAL status", 'doctor', doctor_id)
                )
                conn.commit()
            except:
                pass

        return jsonify({
            "status": "success",
            "message": "Analysis completed successfully",
            "severity_level": level
        })

    except Exception as e:
        if conn.is_connected():
            conn.rollback()
        print(f"ERROR save_analysis_result: {str(e)}")
        return jsonify({"success": False, "message": str(e)}), 400
    finally:
        cursor.close()
        conn.close()



@app.route("/add_advanced_severity", methods=["POST"])
def add_advanced_severity():
    data = request.json
    if not data:
        return jsonify({"success": False, "error": "No data received"}), 400

    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        now = datetime.now()
        patient_id = data.get("patient_id")

        # 1. Update patients table summary
        cursor.execute("""
        UPDATE patients 
        SET severity_score=%s, severity_level=%s, last_vitals_date=%s
        WHERE id=%s
        """, (
            data.get("severity_score"),
            data.get("severity_level"),
            now,
            patient_id
        ))

        # 2. Insert into advanced_assessments (new table for details)
        query = """
        INSERT INTO advanced_assessments (
            patient_id, wbc, platelets, hemoglobin, crp, esr, creatinine, urea,
            bilirubin, ast, alt, inr, sodium, potassium, map, troponin_positive,
            pao2_fio2, gcs, urine_output, risk_factors, severity_score, severity_level, recorded_at
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (
            patient_id,
            data.get("wbc"), data.get("platelets"), data.get("hemoglobin"),
            data.get("crp"), data.get("esr"),
            data.get("creatinine"), data.get("urea"),
            data.get("bilirubin"), data.get("ast"), data.get("alt"), data.get("inr"),
            data.get("sodium"), data.get("potassium"),
            data.get("map"), data.get("troponin_positive"),
            data.get("pao2_fio2"), data.get("gcs"), data.get("urine_output"),
            data.get("risk_factors"),
            data.get("severity_score"), data.get("severity_level"),
            now
        )
        cursor.execute(query, values)

        conn.commit()

        # 3. Trigger notification if critical
        severity_level = data.get("severity_level", "")
        if severity_level in ["Critical", "Severe"]:
            try:
                cursor.execute("SELECT name, assigned_doctor_id FROM patients WHERE id = %s", (patient_id,))
                p_info = cursor.fetchone()
                if p_info:
                    cursor.execute(
                        "INSERT INTO notifications (title, message, target_role, doctor_id) VALUES (%s, %s, %s, %s)",
                        ("Severity Alert", f"CRITICAL ALERT: Patient {p_info['name']} reached {severity_level} status", 'doctor', p_info['assigned_doctor_id'])
                    )
                    conn.commit()
            except:
                pass

        return jsonify({"success": True, "message": "Advanced assessment saved successfully"})

    except Exception as e:
        conn.rollback()
        print(f"ERROR add_advanced_severity: {str(e)}")
        return jsonify({"success": False, "message": str(e)}), 400
    finally:
        cursor.close()
        conn.close()


# -----------------------------
# DOCTOR PROFILE
# -----------------------------

@app.route("/doctor/<int:doctor_id>", methods=["GET"])
def get_doctor_profile(doctor_id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(
            "SELECT id, fullname, email, phone, specialization, profile_image FROM doctors WHERE id = %s",
            (doctor_id,)
        )
        doctor = cursor.fetchone()
        if doctor:
            return jsonify({"success": True, "doctor": doctor})
        else:
            return jsonify({"success": False, "message": "Doctor not found"}), 404
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()


@app.route("/update_doctor/<int:doctor_id>", methods=["PUT"])
def update_doctor(doctor_id):
    data = request.json
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(
            "UPDATE doctors SET fullname=%s, email=%s, phone=%s, specialization=%s, profile_image=%s WHERE id=%s",
            (data.get("fullname"), data.get("email"), data.get("phone"), data.get("specialization"), data.get("profile_image"), doctor_id)
        )
        conn.commit()
        return jsonify({"success": True, "message": "Profile updated successfully"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()


@app.route("/change_password", methods=["POST"])
def change_password():
    data = request.json
    doctor_id = data.get("doctor_id")
    current_password = data.get("current_password")
    new_password = data.get("new_password")
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id FROM doctors WHERE id=%s AND password=%s", (doctor_id, current_password))
        doctor = cursor.fetchone()
        if not doctor:
            return jsonify({"success": False, "message": "Current password is incorrect"}), 401
        cursor.execute("UPDATE doctors SET password=%s WHERE id=%s", (new_password, doctor_id))
        conn.commit()
        return jsonify({"success": True, "message": "Password changed successfully"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()


# -----------------------------
# PASSWORD RECOVERY (OTP)
# -----------------------------

@app.route("/send_otp", methods=["POST"])
def send_otp():
    data = request.json
    email = data.get("email")

    if not email:
        return jsonify({"success": False, "message": "Email is required"}), 400

    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Check if doctor exists
        cursor.execute("SELECT id FROM doctors WHERE email=%s", (email,))
        doctor = cursor.fetchone()
        
        if not doctor:
            return jsonify({"success": False, "message": "User not found with this email"}), 404

        # Generate 6-digit OTP
        otp = str(random.randint(100000, 999999))
        
        # Store OTP (you might want to add expiration logic)
        otp_storage[email] = otp

        # Send Email
        try:
            msg = Message("MEDISEV Password Reset OTP", sender=app.config.get("MAIL_USERNAME"), recipients=[email])
            msg.html = f"<html><body><p>Hi,<br>Your OTP for password reset is <b>{otp}</b>. Please do not share this with anyone.</p></body></html>"
            mail.send(msg)
            return jsonify({"success": True, "message": "OTP sent to your email. Please check your inbox."})
        except Exception as mail_error:
            # If email fails, store it anyway and show OTP in console for local testing
            print(f"!!! EMAIL FAILED: {str(mail_error)} !!!")
            print(f"!!! FORGOT PASSWORD OTP FOR {email}: {otp} !!!")
            # We return success True but with a warning, or return specific message
            return jsonify({
                "success": True, 
                "message": f"Dev Mode: Email failed ({str(mail_error)}). YOUR OTP IS: {otp}"
            })

    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({"success": False, "message": str(e)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route("/reset_password_otp", methods=["POST"])
def reset_password_otp():
    data = request.json
    email = data.get("email")
    otp = data.get("otp")
    new_password = data.get("new_password")

    if not all([email, otp, new_password]):
        return jsonify({"success": False, "message": "Email, OTP, and New Password are required"}), 400

    if email not in otp_storage or otp_storage[email] != otp:
        return jsonify({"success": False, "message": "Invalid or expired OTP"}), 400

    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        # Update Password
        cursor.execute("UPDATE doctors SET password=%s WHERE email=%s", (new_password, email))
        conn.commit()

        # Clear OTP
        del otp_storage[email]

        return jsonify({"success": True, "message": "Password reset successfully. You can now login."})
    except Exception as e:
        print(f"ERROR reset_password_otp: {str(e)}")
        return jsonify({"success": False, "message": str(e)}), 500
    finally:
        cursor.close()
        conn.close()


# -----------------------------
# ML PREDICTION
# -----------------------------

# Load model and label encoder if they exist
MODEL_PATH = 'severity_model.pkl'
ENCODER_PATH = 'label_encoder.pkl'

model = None
le = None

if os.path.exists(MODEL_PATH) and os.path.exists(ENCODER_PATH):
    try:
        model = joblib.load(MODEL_PATH)
        le = joblib.load(ENCODER_PATH)
        print("ML Model loaded successfully.")
    except Exception as e:
        print(f"Error loading ML model: {e}")


@app.route("/predict_severity", methods=["POST"])
def predict_severity():
    # Reload model if it wasn't loaded
    global model, le
    if model is None or le is None:
        if os.path.exists(MODEL_PATH) and os.path.exists(ENCODER_PATH):
            model = joblib.load(MODEL_PATH)
            le = joblib.load(ENCODER_PATH)
        else:
            return jsonify({"success": False, "error": "Model not trained yet. Please run train_model.py."}), 500

    data = request.json

    try:
        # Convert BP like "120/80" -> 120
        bp = data.get("blood_pressure", "0")
        if isinstance(bp, str) and "/" in bp:
            bp = float(bp.split("/")[0])
        else:
            bp = float(bp)

        # Map database fields to ML model features
        features = [
            float(data.get("temperature", 0)),
            float(data.get("heart_rate", 0)),
            float(data.get("respiratory_rate", 0)),
            bp,
            float(data.get("spo2", 0)),
            float(data.get("blood_glucose", 0)),
            float(data.get("wbc", 0)),
            float(data.get("platelets", 0)),
            float(data.get("hemoglobin", 0)),
            float(data.get("crp", 0)),
            float(data.get("esr", 0)),
            float(data.get("creatinine", 0)),
            float(data.get("urea", 0)),
            float(data.get("bilirubin", 0)),
            float(data.get("ast", 0)),
            float(data.get("alt", 0)),
            float(data.get("inr", 0)),
            float(data.get("sodium", 0)),
            float(data.get("potassium", 0)),
            float(data.get("map", 0)),
            float(data.get("troponin_positive", 0)),
            float(data.get("pao2_fio2", 0)),
            float(data.get("gcs", 0)),
            float(data.get("urine_output", 0))
        ]

        # Convert to numpy array
        input_data = np.array(features).reshape(1, -1)

        # Prediction
        prediction_idx = model.predict(input_data)[0]
        prediction_label = le.inverse_transform([prediction_idx])[0]

        # Confidence
        probabilities = model.predict_proba(input_data)[0]
        confidence = float(np.max(probabilities))

        return jsonify({
            "success": True,
            "predicted_level": prediction_label,
            "confidence": f"{confidence * 100:.1f}%"
        })

    except Exception as e:
        print("Prediction Error:", e)
        return jsonify({"success": False, "message": str(e)}), 400
@app.route("/notifications/broadcast", methods=["POST"])
def send_broadcast():
    data = request.json
    title = data.get("title", "Broadcast")
    message = data.get("message")
    
    if not message:
        return jsonify({"success": False, "message": "Message content is required"}), 400
        
    conn = get_db()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO notifications (title, message, target_role, doctor_id) VALUES (%s, %s, %s, NULL)",
            (title, message, 'doctor')
        )
        conn.commit()
        return jsonify({"success": True, "message": "Broadcast sent successfully"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400
    finally:
        cursor.close()
        conn.close()

GEMINI_API_KEY = "AIzaSyD0vvHBsGZz2dYpmNrRuJjDyAMviWBupkM"

@app.route("/analyze_report", methods=["POST"])
def analyze_report():
    data = request.json
    image_data = data.get("image")  # Base64 encoded image
    
    if not image_data:
        return jsonify({"success": False, "message": "No image data provided"}), 400

    prompt = """
    You are a professional medical report analyzer. Analyze the provided clinical report image and extract ALL detectable clinical parameters into a structured JSON format. 
    
    ### Guidelines:
    1. EXTRACT ALL available values. If a value is not explicitly mentioned, return null.
    2. DATA TYPES: Use numbers for laboratory values and vitals (except Blood Pressure). Use boolean for status flags.
    3. UNITS/SYNONYMS: Recognize common abbreviations and synonyms (e.g., BUN for Urea, Hgb for Hemoglobin). Normalize output to standard numerical values.
    4. SYMPTOMS: Carefully extract any specific patient symptoms or complaints mentioned in text (e.g., "fever", "cough", "chest pain").
    
    ### Map to these exact JSON keys:
    - "blood_pressure": (String) e.g., "120/80"
    - "heart_rate": (Number)
    - "spo2": (Number)
    - "temperature": (Number)
    - "respiratory_rate": (Number)
    - "blood_glucose": (Number)
    
    - "wbc": (Number)
    - "platelets": (Number)
    - "hemoglobin": (Number)
    - "crp": (Number)
    - "esr": (Number)
    
    - "creatinine": (Number)
    - "urea": (Number)
    - "bilirubin": (Number)
    - "ast": (Number)
    - "alt": (Number)
    - "inr": (Number)
    - "sodium": (Number)
    - "potassium": (Number)
    
    - "map": (Number)
    - "troponin_positive": (Boolean) -> true if Troponin is positive/elevated
    - "pao2_fio2": (Number)
    - "gcs": (Number) (Total GCS score 3-15)
    - "urine_output": (Number) (e.g., mL/kg/hr or total L)
    
    - "symptoms": (String) Comma-separated list of symptoms found in the report text.
    
    ### Output:
    Return ONLY a valid JSON object. Do not include markdown formatting or backticks.
    """

    try:
        print("Starting AI Analysis...")
        # Using gemini-flash-latest as it often has the most reliable free-tier quota
        url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key={GEMINI_API_KEY}"
        
        # Clean the image data
        if "," in image_data:
            image_data = image_data.split(",")[1]
            
        # Detect mime type
        mime_type = "image/jpeg"
        if image_data.startswith("iVBORw0KGgo"):
             mime_type = "image/png"
        elif image_data.startswith("R0lGOD"):
             mime_type = "image/gif"
        
        payload = {
            "contents": [
                {
                    "parts": [
                        {"text": prompt + "\n\nIMPORTANT: Return ONLY a valid JSON object. Do not include markdown formatting or backticks."},
                        {
                            "inline_data": {
                                "mime_type": mime_type,
                                "data": image_data
                            }
                        }
                    ]
                }
            ]
        }

        response = requests.post(
            url, 
            headers={"Content-Type": "application/json"}, 
            json=payload, 
            timeout=30
        )
        
        if response.status_code != 200:
            error_json = response.json() if response.text else {}
            error_msg = error_json.get("error", {}).get("message", "Unknown Gemini Error")
            print(f"Gemini API Error: {response.status_code} - {error_msg}")
            return jsonify({
                "success": False, 
                "message": f"AI Error ({response.status_code}): {error_msg[:120]}",
                "details": response.text
            }), 500
            
        response_data = response.json()
        
        if "candidates" in response_data and response_data["candidates"]:
            candidate = response_data["candidates"][0]
            if "content" in candidate and "parts" in candidate["content"]:
                content = candidate["content"]["parts"][0]["text"]
                print("Extracted content successfully")
                try:
                    # AI might sometimes wrap JSON in backticks despite generationConfig
                    json_str = content.strip()
                    if json_str.startswith("```json"):
                        json_str = json_str.replace("```json", "").replace("```", "").strip()
                    elif json_str.startswith("```"):
                        json_str = json_str.replace("```", "").strip()
                        
                    analysis_result = json.loads(json_str)
                    
                    # Ensure all requested keys exist with defaults
                    all_keys = {
                        "blood_pressure": "0/0", "heart_rate": 0, "spo2": 0, "temperature": 0.0,
                        "respiratory_rate": 0, "blood_glucose": 0.0, "wbc": 0.0, "platelets": 0.0,
                        "hemoglobin": 0.0, "crp": 0.0, "esr": 0.0, "creatinine": 0.0, "urea": 0.0,
                        "bilirubin": 0.0, "ast": 0.0, "alt": 0.0, "inr": 0.0, "sodium": 0.0,
                        "potassium": 0.0, "map": 0.0, "troponin_positive": False, "pao2_fio2": 0.0,
                        "gcs": 15, "urine_output": 0.0, "symptoms": ""
                    }
                    
                    for key, default in all_keys.items():
                        if key not in analysis_result or analysis_result[key] is None:
                            analysis_result[key] = default
                            
                    return jsonify({
                        "success": True,
                        "data": analysis_result
                    })
                except json.JSONDecodeError as je:
                    print(f"JSON Parse Error: {je}")
                    return jsonify({"success": False, "message": "The AI response was not in the correct format.", "raw": content}), 500
            else:
                return jsonify({"success": False, "message": "The AI returned an empty response.", "details": response_data}), 500
        else:
            reason = response_data.get("promptFeedback", {}).get("blockReason", "UnknownReason")
            return jsonify({"success": False, "message": f"AI process blocked: {reason}", "details": response_data}), 500
            
    except Exception as e:
        print("Analysis Exception:", e)
        return jsonify({"success": False, "message": f"Connection Error: {str(e)}"}), 500

@app.route("/get_reports", methods=["GET"])
def get_reports():
    return get_admin_reports()

@app.route("/get_patients", methods=["GET"])
def get_patients():
    return get_all_patients()

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
