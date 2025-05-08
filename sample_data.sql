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
