-- Unified Cross-Module Test: Connecting Patients, Appointments, and Bills
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.phone,
    a.appointment_id,
    a.appointment_date,
    a.status,
    b.total_amount,
    b.payment_status
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN bills b ON a.appointment_id = b.appointment_id;
