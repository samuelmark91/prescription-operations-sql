USE PrescriptionPortfolio;
GO

-- SQL Server / T-SQL. Select a disposable portfolio database in SSMS first.
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRY
 BEGIN TRANSACTION;

-- BEGIN CORE
-- SYNTHETIC DATA ONLY. Patients and prescriptions retained from the supplied coursework.
-- Supporting specialties, doctors and medications below are NEW fictional placeholders.
-- Demo medication labels/dosages have no clinical meaning.
INSERT INTO rx_portfolio.Specialty (SpecialtyID, SpecialtyName) VALUES
('S1', 'Demo Specialty A'),
('S2', 'Demo Specialty B'),
('S3', 'Demo Specialty C');
INSERT INTO rx_portfolio.Doctor (DoctorID, DoctorFirstName, DoctorLastName, Specialty) VALUES
('D11', 'Demo', 'Doctor A', 'S1'),
('D22', 'Demo', 'Doctor B', 'S2'),
('D33', 'Demo', 'Doctor C', 'S3');
INSERT INTO rx_portfolio.Medication (MedicationID, MedicationName, Dosage) VALUES
('M11', 'Demo Medication A', 'Not applicable - demo'),
('M22', 'Demo Medication B', 'Not applicable - demo'),
('M33', 'Demo Medication C', 'Not applicable - demo');
INSERT INTO rx_portfolio.Patient (PatientID, PatientFN, PatientLN, PatientWeightLb, Address, City, State, ZipCode, Phone) VALUES
('P101', 'John', 'Doe', 180, '123 Main St', 'San Antonio', 'TX', '78201', '956-555-1001'),
('P102', 'Jane', 'Smith', 150, '456 Elm St', 'San Antonio', 'TX', '78202', '956-555-1002'),
('P103', 'Michael', 'Brown', 200, '789 Oak St', 'San Antonio', 'TX', '78203', '956-555-1003'),
('P104', 'Emily', 'Clark', 120, '321 Pine St', 'San Antonio', 'TX', '78204', '956-555-1004'),
('P105', 'David', 'Johnson', 210, '654 Cedar St', 'San Antonio', 'TX', '78205', '956-555-1005'),
('P106', 'Anna', 'Taylor', 140, '111 Congress Ave', 'Austin', 'TX', '78701', '512-555-2001'),
('P107', 'Mark', 'Davis', 170, '222 6th St', 'Austin', 'TX', '78702', '512-555-2002'),
('P108', 'Laura', 'Evans', 160, '333 Barton Blvd', 'Austin', 'TX', '78703', '512-555-2003'),
('P109', 'James', 'Wilson', 190, '444 South St', 'Austin', 'TX', '78704', '512-555-2004'),
('P110', 'Susan', 'Martinez', 130, '555 North St', 'Austin', 'TX', '78705', '512-555-2005'),
('P111', 'Chris', 'Harris', 200, '111 Heights Blvd', 'Houston', 'TX', '77001', '713-555-3001'),
('P112', 'Jessica', 'Adams', 125, '222 Rice St', 'Houston', 'TX', '77002', '713-555-3002'),
('P113', 'Brian', 'Walker', 220, '333 Bayou St', 'Houston', 'TX', '77003', '713-555-3003'),
('P114', 'Rachel', 'Young', 180, '444 Space Center Blvd', 'Houston', 'TX', '77004', '713-555-3004'),
('P115', 'Kevin', 'Hall', 170, '555 Galleria Blvd', 'Houston', 'TX', '77005', '713-555-3005'),
('P116', 'Karen', 'Allen', 160, '111 Victory Ave', 'Dallas', 'TX', '75201', '214-555-4001'),
('P117', 'Robert', 'Thomas', 185, '222 Deep Ellum St', 'Dallas', 'TX', '75202', '214-555-4002'),
('P118', 'Lisa', 'Garcia', 145, '333 Reunion Blvd', 'Dallas', 'TX', '75203', '214-555-4003'),
('P119', 'William', 'Lopez', 195, '444 Main St', 'Dallas', 'TX', '75204', '214-555-4004'),
('P120', 'Megan', 'Hernandez', 170, '555 Maple Ave', 'Dallas', 'TX', '75205', '214-555-4005');
-- Preserve original patient links, even where the original city comments were wrong.
INSERT INTO rx_portfolio.Prescription (PrescID, Patient, Doctor, PrescDate, Medication, PrescQty) VALUES
('RX43', 'P101', 'D11', '2025-01-01', 'M11', 12),
('RX44', 'P102', 'D22', '2025-01-02', 'M22', 18),
('RX45', 'P103', 'D33', '2025-01-03', 'M33', 22),
('RX46', 'P104', 'D11', '2025-01-04', 'M11', 14),
('RX47', 'P105', 'D22', '2025-01-05', 'M22', 10),
('RX48', 'P106', 'D33', '2025-01-06', 'M33', 16),
('RX49', 'P107', 'D11', '2025-01-07', 'M11', 20),
('RX50', 'P108', 'D22', '2025-01-08', 'M22', 25),
('RX51', 'P109', 'D33', '2025-01-09', 'M33', 30),
('RX52', 'P110', 'D11', '2025-01-10', 'M11', 18);

-- END CORE
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
 IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
 THROW;
END CATCH;
