# Hospital Management System (DBMS Project)

A relational database project for managing hospital operations, developed by a team of three.

## Team Modules & Responsibilities
| Member | Module | Development Scope |
| :--- | :--- | :--- |
| **Member 1 (Lead)** | 👨‍⚕️ Patient & Appointment | Patient Registration, Patient Records, Appointment Booking/Cancellation |
| **Member 2** | 🩺 Doctor & Hospital | Doctor Details, Departments, Doctor Schedules, Room/Ward Availability |
| **Member 3** | 💳 Billing & Pharmacy | Medicine Inventory, Prescriptions, Bill Calculation, Payments |

## Database Execution Order
To prevent foreign key dependency errors, execute the SQL files in this exact order:
1. `01_patient_appointment.sql` — Creates base patients and appointments.
2. `02_doctor_hospital.sql` — Creates departments, doctors, and rooms.
3. `03_billing_pharmacy.sql` — Creates pharmacy, prescriptions, and billing.
4. `04_unified_testing.sql` — Runs cross-module JOIN verification queries.
