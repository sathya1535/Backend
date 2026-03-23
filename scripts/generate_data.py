import pandas as pd
import numpy as np
import random

def generate_medical_data(num_samples=1000):
    data = []
    
    for i in range(1, num_samples + 1):
        # Category: Mild, Moderate, Severe
        category = random.choice(['Mild', 'Moderate', 'Severe'])
        
        if category == 'Mild':
            row = {
                'Patient_ID': i,
                'Severity': 'Mild',
                'Temperature': random.uniform(36.5, 37.5),
                'Heart_Rate': random.uniform(60, 90),
                'Respiratory_Rate': random.uniform(12, 18),
                'BP_Systolic': random.uniform(110, 130),
                'SpO2': random.uniform(96, 100),
                'Blood_Glucose': random.uniform(70, 110),
                'WBC': random.uniform(4000, 11000),
                'Platelets': random.uniform(150000, 450000),
                'Hemoglobin': random.uniform(12, 17),
                'CRP': random.uniform(0, 10),
                'ESR': random.uniform(0, 20),
                'Creatinine': random.uniform(0.7, 1.2),
                'Urea': random.uniform(7, 20),
                'Bilirubin': random.uniform(0.1, 1.2),
                'AST': random.uniform(10, 40),
                'ALT': random.uniform(10, 40),
                'INR': random.uniform(0.8, 1.2),
                'Sodium': random.uniform(135, 145),
                'Potassium': random.uniform(3.5, 5.0),
                'MAP': random.uniform(70, 100),
                'Troponin_Positive': 0,
                'PaO2_FiO2': random.uniform(400, 500),
                'GCS': 15,
                'Urine_Output': random.uniform(1000, 2000)
            }
        elif category == 'Moderate':
            row = {
                'Patient_ID': i,
                'Severity': 'Moderate',
                'Temperature': random.uniform(37.6, 38.5),
                'Heart_Rate': random.uniform(90, 115),
                'Respiratory_Rate': random.uniform(19, 25),
                'BP_Systolic': random.uniform(140, 160),
                'SpO2': random.uniform(91, 95),
                'Blood_Glucose': random.uniform(140, 200),
                'WBC': random.uniform(11001, 15000),
                'Platelets': random.uniform(100000, 149000),
                'Hemoglobin': random.uniform(9, 11.5),
                'CRP': random.uniform(11, 50),
                'ESR': random.uniform(21, 50),
                'Creatinine': random.uniform(1.3, 2.0),
                'Urea': random.uniform(21, 45),
                'Bilirubin': random.uniform(1.3, 2.5),
                'AST': random.uniform(41, 100),
                'ALT': random.uniform(41, 100),
                'INR': random.uniform(1.3, 1.7),
                'Sodium': random.uniform(130, 134),
                'Potassium': random.uniform(5.1, 5.8),
                'MAP': random.uniform(60, 69),
                'Troponin_Positive': random.choice([0, 1]),
                'PaO2_FiO2': random.uniform(200, 399),
                'GCS': random.uniform(12, 14),
                'Urine_Output': random.uniform(400, 999)
            }
        else: # Severe
            row = {
                'Patient_ID': i,
                'Severity': 'Severe',
                'Temperature': random.uniform(39.0, 41.0),
                'Heart_Rate': random.uniform(120, 160),
                'Respiratory_Rate': random.uniform(26, 45),
                'BP_Systolic': random.uniform(170, 220),
                'SpO2': random.uniform(70, 90),
                'Blood_Glucose': random.uniform(250, 500),
                'WBC': random.uniform(15001, 50000),
                'Platelets': random.uniform(10000, 99000),
                'Hemoglobin': random.uniform(5, 8.5),
                'CRP': random.uniform(51, 300),
                'ESR': random.uniform(51, 150),
                'Creatinine': random.uniform(2.1, 8.0),
                'Urea': random.uniform(46, 150),
                'Bilirubin': random.uniform(2.6, 12.0),
                'AST': random.uniform(101, 2500),
                'ALT': random.uniform(101, 2500),
                'INR': random.uniform(1.8, 6.0),
                'Sodium': random.uniform(115, 129),
                'Potassium': random.uniform(5.9, 8.0),
                'MAP': random.uniform(30, 59),
                'Troponin_Positive': 1,
                'PaO2_FiO2': random.uniform(50, 199),
                'GCS': random.uniform(3, 11),
                'Urine_Output': random.uniform(0, 399)
            }
        data.append(row)
    
    df = pd.DataFrame(data)
    df.to_csv('full_patient_severity_dataset.csv', index=False)
    print(f"Successfully generated full_patient_severity_dataset.csv with {num_samples} samples and correct headers.")

if __name__ == "__main__":
    generate_medical_data()
