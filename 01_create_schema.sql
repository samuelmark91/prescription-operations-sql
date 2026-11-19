USE PrescriptionPortfolio;
GO

-- SQL Server / T-SQL. Select a disposable portfolio database in SSMS first.
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRY
 BEGIN TRANSACTION;
IF SCHEMA_ID('rx_portfolio') IS NOT NULL
 THROW 50001, 'rx_portfolio already exists. Do not rerun setup; use another empty portfolio database for a fresh copy.', 1;
EXEC('CREATE SCHEMA rx_portfolio');
-- BEGIN CORE
CREATE TABLE rx_portfolio.Specialty (
 SpecialtyID CHAR(2) NOT NULL CONSTRAINT PK_RxSpecialty PRIMARY KEY,
 SpecialtyName VARCHAR(50) NOT NULL
);
CREATE TABLE rx_portfolio.Doctor (
 DoctorID CHAR(3) NOT NULL CONSTRAINT PK_RxDoctor PRIMARY KEY,
 DoctorFirstName VARCHAR(25) NOT NULL,
 DoctorLastName VARCHAR(35) NOT NULL,
 Specialty CHAR(2) NOT NULL,
 CONSTRAINT FK_RxDoctor_Specialty FOREIGN KEY (Specialty)
  REFERENCES rx_portfolio.Specialty(SpecialtyID)
);
CREATE TABLE rx_portfolio.Patient (
 PatientID VARCHAR(10) NOT NULL CONSTRAINT PK_RxPatient PRIMARY KEY,
 PatientFN VARCHAR(25) NOT NULL,
 PatientLN VARCHAR(35) NOT NULL,
 PatientWeightLb DECIMAL(5,1) NOT NULL,
 Address VARCHAR(255) NOT NULL,
 City VARCHAR(25) NOT NULL,
 State CHAR(2) NOT NULL,
 ZipCode CHAR(5) NOT NULL,
 Phone VARCHAR(20) NULL,
 CONSTRAINT CK_RxPatient_Weight CHECK (PatientWeightLb > 0)
);
CREATE TABLE rx_portfolio.Medication (
 MedicationID CHAR(3) NOT NULL CONSTRAINT PK_RxMedication PRIMARY KEY,
 MedicationName VARCHAR(50) NOT NULL,
 Dosage VARCHAR(30) NOT NULL
);
CREATE TABLE rx_portfolio.Prescription (
 PrescID VARCHAR(10) NOT NULL CONSTRAINT PK_RxPrescription PRIMARY KEY,
 Patient VARCHAR(10) NOT NULL,
 Doctor CHAR(3) NOT NULL,
 PrescDate DATE NOT NULL,
 Medication CHAR(3) NOT NULL,
 PrescQty INT NOT NULL,
 CONSTRAINT FK_RxPrescription_Patient FOREIGN KEY (Patient)
  REFERENCES rx_portfolio.Patient(PatientID),
 CONSTRAINT FK_RxPrescription_Doctor FOREIGN KEY (Doctor)
  REFERENCES rx_portfolio.Doctor(DoctorID),
 CONSTRAINT FK_RxPrescription_Medication FOREIGN KEY (Medication)
  REFERENCES rx_portfolio.Medication(MedicationID),
 CONSTRAINT CK_RxPrescription_Quantity CHECK (PrescQty > 0)
);
-- END CORE
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
 IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
 THROW;
END CATCH;
