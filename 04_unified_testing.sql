-- Unified Cross-Module Test: Connecting Patients, Appointments, and Bills
-- Using LEFT JOINs to properly accommodate and display NULL relationships (e.g., walk-in bills or unbilled appointments)

SELECT 
    p.patient_id, 
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name, 
    p.phone, 
    COALESCE(a.appointment_id, 'No Appointment') AS appointment_id, 
    COALESCE(CAST(a.appointment_date AS CHAR), 'Walk-in / N/A') AS appointment_date, 
    COALESCE(a.status, 'N/A') AS appointment_status, 
    COALESCE(b.total_amount, 0.00) AS total_amount, 
    COALESCE(b.status, 'No Bill Generated') AS bill_status
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id
LEFT JOIN bills b ON a.appointment_id = b.appointment_id;

-- Additional Unified View: Doctor, Department, and Schedule Mapping
-- Safely handling doctors with NULL departments (e.g., general float staff)

SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialization,
    COALESCE(dep.department_name, 'Unassigned / Independent') AS department_name,
    COALESCE(ds.day_of_week, 'No Schedule Set') AS work_day,
    COALESCE(CAST(ds.start_time AS CHAR), '-') AS start_time,
    COALESCE(CAST(ds.end_time AS CHAR), '-') AS end_time
FROM doctors d
LEFT JOIN departments dep ON d.department_id = dep.department_id
LEFT JOIN doctor_schedules ds ON d.doctor_id = ds.doctor_id;
