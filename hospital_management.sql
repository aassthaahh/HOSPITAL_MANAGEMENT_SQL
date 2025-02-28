-- Create Database
DROP DATABASE IF EXISTS hospital_management;
CREATE DATABASE hospital_management;
USE hospital_management;

-- Patient Table
DROP TABLE IF EXISTS patient;
CREATE TABLE patient (
    email VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);

-- Doctor Table
DROP TABLE IF EXISTS doctor;
CREATE TABLE doctor (
    email VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);

-- Appointment Table
DROP TABLE IF EXISTS appointment;
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_email VARCHAR(50),
    doctor_email VARCHAR(50),
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (patient_email) REFERENCES patient(email) ON DELETE CASCADE,
    FOREIGN KEY (doctor_email) REFERENCES doctor(email) ON DELETE CASCADE
);

-- Medical History Table
DROP TABLE IF EXISTS medical_history;
CREATE TABLE medical_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_email VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    conditions TEXT NOT NULL,
    surgeries TEXT NOT NULL,
    medication TEXT NOT NULL,
    FOREIGN KEY (patient_email) REFERENCES patient(email) ON DELETE CASCADE
);

-- Patient Visits Table
DROP TABLE IF EXISTS patient_visits;
CREATE TABLE patient_visits (
    visit_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_email VARCHAR(50) NOT NULL,
    appointment_id INT NOT NULL,
    concerns TEXT NOT NULL,
    symptoms TEXT NOT NULL,
    FOREIGN KEY (patient_email) REFERENCES patient(email) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id) ON DELETE CASCADE
);

-- Diagnosis Table
DROP TABLE IF EXISTS diagnose;
CREATE TABLE diagnose (
    diagnosis_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    doctor_email VARCHAR(50) NOT NULL,
    diagnosis TEXT NOT NULL,
    prescription TEXT NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_email) REFERENCES doctor(email) ON DELETE CASCADE
);

-- Doctor Schedule Table
DROP TABLE IF EXISTS doctor_schedule;
CREATE TABLE doctor_schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_email VARCHAR(50) NOT NULL,
    day ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    break_time TIME NOT NULL,
    FOREIGN KEY (doctor_email) REFERENCES doctor(email) ON DELETE CASCADE
);

