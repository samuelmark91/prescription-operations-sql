# Prescription Operations & Data Quality Analysis

I built a SQL Server database and reporting queries to answer a simple question: **How are prescriptions distributed across cities, prescribers, and medications, and can the underlying records be trusted?**

## Results at a glance

| Measure | Result |
| --- | --- |
| Registered patients | 20 |
| Prescription records | 10 |
| Patients with a recorded prescription | 10 |
| Data quality checks | 7 checks, 0 issues reported |

Austin and San Antonio each had five prescriptions. Houston and Dallas each had five registered patients and zero prescriptions in the sample. A `LEFT JOIN` keeps those cities in the report, and `COUNT(r.PrescID)` correctly returns zero for them.

## What I built

- **Relational schema.** Five tables connect patients, doctors, specialties, medications, and prescriptions. Primary and foreign keys enforce those relationships.
- **Sample data loader.** A transaction loads the fictional records and guards against duplicate loads.
- **Reporting queries.** Seven result sets cover prescription volume, patients with no recorded prescriptions, prescriber workload, medication share, and monthly counts. A CTE and `DENSE_RANK()` handle tied medication volumes.
- **Data quality checks.** Seven checks review record links, invalid values, and potential duplicates.

## Run the project

In SQL Server Management Studio, create the database once. If `PrescriptionPortfolio` already exists, skip this step.

```sql
USE master;
GO

CREATE DATABASE PrescriptionPortfolio;
GO
```

Run these scripts in order:

| Step | Script | Purpose |
| --- | --- | --- |
| 1 | [Create schema](sql/01_create_schema.sql) | Creates the `rx_portfolio` schema and five tables |
| 2 | [Load sample data](sql/02_load_sample_data.sql) | Inserts the fictional records |
| 3 | [Run analysis](sql/03_analysis.sql) | Returns seven reporting result sets |
| 4 | [Check data quality](sql/04_data_quality.sql) | Returns seven validation checks |

For a clean rerun, create a new database and update the `USE` statement in all four scripts. The setup expects a fresh schema, and the loader rejects a second load.

## Data and validation

The project uses fictional coursework data and fictional reference values. The prescription records span January 1–10, 2025, so the monthly query demonstrates date grouping. A patient with zero prescriptions has no recorded prescription in this sample.

I ran the setup, load, analysis, and quality checks in SQL Server Management Studio. The saved CSV examples were generated from an equivalent SQLite model. See the [validation notes](VALIDATION.md), [data dictionary](DATA_DICTIONARY.md), and [source notes](SOURCE_NOTES.md) for details.
