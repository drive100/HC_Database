--Testing 

USE DRHealthCareCenter

GO

INSERT HospitalCosts(OTCMedication,PrescriptionMedication,GeneralProcedure,ComplexProcedure,RoomPrice) VALUES
	(10,10,15,30,100),
	(15,20,25,50,200),
	(20,50,20,150,300),
	(10,20,40,100,100),
	(30,60,50,150,300)

GO

SELECT * FROM HospitalCosts;


INSERT Departments(CostsID, DepartmentName, NumberOfEmployees) VALUES
	(1,'Pediatrics', 10),
	(2,'Neurology', 6),
	(3,'Gastroenterology',10),
	(4,'Orthopaedics',15),
	(5, 'Urology',20)

GO

Update HospitalCosts
SET DepartmentID = CostsID
WHERE DepartmentID IS NULL

GO

INSERT MedicalDevices(HeartRateMonitor,Scale,IV,Stethoscope,FirstAidKit,XRayMachine) VALUES
	('YES', 'YES', 'NO', 'YES','YES','NO'),
	('YES', 'YES', 'YES', 'YES','NO','YES'),
	('YES', 'YES', 'NO', 'NO','YES','YES'),
	('YES', 'YES', 'YES', 'YES','YES','NO'),
	('NO', 'YES', 'YES', 'YES','YES','YES')

GO





INSERT Employees(DepartmentID, JobTitle, FirstName, LastName, SSN, Phone, EmailAddress, DateOfBirth) VALUES
	(5,'Urologist', 'Steven', 'Hefner', '100-10-2323', '914-121-2323','shefner@gmail.com', '1970-12-17'),
	(3,'Gastrologist', 'Tito', 'Guillen', '113-45-6723', '915-361-5623','tguillen@mail.com', '1980-11-17'),
	(1,'Pedatric Specialist', 'Amanda', 'Fenty', '050-76-8983', '315-451-2763','fentyamanda@gmail.com', '1995-05-03'),
	(2,'Neurologist', 'Michael', 'Hook', '078-34-8327', '917-313-1189','michael.hook@yahoo.com', '1975-01-11'),
	(4,'Orthopaedic Doctor', 'Lin', 'Huang', '112-56-8080', '345-341-7893','lhuang23@gmail.com', '1980-06-23')

GO

INSERT InsuranceCoverages(InsuranceCompanyName, PhoneNumber, Address, MedicationCoverage, ProcedureCoverage) VALUES
	('BlueCross BlueShield', '1-800-323-4455','1 Mount Pl, Ottowa NY 13102', 200, 500),
	('Aetna', '1-800-555-3535','56 Seymour Dr, Pittsburgh PA 00102', 500, 700),
	('Humana', '1-800-333-3412','122 New St, Lake Worth FL 10102', 500, 1200),
	('UnitedHealthOne', '1-800-777-6758','989 Memory Pl, Newark NJ 11102', 250, 1000),
	('THE IHC GROUP', '1-800-565-8855','77 Mountain Dr., Chicago IL 13102', 200, 1000)

GO

INSERT INTO PatientCosts(CostsID)
	SELECT CostsID FROM HospitalCosts

GO

INSERT Patients(FirstName, LastName, SSN, DateOfBirth,PatientAddress,Phone,EmailAddress,PrimaryCareDoctor,EmergencyContact,EmergencyContactNumber,InsuranceName,DateRegistered) VALUES
	('Mike','Cowicki','101-01-2322','1997-11-23','601 Comstock Ave, Syracuse NY 13210', '914-112-3902',NULL,NULL,'Margret Cowicki', '914-112-6049','Aetna','2010-01-23'),
	('Steven','Heeman','112-81-5526','1990-01-13','201 Euclid Ave, Syracuse NY 13210', '917-445-1243',NULL,NULL,'Bob Heeman', '914-445-7748','BlueCross BlueShield','2013-07-31'),
	('Mary','Zone','051-77-3387','1996-04-22','106 12th st, NY, NY 10013', '917-212-5435',NULL,NULL,'Scott Welty', '917-343-6649','Humana','2015-04-03'),
	('Scott','Hua','040-54-3266','1989-02-23','1 Boston Post Rd, Mamaroneck NY 10543', '914-345-7202',NULL,NULL,'Wendy Hua', '914-342-8349','UnitedHealthOne','2011-12-23'),
	('Jason','Oh','131-63-8682','1993-03-01','10 Larchmont Ave, White Plains NY 10538', '914-882-0461',NULL,NULL,'Mina Oh', '914-922-6790','THE IHC GROUP','2005-11-13')

GO

INSERT Visitors(PatientID, FullName, TimeVisited, TimeLeftCenter) VALUES

	(3, 'Margret Cho', CONVERT(datetime, '2017-08-25 10:12:50'), CONVERT(datetime,'2017-08-25 12:12:00')),
	(2, 'Billy Cohen', CONVERT(datetime,'2018-04-12 12:22:10'), CONVERT(datetime,'2018-04-12 13:02:00')),
	(1, 'Jill Valentine', CONVERT(datetime,'2018-01-15 09:02:40'), CONVERT(datetime,'2018-01-15 9:42:00')),
	(5, 'Rebecca Chambers', CONVERT(datetime,'2017-12-05 12:00:50'), CONVERT(datetime,'2017-12-06 11:42:00')),
	(4, 'Chris Redfield', CONVERT(datetime,'2018-05-1 07:01:15'), CONVERT(datetime,'2018-05-1 08:12:50'))
GO




Update Patients 
SET VisitorID = p.VisitorID FROM Visitors p WHERE Patients.PatientID = p.PatientID;

GO

Update Patients
SET InsuranceID = p.InsuranceID FROM InsuranceCoverages p WHERE Patients.InsuranceName = p.InsuranceCompanyName;

GO

Update Patients
SET PatientCostID = PatientID 

GO

INSERT PatientRooms(PatientID, DepartmentID, MedicalDevicesID, Capacity,IsOccupied,DateLastOccupied) VALUES
	(1, 2, 1, 2, 'YES', '2018-05-07'),
	(2, 5, 2, 5,'YES', '2017-10-27'),		
	(4, 1, 3, 3,'YES', '2018-05-07'),
	(5, 3, 4, 1, 'YES', '2018-04-21'),
	(3, 4, 5, 1, 'YES', '2018-03-30')

GO

Update Patients
SET RoomNumber = p.RoomNumber FROM PatientRooms p WHERE Patients.PatientID = p.PatientID;

GO

INSERT PatientCosts(CostsID) VALUES
	(1),(2),(3),(4),(5)

GO

Update PatientCosts 
SET HasOTCMedication = 'YES' WHERE PatientCostID % 2 = 1;

GO





Update PatientCosts
SET HasPrescription = 'YES' WHERE PatientCostID % 2 = 0;

GO

Update PatientCosts
SET HadGeneralProcedure = 'YES' WHERE PatientCostID > 2 AND PatientCostID <= 4;

GO

Update PatientCosts
SET HadComplexProcedure = 'YES' WHERE PatientCostID = 5;

GO

Update PatientCosts
SET HadRoom = 'YES'

GO

INSERT Billing(PatientCostID,Visits,Payor,PaymentMethod,LastBilledAmount,LastBilledDate,LastPaymentAmount) VALUES
	(1,1,'Patient','Credit Card',200, '2017-05-12', 200),
	(2,3,'Patient',NULL,300, '2018-02-14', NULL),
	(3,2,'Patient',NULL,750, '2018-03-02', NULL),
	(4,4,'Patient','Check', 500, '2018-05-01', 500),
	(5,1,'Insurance','Insurance',1000, '2018-01-01', 1000)

GO

Update Billing
SET InsuranceID = p.InsuranceID FROM Patients p WHERE Billing.PatientCostID = p.PatientCostID;

GO

INSERT PatientHealthHistory(PatientID, WeightInPounds,HeightInFeet,HeartRateInBPM,BloodPressure,ReportedSymptoms,PatientProcedures, Prescriptions,LastSeenPhysician,DateLastUpdated) Values
	(1,160,'5.9',80,75,'Dizzyness, Headache','General Checkup',NULL, 'Michael Hook', '2017-01-12'),
	(2,140,'6.0',80,75,'blood in urine','Prostate Exam',NULL, 'Steven Hefner', '2018-02-13'),
	(3,100,'5.5',80,75,'Feet hurt when walking','General Checkup', NULL, 'Lin Huang', '2018-02-12'),
	(4,170,'6.2',80,75,'None, Needed annual checkup for school','General Checkup',NULL, 'Amanda Fenty', '2018-05-01'),
	(5,200,'5.10',80,75,'Stomach pains, cant keep food down','Endoscopy',NULL, 'Tito Guillen', '2018-01-01')

GO

Update Patients
SET PatientHealthReportID = PatientID;

GO

Update Patients
SET BillingID = p.BillingID FROM Billing p WHERE Patients.PatientCostID = p.PatientCostID

GO
