USE master
GO

/****** Object:  Database AP     ******/
IF DB_ID('DRHealthCareCenter') IS NOT NULL
	DROP DATABASE DRHealthCareCenter
GO

CREATE DATABASE DRHealthCareCenter
GO 

USE DRHealthCareCenter
GO

CREATE TABLE PatientRooms(
	RoomNumber int PRIMARY KEY IDENTITY (1,1),
	PatientID int not null,
	DepartmentID int not null,
	MedicalDevicesID int not null,
	Capacity int not NULL,
	IsOccupied varchar(5) NULL,
	DateLastOccupied datetime NULL

	)
GO

CREATE TABLE Departments(
	DepartmentID int PRIMARY KEY IDENTITY (1,1),
	CostsID int not null,
	DepartmentName varchar(20) not null,
	NumberOfEmployees int not null
)

GO

CREATE TABLE MedicalDevices(
	MedicalDevicesID int PRIMARY KEY IDENTITY (1,1),
	HeartRateMonitor varchar(3) not null DEFAULT 'YES',
	Scale varchar(3) not null DEFAULT 'YES',
	IV varchar(3) not null DEFAULT 'YES',
	Stethoscope varchar(3) not null DEFAULT 'YES',
	FirstAidKit varchar(3) not null DEFAULT 'YES',
	XRayMachine varchar(3) not null DEFAULT 'YES'
	)

GO





/****** Object:  Table Visitors  ******/   
CREATE TABLE Visitors(
	VisitorID int PRIMARY KEY IDENTITY(1,1)  NOT NULL,
	PatientID int not null,
	FullName varchar(50) NOT NULL,
	TimeVisited datetime NOT NULL,
	TimeLeftCenter datetime NOT NULL
)
GO

/****** Object:  Table InsuranceCoverages     ******/
CREATE TABLE InsuranceCoverages(
	InsuranceID int Primary key IDENTITY(1,1) NOT NULL,
	InsuranceCompanyName varchar(50) NOT NULL,
	PhoneNumber varchar(15) NULL,
	Address varchar(100) NULL,
	MedicationCoverage money NOT NULL,
	ProcedureCoverage money NOT NULL
)
GO

/****** Object:  Table PatientHealthHistory    ******/
CREATE TABLE PatientHealthHistory(
	PatientHealthReportID int PRIMARY KEY IDENTITY(1,1) not NULL,
	PatientID int not null,
	WeightInPounds int null,
	HeightInFeet varchar(5) null,
	HeartRateInBPM int null,
	BloodPressure int null,
	ReportedSymptoms varchar(100) null,
	PatientProcedures varchar(60) null,
	Prescriptions varchar(50) null,
	LastSeenPhysician varchar(30) null,
	DateLastUpdated datetime null
) 
GO







/****** Object:  Table Billing     ******/
CREATE TABLE Billing(
	BillingID int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	PatientCostID int not null,
	InsuranceID int FOREIGN KEY REFERENCES InsuranceCoverages(InsuranceID),
	Visits int null,
	Payor varchar(50) null,
	PaymentMethod varchar(15) null,
	LastBilledAmount money  null,
	LastBilledDate datetime null,
	LastPaymentAmount money null

 ) 

GO

/****** Object:  Table PatientCosts     ******/
CREATE TABLE PatientCosts(
	PatientCostID int Primary KEY IDENTITY(1,1) NOT NULL,
	CostsID int not null,
	HasOTCMedication varchar(5) null DEFAULT 'NO',
	HasPrescription varchar(5) null DEFAULT 'NO',
	HadGeneralProcedure varchar(5) null DEFAULT 'NO',
	HadComplexProcedure varchar(5) null DEFAULT 'NO',
	HadRoom varchar(5) null DEFAULT 'NO',
	TotalCost money null,

)
GO

/****** Object:  Table HospitalCosts    ******/
CREATE TABLE HospitalCosts(
	CostsID int Primary KEY IDENTITY(1,1) not null,
	DepartmentID int FOREIGN KEY REFERENCES Departments(DepartmentID),
	OTCMedication money not null,
	PrescriptionMedication money not null,
	GeneralProcedure money not null,
	ComplexProcedure money not null,
	RoomPrice money not null
) 
GO






/******Object : Table Patients *******/
CREATE TABLE Patients(
	PatientID int PRIMARY KEY IDENTITY(1,1),
	RoomNumber int FOREIGN KEY REFERENCES PatientRooms(RoomNumber),
	PatientCostID int FOREIGN KEY REFERENCES PatientCosts(PatientCostID),
	BillingID int FOREIGN KEY REFERENCES Billing(BillingID),
	InsuranceID int FOREIGN KEY REFERENCES InsuranceCoverages(InsuranceID),
	VisitorID int FOREIGN KEY REFERENCES Visitors(VisitorID),
	PatientHealthReportID int FOREIGN KEY REFERENCES PatientHealthHistory(PatientHealthReportID),
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	SSN varchar(11) not null,
	DateOfBirth date not null,
	PatientAddress varchar(50) not null,
	Phone varchar(15) not null,
	EmailAddress varchar(30) null,
	PrimaryCareDoctor varchar(30) null,
	EmergencyContact varchar(30) not null,
	EmergencyContactNumber varchar(15) not null,
	InsuranceName varchar(50) not null,
	DateRegistered datetime not null

)

GO

CREATE TABLE Employees(
	EmployeeID int Primary KEY IDENTITY(1,1) not null,
	DepartmentID int FOREIGN KEY REFERENCES Departments(DepartmentID),
	JobTitle varchar(20) not null,
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	SSN varchar(11) not null,
	Phone varchar(15) not null,
	EmailAddress varchar(30) not null,
	DateOfBirth date not null
	)
GO








ALTER TABLE Patients
ADD CONSTRAINT FK_RoomNumber
FOREIGN KEY (RoomNumber) REFERENCES PatientRooms(RoomNumber);

GO

ALTER TABLE Patients
ADD CONSTRAINT FK_PatientCost
FOREIGN KEY (PatientCostID) REFERENCES PatientCosts(PatientCostID);

GO

ALTER TABLE Patients
ADD CONSTRAINT FK_Billing
FOREIGN KEY (BillingID) REFERENCES Billing(BillingID);

GO

ALTER TABLE Patients
ADD CONSTRAINT FK_Insurance
FOREIGN KEY (InsuranceID) REFERENCES InsuranceCoverages(InsuranceID);

GO

ALTER TABLE Patients
ADD CONSTRAINT FK_Visitor
FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID);

GO

ALTER TABLE Patients
ADD CONSTRAINT FK_PatientHealthReport
FOREIGN KEY (PatientHealthReportID) REFERENCES PatientHealthHistory(PatientHealthReportID);

GO








ALTER TABLE PatientHealthHistory
ADD CONSTRAINT FK_PatientID1
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID);

GO

ALTER TABLE Visitors
ADD CONSTRAINT FK_PatientID2
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID);

GO

ALTER TABLE Billing
ADD CONSTRAINT FK_PatientCostBilling
FOREIGN KEY (PatientCostID) REFERENCES PatientCosts(PatientCostID);

GO

ALTER TABLE Billing
ADD CONSTRAINT FK_PatientInsuranceBilling
FOREIGN KEY (InsuranceID) REFERENCES InsuranceCoverages(InsuranceID);

GO

ALTER TABLE PatientCosts
ADD CONSTRAINT FK_HospitalCost
FOREIGN KEY (CostsID) REFERENCES HospitalCosts(CostsID);

GO

ALTER TABLE HospitalCosts
ADD CONSTRAINT FK_DepartmentCost
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

GO





ALTER TABLE PatientRooms
ADD CONSTRAINT FK_PatientRoom
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID);

GO

ALTER TABLE PatientRooms
ADD CONSTRAINT FK_PatientDepartment
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

GO

ALTER TABLE PatientRooms
ADD CONSTRAINT FK_MedicalDevicesRoom
FOREIGN KEY (MedicalDevicesID) REFERENCES MedicalDevices(MedicalDevicesID);

GO

ALTER TABLE Departments
ADD CONSTRAINT FK_CostDepartment
FOREIGN KEY (CostsID) REFERENCES HospitalCosts(CostsID);

GO

ALTER TABLE Employees
ADD CONSTRAINT FK_EmployeeDepartment
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

GO