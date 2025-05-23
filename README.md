# Clinic Management System Database

## 📘 About the Project

This project is a **Clinic Management System** database that helps manage:

- Patients
- Doctors
- Departments and Clinics
- Appointments
- Diagnoses and payments

The goal is to organize clinical operations and support medical staff with appointment scheduling and record keeping.

---

## 🧠 Conceptual Design

The clinic system is divided into **departments**, each containing **clinics**. **Doctors** work in departments and handle **appointments** with **patients**. Each appointment has a diagnosis, time, and cost.

### Main Entities:

- **Department**
- **Clinic**
- **Doctor**
- **Patient**
- **Appointment**

### Relationships:

- A **department** has many **clinics**
- A **department** has many **doctors**
- A **doctor** handles many **appointments**
- A **patient** has many **appointments**

---

## 🧩 UML Design (Text Version)

```
Department (DepartmentID, Name)
    |
    |---< Clinic (ClinicID, Name, Address, DepartmentID)
    |
    |---< Doctor (DoctorID, Name, Phone, Address, DepartmentID)
                  |
                  |---< Appointment (AppointmentID, Date, StartTime, EndTime, Cost, Status, Diagnosis, DoctorID, PatientID)
                                             |
                                             |--- Patient (PatientID, Name, Phone, Address, BirthDate, Job)
```

---

## 🛠️ How to Use

1. Open MySQL or any SQL client.
2. Run the script below step by step:
   - Create the database
   - Create tables
   - Insert sample data
   - Run queries for reports

---

## 🗃️ SQL Code

### 1. Create and Use Database

```sql
CREATE DATABASE ClinicDB;
USE ClinicDB;
```

---

### 2. Create Tables

```sql
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Clinic (
    ClinicID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255),
    BirthDate DATE,
    Job VARCHAR(100)
);

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    Date DATE,
    StartTime TIME,
    EndTime TIME,
    Cost DECIMAL(10, 2),
    Status VARCHAR(20),
    Diagnosis VARCHAR(255),
    DoctorID INT,
    PatientID INT,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
```

---

### 3. Insert Sample Data

```sql
-- Departments
INSERT INTO Department VALUES 
(1, 'Cardiology'), 
(2, 'Gastroenterology'), 
(3, 'Dermatology');

-- Clinics
INSERT INTO Clinic VALUES 
(1, 'Heart Health', '123 Main St', 1),
(2, 'Gut Care', '456 Oak Ave', 2),
(3, 'Skin Clinic', '789 Pine Rd', 3);

-- Doctors
INSERT INTO Doctor VALUES 
(1, 'Dr. Sarah Adams', '5551234567', '12 Elm St', 1),
(2, 'Dr. Ali Khan', '5559876543', '34 Maple St', 2),
(3, 'Dr. Lisa Ray', '5554567890', '56 Birch St', 3);

-- Patients
INSERT INTO Patient VALUES 
(101, 'John Doe', '9991112222', '88 Spruce St', '1980-05-14', 'Teacher'),
(102, 'Fatima Noor', '9992223333', '90 Willow St', '1992-11-02', 'Nurse'),
(103, 'James Lee', '9993334444', '102 Ash St', '1975-01-30', 'Engineer');

-- Appointments
INSERT INTO Appointment VALUES 
(1, '2024-06-01', '09:00', '09:30', 120.00, 'Scheduled', 'Fatty liver', 2, 101),
(2, '2023-11-15', '10:00', '10:45', 150.00, 'In Progress', 'Heart arrhythmia', 1, 102),
(3, '2022-05-20', '14:00', '14:30', 90.00, 'Postponed', 'Skin rash', 3, 103),
(4, '2024-01-10', '11:00', '11:30', 130.00, 'Scheduled', 'Fatty liver', 2, 101);
```

---

## 🔎 Example Queries and Explanations

### 1. Patients Diagnosed with "Fatty Liver" in the Last Year

```sql
SELECT DISTINCT p.Name
FROM Patient p
JOIN Appointment a ON p.PatientID = a.PatientID
WHERE a.Diagnosis = 'Fatty liver'
  AND a.Date >= CURDATE() - INTERVAL 1 YEAR;
```

**Explanation**: This query shows names of patients diagnosed with *fatty liver* within the past year. `DISTINCT` removes duplicates.

---

### 2. Addresses of Cardiology Clinics

```sql
SELECT c.Address
FROM Clinic c
JOIN Department d ON c.DepartmentID = d.DepartmentID
WHERE d.Name = 'Cardiology';
```

**Explanation**: This fetches clinic addresses that belong to the *Cardiology* department.

---

### 3. Total Money Paid by a Specific Patient in the Last 3 Years

```sql
SELECT SUM(a.Cost) AS TotalPaid
FROM Appointment a
WHERE a.PatientID = 101
  AND a.Date >= CURDATE() - INTERVAL 3 YEAR;
```

**Explanation**: Shows total cost paid by patient with ID = 101 over the past 3 years.

---

### 4. View All Tables

```sql
SHOW TABLES;
```

**Explanation**: Lists all tables in the current database.

---

### 5. View Appointment Table Details

```sql
DESCRIBE Appointment;
```

**Explanation**: Shows the structure (columns, types, keys) of the `Appointment` table.

---

### 6. Show All Appointment Records

```sql
SELECT * FROM Appointment;
```

**Explanation**: Returns all records from the `Appointment` table.

---

## 💡 Future Improvements

- Add login system for doctors and admins
- Add billing and payment history tables
- Add prescription and test result tracking
- Export data to CSV for analysis
- Add stored procedures and views for reporting

---

## 🎥 Video Link

https://nileuniversity-my.sharepoint.com/:v:/g/personal/l_yasser2346_nu_edu_eg/Ee7frvNVU_ZHt8bdYXpjshkBoBnjStAVoe8dRV63gjVKOw?e=ul9JEA&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D 

---
## 👤 Author

**Logain Yasser 231001246 **  
**Malak Wagdy 231001578 **  
**Youssef Hatem 231001207 ** 
Database Project — Clinic Management System  
SQL Implementation & Reporting

---
