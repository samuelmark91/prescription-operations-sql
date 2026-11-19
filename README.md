# Prescription Operations & Data Quality Analysis

A SQL Server portfolio project developed from a fictional coursework database. It models five related tables, audits the data, and answers operational questions using joins, aggregations, a CTE and window functions.

**Status:** setup, sample loading and analysis executed by the project owner in SQL Server Management Studio on November 13, 2026; all seven quality checks reported zero issues. Final packaging edits were reviewed locally. See [VALIDATION.md](VALIDATION.md).

## Questions

- Which cities have registered patients with recorded prescriptions?
- How is prescription workload distributed across doctors and specialties?
- What share of prescription records belongs to each medication?
- Which patients have no prescription record in the supplied sample?
- Are all records linked correctly, and are any values invalid or potentially duplicated?

## Run in SQL Server Management Studio

Create the project database once in SQL Server Management Studio:

```sql
USE master;
GO
CREATE DATABASE PrescriptionPortfolio;
GO
```

If you already created `PrescriptionPortfolio` for this project, skip database creation. Every project script explicitly selects that database. To use a different database, change the `USE` statement in all four scripts.

Open and execute these files in order:

1. `sql/01_create_schema.sql` — creates a new `rx_portfolio` schema and five related tables. Refuses to reuse an existing schema; no DROP or DELETE statements.
2. `sql/02_load_sample_data.sql` — loads the fictional sample once, in a transaction.
3. `sql/03_analysis.sql` — returns seven analysis result sets.
4. `sql/04_data_quality.sql` — returns seven quality checks.

For a fresh run, use another empty portfolio database and update each script's `USE` statement. The loader deliberately rejects duplicate inserts. Database creation is left to the user; no existing database or coursework tables are overwritten. Schema/table creation requires appropriate database permissions.

## Findings in this sample

- **20 registered patients, 10 prescriptions and 10 patients with a prescription.** The other ten patients have no prescription record in this extract; this does not imply unmet need or missing treatment.
- **San Antonio and Austin each have five prescriptions.** Houston and Dallas each have five registered patients and zero prescriptions in the supplied extract. LEFT JOIN preserves those zero-count cities.
- **D11 has four prescriptions; D22 and D33 have three each.** Medication counts show the same 4/3/3 pattern because the small fictional fixture always pairs each doctor with the same medication. No prescribing-preference inference is supported.
- **All prescriptions fall between January 1 and January 10, 2025.** The monthly query demonstrates date grouping, but this dataset cannot support trend or seasonality conclusions.

## What changed from the coursework files

- Consolidated three identical patient scripts and overlapping recovery versions.
- Aligned PatientID and Prescription.Patient as text to support IDs such as `P101`.
- Created Specialty before Doctor, then parent tables before Prescription.
- Converted weight strings to numeric pounds with an explicit unit in the column name.
- Added fictional reference rows for the existing D11/D22/D33 and M11/M22/M33 IDs; their original names/specialties/dosages were not supplied. All added values are demo placeholders.
- Preserved all original prescription links. Incorrect city comments were corrected in the documentation, not by changing patient assignments.
- Added named constraints, transaction handling and analytical/quality queries.

## Data provenance and limitations

The user confirmed the original records are fictional class-assignment data. There are no new generated patient or prescription observations. Added supporting tables are synthetic placeholders, not recovered source data. This is a small educational demonstration, not clinical research. It has no cost, payment, refill or outcome fields, so it cannot support financial or clinical performance claims.

See [SOURCE_NOTES.md](SOURCE_NOTES.md), [DATA_DICTIONARY.md](DATA_DICTIONARY.md), and [VALIDATION.md](VALIDATION.md). The CSV outputs were generated from an equivalent SQLite model, not SQL Server.

## Portfolio walkthrough

Explain why a LEFT JOIN is needed to retain zero-prescription cities, why COUNT(r.PrescID) differs from COUNT(*) in that join, how primary/foreign keys prevent broken relationships, and what DENSE_RANK does for the tied medication counts. The owner checked the analysis in SQL Server during the walkthrough. Review the query logic and expected outputs so you can explain the results in an interview.

## SQL reference

- [Microsoft: CREATE TABLE](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-table-transact-sql)
- [Microsoft: Create foreign key relationships](https://learn.microsoft.com/en-us/sql/relational-databases/tables/create-foreign-key-relationships)
