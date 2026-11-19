USE PrescriptionPortfolio;
GO
-- Read-only analysis. Run after scripts 01 and 02.

-- 01_overview
-- How many patients and prescriptions are in the sample?
SELECT
 (SELECT COUNT(*) FROM rx_portfolio.Patient) AS Patients,
 COUNT(*) AS Prescriptions,
 COUNT(DISTINCT Patient) AS PatientsWithPrescriptions,
 SUM(PrescQty) AS TotalRecordedUnits,
 MIN(PrescDate) AS FirstPrescriptionDate,
 MAX(PrescDate) AS LastPrescriptionDate
FROM rx_portfolio.Prescription;

-- 02_city_coverage
-- Which cities have patients with recorded prescriptions? Include cities with none.
SELECT p.City,
 COUNT(DISTINCT p.PatientID) AS RegisteredPatients,
 COUNT(DISTINCT r.Patient) AS PatientsWithPrescriptions,
 COUNT(r.PrescID) AS PrescriptionCount,
 COALESCE(SUM(r.PrescQty), 0) AS RecordedUnits
FROM rx_portfolio.Patient AS p
LEFT JOIN rx_portfolio.Prescription AS r ON r.Patient = p.PatientID
GROUP BY p.City
ORDER BY PrescriptionCount DESC, p.City;

-- 03_doctor_workload
-- How many prescriptions and distinct patients are assigned to each doctor?
SELECT d.DoctorID, d.DoctorFirstName, d.DoctorLastName, s.SpecialtyName,
 COUNT(r.PrescID) AS PrescriptionCount,
 COUNT(DISTINCT r.Patient) AS DistinctPatients
FROM rx_portfolio.Doctor AS d
JOIN rx_portfolio.Specialty AS s ON s.SpecialtyID = d.Specialty
LEFT JOIN rx_portfolio.Prescription AS r ON r.Doctor = d.DoctorID
GROUP BY d.DoctorID, d.DoctorFirstName, d.DoctorLastName, s.SpecialtyName
ORDER BY PrescriptionCount DESC, d.DoctorID;

-- 04_medication_mix
-- What is each medication's share of prescription records?
WITH MedicationCounts AS (
 SELECT m.MedicationID, m.MedicationName, COUNT(r.PrescID) AS PrescriptionCount
 FROM rx_portfolio.Medication AS m
 LEFT JOIN rx_portfolio.Prescription AS r ON r.Medication = m.MedicationID
 GROUP BY m.MedicationID, m.MedicationName
)
SELECT MedicationID, MedicationName, PrescriptionCount,
 CAST(
    100.0 * PrescriptionCount
    / NULLIF(SUM(PrescriptionCount) OVER (), 0)
    AS DECIMAL(5,1)
) AS PrescriptionSharePct,
 DENSE_RANK() OVER (ORDER BY PrescriptionCount DESC) AS VolumeRank
FROM MedicationCounts
ORDER BY PrescriptionCount DESC, MedicationID;

-- 05_monthly_volume
-- How can prescription volume be grouped by calendar month?
SELECT YEAR(PrescDate) AS PrescriptionYear,
 MONTH(PrescDate) AS PrescriptionMonth,
 COUNT(*) AS PrescriptionCount,
 COUNT(DISTINCT Patient) AS DistinctPatients
FROM rx_portfolio.Prescription
GROUP BY YEAR(PrescDate), MONTH(PrescDate)
ORDER BY PrescriptionYear, PrescriptionMonth;

-- 06_no_recorded_prescriptions
-- Which registered patients have no prescription record in this sample?
SELECT p.PatientID, p.City
FROM rx_portfolio.Patient AS p
WHERE NOT EXISTS (
 SELECT 1 FROM rx_portfolio.Prescription AS r WHERE r.Patient = p.PatientID
)
ORDER BY p.City, p.PatientID;

-- 07_prescription_detail
-- Can each prescription be traced through all five related tables?
SELECT r.PrescID, r.PrescDate, p.PatientID, p.City,
 d.DoctorID, s.SpecialtyName, m.MedicationName, r.PrescQty
FROM rx_portfolio.Prescription AS r
JOIN rx_portfolio.Patient AS p ON p.PatientID = r.Patient
JOIN rx_portfolio.Doctor AS d ON d.DoctorID = r.Doctor
JOIN rx_portfolio.Specialty AS s ON s.SpecialtyID = d.Specialty
JOIN rx_portfolio.Medication AS m ON m.MedicationID = r.Medication
ORDER BY r.PrescDate, r.PrescID;
