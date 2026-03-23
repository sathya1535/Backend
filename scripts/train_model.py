import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
import joblib
import os

def train():
    dataset_path = 'full_patient_severity_dataset.csv'
    
    if not os.path.exists(dataset_path):
        print(f"Error: {dataset_path} not found!")
        return

    print("Loading dataset...")
    df = pd.read_csv(dataset_path)

    # EXACT headers specified by the user
    features = [
        'Temperature', 'Heart_Rate', 'Respiratory_Rate', 'BP_Systolic', 
        'SpO2', 'Blood_Glucose', 'WBC', 'Platelets', 'Hemoglobin', 
        'CRP', 'ESR', 'Creatinine', 'Urea', 'Bilirubin', 'AST', 'ALT', 
        'INR', 'Sodium', 'Potassium', 'MAP', 'Troponin_Positive', 
        'PaO2_FiO2', 'GCS', 'Urine_Output'
    ]
    target = 'Severity'

    # Check if all features exist in the CSV
    missing_cols = [col for col in features + [target] if col not in df.columns]
    if missing_cols:
        print(f"Error: Missing columns in CSV: {missing_cols}")
        print("Please run 'python generate_data.py' first to update the CSV.")
        return

    # 3. Preprocessing
    print("Preprocessing data...")
    for col in features:
        df[col] = pd.to_numeric(df[col], errors='coerce')
        df[col] = df[col].fillna(df[col].median())

    # Encode labels (Mild, Moderate, Severe)
    le = LabelEncoder()
    df[target] = le.fit_transform(df[target].astype(str))
    
    print(f"Label Mapping: {dict(zip(le.classes_, le.transform(le.classes_)))}")

    X = df[features]
    y = df[target]

    # 4. Train
    print("Training Random Forest model...")
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    model = RandomForestClassifier(n_estimators=150, max_depth=12, random_state=42)
    model.fit(X_train, y_train)

    accuracy = model.score(X_test, y_test)
    print(f"Model Accuracy: {accuracy * 100:.2f}%")

    # 5. Save
    joblib.dump(model, 'severity_model.pkl')
    joblib.dump(le, 'label_encoder.pkl')
    print("Files saved: 'severity_model.pkl' and 'label_encoder.pkl'")

if __name__ == "__main__":
    train()
