-- Step 1. Create the database
-- Step 2. Design and Build the Schema

-- Creating the patients table.
CREATE TABLE patients(
	patient_id SERIAL PRIMARY KEY,
	first_name VARCHAR (30) NOT NULL,
	last_name VARCHAR (30) NOT NULL,
	dob DATE NOT NULL,
	gender VARCHAR (5) CHECK (gender IN ('M','F')),
	email VARCHAR (50) UNIQUE
);
-- Creating the departments table.
CREATE TABLE departments(
	department_name VARCHAR (50) UNIQUE PRIMARY KEY,
	location VARCHAR (20)
);

-- Creating the doctors table.
CREATE TABLE doctors(
	doctor_id SERIAL PRIMARY KEY,
	first_name VARCHAR (30) NOT NULL,
	last_name VARCHAR (30) NOT NULL,
	specialty VARCHAR (30) CHECK (specialty IN ('Pediatrics', 'Cardiology', 'Oncology',
	'Neurology', 'General Practice', 'Orthopedics', 'Dermatology', 'Radiology',
	'Endocrinology', 'Emergency Medicine')),
	email VARCHAR (50) UNIQUE,
	department VARCHAR (30),
	FOREIGN KEY (department) REFERENCES departments(department_name)
);

-- Creating the appointments table.
CREATE TABLE appointments(
	appointment_id SERIAL PRIMARY KEY,
	patient_id INT REFERENCES patients (patient_id),
	doctor_id INT REFERENCES doctors (doctor_id),
	appointment_date DATE,
	reason VARCHAR (50)
	
);

-- Creating the treatments table.
CREATE TABLE treatments(
	treatment_id SERIAL PRIMARY KEY,
	appointment_id INT REFERENCES appointments (appointment_id),
	treatment_description VARCHAR (60),
	cost DECIMAL (7,2) CHECK (cost > 0)
);

-- Creating the medications table.
CREATE TABLE medications(
	treatment_id INT PRIMARY KEY,
	medication_name VARCHAR (50) NOT NULL,
	dosage VARCHAR (30) NOT NULL,
	FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);

-- Creating the billing table.
CREATE TABLE billing(
	appointment_id INT PRIMARY KEY,
	total_amount DECIMAL (7,2),
	paid_status BOOLEAN DEFAULT FALSE,
	FOREIGN KEY (appointment_id) REFERENCES appointments (appointment_id)
);

-- Step 3. Insert Sample data
-- Inserting sample data into the departments table.
INSERT INTO departments (department_name, location) VALUES 
('Pediatrics', 'Wing A'),
('Cardiology', 'Wing B'),
('Oncology', 'Wing C'),
('Neurology', 'Wing D'),
('General Practice', 'Wing A'),
('Orthopedics', 'Wing E'),
('Dermatology', 'Wing F'),
('Radiology', 'Wing G'),
('Endocrinology', 'Wing H'),
('Emergency', 'Wing I');

-- Inserting sample data into the patients table.
INSERT INTO patients (first_name, last_name, dob, gender, email) VALUES 
('Ava', 'Mitchell', '1990-04-22', 'F', 'ava.mitchell@hospital.org'),
('Liam', 'Carter', '1985-09-13', 'M', 'liam.carter@hospital.org'),
('Olivia', 'Thompson', '1998-02-10', 'F', 'olivia.t@hospital.org'),
('Noah', 'Bennett', '1978-11-05', 'M', 'noah.b@hospital.org'),
('Emma', 'Jenkins', '1995-01-19', 'F', 'emma.j@hospital.org'),
('Ethan', 'Reed', '1982-06-08', 'M', 'ethan.r@hospital.org'),
('Sophia', 'Lopez', '1993-03-27', 'F', 'sophia.lopez@hospital.org'),
('Mason', 'Turner', '1988-12-12', 'M', 'mason.turner@hospital.org'),
('Isabella', 'Gray', '1999-08-02', 'F', 'isabella.gray@hospital.org'),
('Lucas', 'Nguyen', '1975-07-30', 'M', 'lucas.nguyen@hospital.org');


-- Inserting sample data into the doctors table.
INSERT INTO doctors (first_name, last_name, specialty, email, department) VALUES 
('Sarah', 'King', 'Pediatrics', 's.king@hospital.org', 'Pediatrics'),
('Ethan', 'Reed', 'Cardiology', 'e.reed@hospital.org', 'Cardiology'),
('Maya', 'Patel', 'Oncology', 'm.patel@hospital.org', 'Oncology'),
('James', 'Wu', 'Neurology', 'j.wu@hospital.org', 'Neurology'),
('Emma', 'Brooks', 'General Practice', 'e.brooks@hospital.org', 'General Practice'),
('David', 'Allen', 'Orthopedics', 'd.allen@hospital.org', 'Orthopedics'),
('Rachel', 'Kim', 'Dermatology', 'r.kim@hospital.org', 'Dermatology'),
('Carlos', 'Martinez', 'Radiology', 'c.martinez@hospital.org', 'Radiology'),
('Priya', 'Singh', 'Endocrinology', 'p.singh@hospital.org', 'Endocrinology'),
('Henry', 'Parker', 'Emergency Medicine', 'h.parker@hospital.org', 'Emergency');


-- Inserting sample data into the appointments table.
INSERT INTO appointments (patient_id, doctor_id, appointment_date, reason) VALUES 
(1, 2, '2025-10-01', 'Annual Checkup'),
(2, 3, '2025-10-02', 'Chest Pain'),
(3, 4, '2025-10-03', 'Migraine'),
(4, 1, '2025-10-04', 'Pediatric Visit'),
(5, 5, '2025-10-05', 'Routine Exam'),
(6, 6, '2025-10-06', 'Knee Pain'),
(7, 7, '2025-10-07', 'Skin Rash'),
(8, 8, '2025-10-08', 'MRI Review'),
(9, 9, '2025-10-09', 'Thyroid Follow-up'),
(10, 10, '2025-10-10', 'ER Visit');

-- Inserting sample data into the treatments table.
INSERT INTO treatments (appointment_id, treatment_description) VALUES 
(1, 'Blood Pressure Check'),
(2, 'EKG and Consultation'),
(3, 'MRI Scan'),
(4, 'Vaccination'),
(5, 'Physical Exam'),
(6, 'X-Ray'),
(7, 'Dermatology Exam'),
(8, 'CT Scan'),
(9, 'Hormone Test'),
(10, 'Emergency Stabilization');

-- Populating the cost column to match total_amount from the billing table.
UPDATE treatments t
SET cost = b.total_amount
FROM billing b
WHERE t.appointment_id = b.appointment_id;

-- Inserting sample data into the medications table.
INSERT INTO medications (treatment_id, medication_name, dosage) VALUES 
(1, 'Aspirin', '100mg'),
(2, 'Atenolol', '50mg'),
(3, 'Ibuprofen', '200mg'),
(4, 'Tylenol', '500mg'),
(5, 'Vitamin D', '1000 IU'),
(6, 'Amoxicillin', '500mg'),
(7, 'Cortisone Cream', 'Apply 2x daily'),
(8, 'Metformin', '500mg'),
(9, 'Levothyroxine', '75mcg'),
(10, 'Epinephrine', '0.3mg');


-- Inserting sample data into the billing table.
INSERT INTO billing (appointment_id, total_amount, paid_status) VALUES 
(1, 150, True),
(2, 325, True),
(3, 500, False),
(4, 75, True),
(5, 200, False),
(6, 250, True),
(7, 180, True),
(8, 400, False),
(9, 220, True),
(10, 600, False);

-- Checking the patients table.
SELECT * FROM patients;

-- Checking the doctors table.
SELECT * FROM doctors;

-- Checking the departments table.
SELECT * FROM departments;

-- Checking the appointments table.
SELECT * FROM appointments; 

--Checking the treatments table.
SELECT * FROM treatments;

-- Checking the medications table.
SELECT * FROM medications; 

--Checking the billing table.
SELECT * FROM billing;

-- Step 4. Modify the Schema
-- Modifying the schema - Adding a column to the patients table.
ALTER TABLE patients
ADD COLUMN insurance_provider VARCHAR (20) DEFAULT 'BCBS MS';

-- Checking the patients table.
SELECT * FROM patients;

-- Modifying the schema - Renaming a column in the appointments table.
ALTER TABLE appointments
RENAME COLUMN reason to visit_reason;

-- Checking the appointments table.
SELECT * FROM appointments; 

-- Modifying the schema - Changing the column's data type in the billing table.
ALTER TABLE billing
ALTER COLUMN total_amount TYPE NUMERIC(7,2);

-- Checking the billing table.
SELECT * FROM billing;

--Modifying the schema - Adding a CHECK constraint to the treatments table.
ALTER TABLE treatments
ADD CONSTRAINT cost CHECK (cost > 0);

-- Checking the treatments table.
SELECT * FROM treatments;

-- Modifying the schema - Dropping and recreating the medications table and adding a new column to the table.
DROP TABLE IF EXISTS medications;

-- Checking for the medications table.
SELECT * FROM medications; -- returns an error

-- Recreating the medications table with a new column.
CREATE TABLE medications(
	treatment_id INT PRIMARY KEY,
	medication_name VARCHAR (50) NOT NULL,
	dosage VARCHAR (30) NOT NULL,
	medication_given BOOLEAN DEFAULT FALSE,
	FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);

-- Repopulating the medications table.
INSERT INTO medications (treatment_id, medication_name, dosage) VALUES 
(1, 'Aspirin', '100mg'),
(2, 'Atenolol', '50mg'),
(3, 'Ibuprofen', '200mg'),
(4, 'Tylenol', '500mg'),
(5, 'Vitamin D', '1000 IU'),
(6, 'Amoxicillin', '500mg'),
(7, 'Cortisone Cream', 'Apply 2x daily'),
(8, 'Metformin', '500mg'),
(9, 'Levothyroxine', '75mcg'),
(10, 'Epinephrine', '0.3mg');

-- Step 5. Writing 10 analytical queries
-- 1. INNER JOIN - Combine data from patients, doctors, and appointments to display complete appointment records.
SELECT p.first_name||' '||p.last_name AS "Patient Name", d.first_name||' '||d.last_name AS "Doctor",
	   a.appointment_date, a.visit_reason
FROM patients AS p
INNER JOIN appointments AS a ON a.patient_id = p.patient_id
INNER JOIN doctors AS d ON d.doctor_id = a.doctor_id
ORDER BY p.patient_id;

-- 2. LEFT JOIN - Display all patients and their appointments, including those who haven’t scheduled any.
-- Inserting a patient without an appointment.
INSERT INTO patients (first_name, last_name, dob, gender, email) VALUES 
('Celeste', 'Collins', '1983-07-25', 'F', 'celeste.collsins@hospital.org');

-- Checking the patients table.
SELECT * FROM patients;

-- Performing the LEFT JOIN
SELECT p.first_name||' '||p.last_name AS "Patient Name", d.first_name||' '||d.last_name AS "Doctor",
	   a.appointment_date, a.visit_reason
FROM patients AS p
LEFT JOIN appointments AS a ON a.patient_id = p.patient_id
LEFT JOIN doctors AS d ON d.doctor_id = a.doctor_id
ORDER BY p.patient_id;

-- 3. RIGHT JOIN - Display all doctors and the patients they’ve seen, including doctors with no appointments.
-- Inserting a doctor without no appointments.
INSERT INTO doctors (first_name, last_name, specialty, email, department) VALUES 
('Jeremy', 'Johnson', 'Cardiology', 'J.Johnson@hospital.org', 'Cardiology');

-- Checking the doctors table.
SELECT * FROM doctors;

-- Performing the RIGHT JOIN
SELECT p.first_name||' '||p.last_name AS "Patient Name", d.first_name||' '||d.last_name AS "Doctor",
	   a.appointment_date, a.visit_reason
FROM patients AS p
RIGHT JOIN appointments AS a ON a.patient_id = p.patient_id
RIGHT JOIN doctors AS d ON d.doctor_id = a.doctor_id
ORDER BY p.patient_id;

-- 4. GROUP BY with Aggregate - Count total appointments per doctor.
SELECT d.first_name||' '||d.last_name AS "Doctor",
	   COUNT (appointment_id) AS total_appointments
FROM appointments AS a
RIGHT JOIN doctors AS d
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id;

-- 5. HAVING - Identify doctors with more than two appointments.
SELECT d.first_name||' '||d.last_name AS "Doctor",
	   COUNT (appointment_id) AS total_appointments
FROM appointments AS a
JOIN doctors AS d
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id
HAVING COUNT(appointment_id) > 2; -- Returns an empty table as no doctors have more than one appointment.

-- 6. Subquery (single Row) - Display the patient with the earliest appointment.
SELECT p.first_name||' '||p.last_name AS "Patient Name", d.first_name||' '||d.last_name AS "Doctor",
	   a.appointment_date AS earliest_appointment, a.visit_reason
FROM patients AS p
INNER JOIN appointments AS a ON a.patient_id = p.patient_id
INNER JOIN doctors AS d ON d.doctor_id = a.doctor_id
WHERE a.appointment_date = (SELECT MIN(appointment_date) FROM appointments);

-- 7. Subquery (multi-row) - List all patients who have been prescribed a specific medication (e.g., Ibuprofen).
SELECT p.first_name||' '||p.last_name AS "Patient Name", m.medication_name
FROM patients AS p
JOIN appointments AS a ON p.patient_id = a.patient_id
JOIN treatments AS t ON t.appointment_id = a.appointment_id
JOIN medications AS m ON m.treatment_id = t.treatment_id
WHERE m.medication_name IN (
	SELECT medication_name 
	FROM medications AS h
	WHERE h.medication_name = 'Tylenol' OR h.medication_name = 'Ibuprofen'
);

-- 8. EXISTS - Find patients who have received at least one treatment.
SELECT p.first_name || ' ' || p.last_name AS "Patient Name"
FROM patients AS p
WHERE EXISTS (
    SELECT 1 
    FROM appointments AS a
    JOIN treatments AS t ON t.appointment_id = a.appointment_id
    WHERE a.patient_id = p.patient_id
);

-- 9. Nested Query - Display all appointments for patients younger than the average age.
-- Adding an age column to the patients table
ALTER TABLE patients
ADD COLUMN patient_age INT;

-- Populating the age column
UPDATE patients
SET patient_age = EXTRACT (YEAR FROM AGE(dob));

-- Checking the patients table.
SELECT * FROM patients;

-- Displaying all appointments for patients younger than the average age.
SELECT p.first_name||' '||p.last_name AS "Patient Name", d.first_name||' '||d.last_name AS "Doctor",
	   a.appointment_date, a.visit_reason, p.patient_age
FROM patients AS p
JOIN appointments AS a ON a.patient_id = p.patient_id
JOIN doctors AS d ON d.doctor_id = a.doctor_id
WHERE p.patient_age < (SELECT AVG(patient_age) FROM patients);

-- 10. Window Function - Rank doctors by the total number of appointments (PostgreSQL-only feature).
SELECT "Doctor Name",
       total_appointments,
      RANK() OVER (ORDER BY total_appointments DESC) AS appointment_rank
FROM (SELECT d.first_name || ' ' || d.last_name AS "Doctor Name",
      COUNT(a.appointment_id) AS total_appointments
      FROM doctors AS d
      LEFT JOIN appointments AS a ON d.doctor_id = a.doctor_id
      GROUP BY d.doctor_id, d.first_name, d.last_name) AS doctor_counts;

-- Step 6. Manage Schema Cleanup
-- Drop the departments table and recreate it.
DROP TABLE departments CASCADE;

-- Checking for the departments table.
SELECT * FROM deparments; -- returns an error

-- Checking for the remaining tables to verify that dependent tables 
-- responded correctly to cascading drop.
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'; -- returns list of 6 remaining tables

-- Recreating the departments table.
CREATE TABLE departments(
	department_name VARCHAR (50) UNIQUE PRIMARY KEY,
	location VARCHAR (20)
);

-- Repopulating the departments table.
INSERT INTO departments (department_name, location) VALUES 
('Pediatrics', 'Wing A'),
('Cardiology', 'Wing B'),
('Oncology', 'Wing C'),
('Neurology', 'Wing D'),
('General Practice', 'Wing A'),
('Orthopedics', 'Wing E'),
('Dermatology', 'Wing F'),
('Radiology', 'Wing G'),
('Endocrinology', 'Wing H'),
('Emergency', 'Wing I');

-- Checking for the departments table.
SELECT * FROM departments;

-- Use DROP TABLE IF EXISTS to remove optional tables without causing errors.
DROP TABLE IF EXISTS medications; -- succussfully removed

-- Checking for the medications table.
SELECT * FROM medications; -- returns an error

-- Recreating the medications table.
CREATE TABLE medications(
	treatment_id INT PRIMARY KEY,
	medication_name VARCHAR (50) NOT NULL,
	dosage VARCHAR (30) NOT NULL,
	FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);

-- Repopulating the medications table.
INSERT INTO medications (treatment_id, medication_name, dosage) VALUES 
(1, 'Aspirin', '100mg'),
(2, 'Atenolol', '50mg'),
(3, 'Ibuprofen', '200mg'),
(4, 'Tylenol', '500mg'),
(5, 'Vitamin D', '1000 IU'),
(6, 'Amoxicillin', '500mg'),
(7, 'Cortisone Cream', 'Apply 2x daily'),
(8, 'Metformin', '500mg'),
(9, 'Levothyroxine', '75mcg'),
(10, 'Epinephrine', '0.3mg');

-- Checking for the medications table.
SELECT * FROM medications; -- returns populated table

-- Step 7. Reflect and Conclude
-- 1. How does your database design reflect principles of organization and integrity?
	--This database reflects principles of organization and integrity through normalization
	--by keeping key patient information stored in separate tables.  It also does not contain 
	--duplicate information, such as patient name, in multiple tables.  This normalized structure
	--allows for UPDATEs, INSERTs, and DELETEs without causing anomalies in the database, while each table
	--has its own UNIQUE PRIMARY KEY.  
-- 2. What constraints were most important in ensuring data quality?
	--The most important constraints ensuring data quality in this database include using NOT NULL
	--for multiple attributes including: patient_id, first and last names, and dob, among others.  
	--The CHECK constraint was important in the gender designation column, maintaining that only an 'M' or 'F'
	--would be allowed in that column.  The DEFAULT constraint was also used to set a FALSE setting for the 
	--paid status in the billing table.  PRIMARY KEYs and FOREIGN KEYs were extremely important in keeping
	--the structure and therefore quality of the database by establishing the ability to reference tables 
	--in the database and keep records from being orphaned. 
-- 3. How can Christian ethics guide professionals who work with sensitive healthcare data (e.g., privacy,
	--stewardship, truthfulness, and care for others)?
	--Christian ethics of privacy, stewardship, truthfulness, and care for others can guide professionals who work
	--with sensitive healthcare data.  Respect for patients' privacy is inherent in HIPAA regulations.  
	--Christian professionals must practice good stewardship of this sensitive healthcare data by only accessing
	--and utilizing that data in service to the health of the patient.  Truthfulness and care for others
	--can also guide Christians to maintain accurate records that reflect the patient's truth while showing care
	--for the patients.