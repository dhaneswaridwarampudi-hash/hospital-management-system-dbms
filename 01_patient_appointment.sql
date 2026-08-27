-- Patients Table
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    blood_group VARCHAR(5),
    emergency_contact VARCHAR(15),
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments Table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'No-Show') DEFAULT 'Scheduled',
    reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE
);

-- Sample Test Data
INSERT INTO patients (first_name, last_name, dob, gender, phone, email, address, blood_group, emergency_contact)
VALUES ('John', 'Doe', '1990-05-15', 'Male', '9876543210', 'john@example.com', '123 Main St', 'O+', '9876543211');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, reason)
VALUES (1, 101, '2026-03-01', '10:00:00', 'Scheduled', 'General Checkup');
