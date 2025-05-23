CREATE DATABASE ClinicDB;
USE ClinicDB;

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


INSERT INTO Department VALUES (1, 'Cardiology'), (2, 'Gastroenterology'), (3, 'Dermatology');

INSERT INTO Clinic VALUES 
(1, 'Heart Health', '123 Main St', 1),
(2, 'Gut Care', '456 Oak Ave', 2),
(3, 'Skin Clinic', '789 Pine Rd', 3);

INSERT INTO Doctor VALUES 
(1, 'Dr. Sarah Adams', '5551234567', '12 Elm St', 1),
(2, 'Dr. Ali Khan', '5559876543', '34 Maple St', 2),
(3, 'Dr. Lisa Ray', '5554567890', '56 Birch St', 3);

INSERT INTO Patient VALUES 
(101, 'John Doe', '9991112222', '88 Spruce St', '1980-05-14', 'Teacher'),
(102, 'Fatima Noor', '9992223333', '90 Willow St', '1992-11-02', 'Nurse'),
(103, 'James Lee', '9993334444', '102 Ash St', '1975-01-30', 'Engineer');

INSERT INTO Appointment VALUES 
(1, '2024-06-01', '09:00', '09:30', 120.00, 'Scheduled', 'Fatty liver', 2, 101),
(2, '2023-11-15', '10:00', '10:45', 150.00, 'In Progress', 'Heart arrhythmia', 1, 102),
(3, '2022-05-20', '14:00', '14:30', 90.00, 'Postponed', 'Skin rash', 3, 103),
(4, '2024-01-10', '11:00', '11:30', 130.00, 'Scheduled', 'Fatty liver', 2, 101);



SHOW TABLES;
DESCRIBE Patient;
SELECT * FROM Appointment;



 ## 1. Patients diagnosed with fatty liver in the last year

SELECT Name
FROM Patient
WHERE PatientID IN (
    SELECT PatientID
    FROM Appointment
    WHERE Diagnosis = 'Fatty liver'
      AND Date >= CURRENT_DATE - INTERVAL 1 YEAR
);


## 2. Addresses of cardiology clinics

SELECT C.Address
FROM Clinic C
JOIN Department D ON C.DepartmentID = D.DepartmentID
WHERE D.Name = 'Cardiology';


## 3. Total money paid by patient ID 12527 in the last 3 years

SELECT SUM(Cost) AS TotalPaid
FROM Appointment
WHERE PatientID = 12527
  AND Date >= CURRENT_DATE - INTERVAL 3 YEAR;


## 1. List the names of patients who were diagnosed with “fatty liver” in the last year:
     ## DISTINCT is used to avoid duplicate patient names if they had multiple appointments.

SELECT DISTINCT p.Name
FROM Patient p
JOIN Appointment a ON p.PatientID = a.PatientID
WHERE a.Diagnosis = 'Fatty liver'
  AND a.Date >= CURDATE() - INTERVAL 1 YEAR;

## 2. List the addresses of cardiology clinics:
    ## This pulls clinic addresses that are associated with the “Cardiology” department.

SELECT c.Address
FROM Clinic c
JOIN Department d ON c.DepartmentID = d.DepartmentID
WHERE d.Name = 'Cardiology';


## 3. List the total money paid by a patient whose ID is 101 in the last 3 years:    

SELECT SUM(a.Cost) AS TotalPaid
FROM Appointment a
WHERE a.PatientID = 101
  AND a.Date >= CURDATE() - INTERVAL 3 YEAR;
