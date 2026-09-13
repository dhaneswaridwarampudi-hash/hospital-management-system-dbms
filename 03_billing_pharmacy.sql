
-- 1. Medicines Table
CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0
);

-- 2. Prescriptions Table
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT,
    prescription_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE SET NULL
);

-- 3. Prescription Items Table
CREATE TABLE prescription_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    dosage VARCHAR(100),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id) ON DELETE CASCADE
);

-- 4. Bills Table
CREATE TABLE bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT,
    doctor_fee DECIMAL(10,2) DEFAULT 0.00,
    room_charges DECIMAL(10,2) DEFAULT 0.00,
    medicine_charges DECIMAL(10,2) DEFAULT 0.00,
    total_amount DECIMAL(10,2) GENERATED ALWAYS AS (doctor_fee + room_charges + medicine_charges) STORED,
    bill_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Unpaid', 'Paid') DEFAULT 'Unpaid',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE SET NULL
);

-- 5. Payments Table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash', 'Card', 'Insurance', 'UPI') NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id) ON DELETE CASCADE
);

-- --- Sample Data Insertions ---

INSERT INTO medicines (medicine_name, unit_price, stock_quantity) VALUES 
    ('Paracetamol 500mg', 5.00, 100), 
    ('Amoxicillin 250mg', 12.50, 50),
    ('Ibuprofen 400mg', 8.00, 75);

-- Prescriptions (Tied to patients created in Module 1)
INSERT INTO prescriptions (patient_id, doctor_id, appointment_id) VALUES 
    (1, 1, 1), 
    (2, 2, 2);

INSERT INTO prescriptions (patient_id, doctor_id, appointment_id) VALUES 
    (3, 1, NULL); -- Walk-in prescription without tied appointment

INSERT INTO prescription_items (prescription_id, medicine_id, quantity, dosage) VALUES 
    (1, 1, 20, '1 tablet thrice a day'), 
    (2, 2, 10, '1 tablet twice a day'),
    (3, 3, 15, 'As needed for pain');

-- Bills (Tied to patients created in Module 1)
INSERT INTO bills (patient_id, appointment_id, doctor_fee, room_charges, medicine_charges, status) VALUES 
    (1, 1, 100.00, 50.00, 100.00, 'Paid'), 
    (2, 2, 150.00, 0.00, 125.00, 'Unpaid');

-- Bill for patient 3 without an appointment reference (Walk-in)
INSERT INTO bills (patient_id, appointment_id, doctor_fee, room_charges, medicine_charges, status) VALUES 
    (3, NULL, 75.00, 0.00, 120.00, 'Paid');

-- Payments recorded for paid bills
INSERT INTO payments (bill_id, amount_paid, payment_method) VALUES 
    (1, 250.00, 'Card'),
    (3, 195.00, 'UPI');
