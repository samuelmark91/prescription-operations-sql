USE PrescriptionPortfolio;
GO
-- Read-only checks. Expect zero for this fixture.
-- Possible duplicate events are candidates for review, not proven duplicates.
SELECT 'Orphan prescription relationships' AS CheckName, (SELECT COUNT(*) FROM rx_portfolio.Prescription AS r
 LEFT JOIN rx_portfolio.Patient AS p ON p.PatientID = r.Patient
 LEFT JOIN rx_portfolio.Doctor AS d ON d.DoctorID = r.Doctor
 LEFT JOIN rx_portfolio.Medication AS m ON m.MedicationID = r.Medication
 WHERE p.PatientID IS NULL OR d.DoctorID IS NULL OR m.MedicationID IS NULL) AS IssueCount
UNION ALL
SELECT 'Doctors missing specialties' AS CheckName, (SELECT COUNT(*) FROM rx_portfolio.Doctor AS d
 LEFT JOIN rx_portfolio.Specialty AS s ON s.SpecialtyID = d.Specialty
 WHERE s.SpecialtyID IS NULL) AS IssueCount
UNION ALL
SELECT 'Invalid quantities' AS CheckName, (SELECT COUNT(*) FROM rx_portfolio.Prescription WHERE PrescQty <= 0) AS IssueCount
UNION ALL
SELECT 'Invalid weights' AS CheckName, (SELECT COUNT(*) FROM rx_portfolio.Patient WHERE PatientWeightLb <= 0) AS IssueCount
UNION ALL
SELECT 'Blank city values' AS CheckName, (SELECT COUNT(*) FROM rx_portfolio.Patient WHERE LTRIM(RTRIM(City)) = '') AS IssueCount
UNION ALL
SELECT 'Duplicate prescription identifiers' AS CheckName, (SELECT COUNT(*) FROM (
 SELECT PrescID FROM rx_portfolio.Prescription GROUP BY PrescID HAVING COUNT(*) > 1
 ) AS DuplicateIDs) AS IssueCount
UNION ALL
SELECT 'Possible duplicate prescription events - review only' AS CheckName, (SELECT COUNT(*) FROM (
 SELECT Patient, Doctor, PrescDate, Medication FROM rx_portfolio.Prescription
 GROUP BY Patient, Doctor, PrescDate, Medication HAVING COUNT(*) > 1
 ) AS PossibleDuplicates) AS IssueCount;
