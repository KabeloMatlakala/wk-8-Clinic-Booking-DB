CREATE DATABASE ClinicBookingSystem;
USE ClinicBookingSystem;

-- Drop tables if they exist (for re-runs)
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS DoctorSpecialties;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Specialties;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;

-- Patients table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Doctors table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    hire_date DATE NOT NULL
);

-- Specialties table
CREATE TABLE Specialties (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Junction table: DoctorSpecialties (Many-to-Many)
CREATE TABLE DoctorSpecialties (
    doctor_id INT,
    specialty_id INT,
    PRIMARY KEY (doctor_id, specialty_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (specialty_id) REFERENCES Specialties(specialty_id) ON DELETE CASCADE
);

-- Rooms table (optional, used in appointments)
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type ENUM('Consultation', 'Surgery', 'Examination') NOT NULL
);

-- Appointments table (1-to-Many: patient_id → appointments, doctor_id → appointments)
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    room_id INT,
    appointment_datetime DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Prescriptions table (1-to-1 per appointment)
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    medication TEXT NOT NULL,
    dosage TEXT NOT NULL,
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);



-- Sample Data --
-- Insert Patients
INSERT INTO Patients (first_name, last_name, dob, gender, phone, email) VALUES
('John', 'Doe', '1990-05-12', 'Male', '1234567890', 'john.doe@example.com'),
('Jane', 'Smith', '1985-03-22', 'Female', '0987654321', 'jane.smith@example.com'),
('Alice', 'Johnson', '2000-07-15', 'Female', '1112223333', 'alice.j@example.com');

-- Insert Doctors
INSERT INTO Doctors (first_name, last_name, email, phone, hire_date) VALUES
('Dr. Emily', 'Clark', 'emily.clark@clinic.com', '2223334444', '2020-01-10'),
('Dr. Mark', 'Lee', 'mark.lee@clinic.com', '3334445555', '2018-06-25');

-- Insert Specialties
INSERT INTO Specialties (name) VALUES
('Cardiology'),
('Dermatology'),
('Pediatrics');

-- Insert DoctorSpecialties
INSERT INTO DoctorSpecialties (doctor_id, specialty_id) VALUES
(1, 1),  -- Dr. Emily - Cardiology
(1, 3),  -- Dr. Emily - Pediatrics
(2, 2);  -- Dr. Mark - Dermatology

-- Insert Rooms
INSERT INTO Rooms (room_number, room_type) VALUES
('101', 'Consultation'),
('202', 'Examination'),
('303', 'Surgery');

-- Insert Appointments
INSERT INTO Appointments (patient_id, doctor_id, room_id, appointment_datetime, reason, status) VALUES
(1, 1, 1, '2025-05-10 09:00:00', 'Regular check-up', 'Scheduled'),
(2, 2, 2, '2025-05-11 14:30:00', 'Skin rash consultation', 'Scheduled'),
(3, 1, 1, '2025-05-12 10:15:00', 'Pediatric fever', 'Scheduled');

-- Insert Prescriptions
INSERT INTO Prescriptions (appointment_id, medication, dosage, instructions) VALUES
(1, 'Aspirin', '100mg', 'Take one tablet after breakfast'),
(2, 'Hydrocortisone Cream', 'Apply twice daily', 'Apply to affected area'),
(3, 'Paracetamol', '500mg', 'Take every 6 hours if fever persists');
