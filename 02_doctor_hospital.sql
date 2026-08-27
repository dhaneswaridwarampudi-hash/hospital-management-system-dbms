-- Module 2: Doctor & Hospital Management

-- 1. Departments Table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    building_floor INT NOT NULL
);

-- 2. Doctors Table
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

-- 3. Doctor Schedules Table
CREATE TABLE doctor_schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
);

-- 4. Rooms / Wards Table
CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type ENUM('General', 'Private', 'ICU') NOT NULL,
    daily_rate DECIMAL(10,2) NOT NULL,
    status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available'
);

-- Insert Sample Data
INSERT INTO departments (department_name, building_floor) VALUES 
('Cardiology', 2), 
('Neurology', 3), 
('Pediatrics', 1);

INSERT INTO doctors (first_name, last_name, department_id, specialization, phone, email) VALUES 
('Robert', 'Chen', 1, 'Cardiologist', '9876500001', 'dr.robert@hospital.com'),
('Sarah', 'Jenkins', 2, 'Neurologist', '9876500002', 'dr.sarah@hospital.com');

INSERT INTO doctor_schedules (doctor_id, day_of_week, start_time, end_time) VALUES 
(1, 'Monday', '09:00:00', '17:00:00'),
(1, 'Wednesday', '09:00:00', '17:00:00'),
(2, 'Tuesday', '10:00:00', '16:00:00');

INSERT INTO rooms (room_number, room_type, daily_rate, status) VALUES 
('101-A', 'General', 50.00, 'Available'),
('201-B', 'Private', 150.00, 'Occupied'),
('ICU-01', 'ICU', 300.00, 'Available');
