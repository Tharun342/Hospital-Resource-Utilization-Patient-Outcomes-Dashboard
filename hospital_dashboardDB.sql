CREATE DATABASE hospital_dashboard_M;
USE hospital_dashboard_M;
# 1
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50)
);
#2
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    insurance_type VARCHAR(50)
);
#3
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100),
    department_id INT,
    available_hours INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
#4
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    department_id INT,
    admission_date DATETIME,
    discharge_date DATETIME,
    admission_type VARCHAR(20),
    bed_type VARCHAR(20),
    branch_name VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
#5
CREATE TABLE procedures (
    procedure_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    procedure_name VARCHAR(100),
    procedure_date DATETIME,
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);
#6
CREATE TABLE billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    total_cost DECIMAL(10,2),
    medicine_cost DECIMAL(10,2),
    room_cost DECIMAL(10,2),
    procedure_cost DECIMAL(10,2),
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);
#7
CREATE TABLE outcomes (
    outcome_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    outcome_status VARCHAR(30),
    readmitted_within_30_days BOOLEAN,
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);

INSERT INTO departments (department_name) VALUES
('Cardiology'),('Orthopedics'),('Emergency'),('Pediatrics'),('Oncology'),('General Medicine');

INSERT INTO patients (patient_name, age, gender, insurance_type) VALUES
('Ravi Kumar', 45, 'Male', 'Private'),('Anita Sharma', 30, 'Female', 'Government'),
('Suresh Reddy', 62, 'Male', 'Private'),('Meena Das', 5, 'Female', 'Government'),
('Rahul Verma', 50, 'Male', 'Corporate');

INSERT INTO doctors (doctor_name, department_id, available_hours) VALUES
('Dr. Rao', 1, 8),('Dr. Singh', 2, 8),('Dr. Patel', 3, 10),
('Dr. Nair', 4, 6),('Dr. Iyer', 6, 8);

INSERT INTO admissions
(patient_id, doctor_id, department_id, admission_date, discharge_date, admission_type, bed_type, branch_name)
VALUES
(1, 1, 1, '2025-01-01 10:00:00', '2025-01-05 12:00:00', 'Scheduled', 'General', 'Chennai'),
(2, 2, 2, '2025-01-02 15:30:00', '2025-01-04 11:00:00', 'Scheduled', 'General', 'Chennai'),
(3, 3, 3, '2025-01-03 02:00:00', '2025-01-06 14:00:00', 'Emergency', 'ICU', 'Bangalore'),
(4, 4, 4, '2025-01-04 09:00:00', '2025-01-07 10:00:00', 'Scheduled', 'General', 'Hyderabad'),
(5, 5, 6, '2025-01-05 20:00:00', NULL, 'Emergency', 'ICU', 'Bangalore');
INSERT INTO procedures (admission_id, procedure_name, procedure_date) VALUES
(1, 'Angioplasty', '2025-01-02 11:00:00'),(2, 'Knee Replacement', '2025-01-03 09:00:00'),
(3, 'Emergency Surgery', '2025-01-03 04:00:00'),(4, 'Vaccination', '2025-01-04 10:00:00');

INSERT INTO billing
(admission_id, total_cost, medicine_cost, room_cost, procedure_cost)
VALUES
(1, 120000, 30000, 40000, 50000),(2, 150000, 20000, 50000, 80000),(3, 200000, 50000, 70000, 80000),
(4, 15000, 5000, 8000, 2000),(5, 180000, 60000, 70000, 50000);

INSERT INTO outcomes
(admission_id, outcome_status, readmitted_within_30_days)
VALUES
(1, 'Recovered', FALSE),(2, 'Improved', FALSE),(3, 'Recovered', TRUE),
(4, 'Recovered', FALSE),(5, 'Improved', FALSE);

DROP VIEW IF EXISTS vw_hospital_dashboard_master;

CREATE VIEW vw_hospital_dashboard_master AS
SELECT
    a.admission_id,

    -- Patient details
    p.patient_id,
    p.patient_name,
    p.age,
    p.gender,
    p.insurance_type,

    -- Department & Doctor
    d.department_name,
    doc.doctor_name,
    doc.available_hours,

    -- Admission details
    a.admission_type,
    a.bed_type,
    a.branch_name,
    a.admission_date,
    a.discharge_date,

    -- Length of stay
    CASE 
        WHEN a.discharge_date IS NOT NULL 
        THEN DATEDIFF(a.discharge_date, a.admission_date)
        ELSE NULL
    END AS length_of_stay_days,
    
    -- Occupied beds helper
    CASE  
        WHEN a.discharge_date IS NULL THEN 1
        ELSE 0
    END AS occupied_beds,

    -- Doctor utilization helper
    1 AS patient_count,

    -- Billing
    b.total_cost,
    b.medicine_cost,
    b.room_cost,
    b.procedure_cost,

    -- Outcomes
    o.outcome_status,
    o.readmitted_within_30_days,

    -- Discharge Count
    CASE 
        WHEN a.discharge_date IS NOT NULL THEN 1
        ELSE 0
    END AS discharge_count

FROM admissions a
JOIN patients p ON a.patient_id = p.patient_id
JOIN departments d ON a.department_id = d.department_id
JOIN doctors doc ON a.doctor_id = doc.doctor_id
LEFT JOIN billing b ON a.admission_id = b.admission_id
LEFT JOIN outcomes o ON a.admission_id = o.admission_id;

