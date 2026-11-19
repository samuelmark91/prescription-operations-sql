# Validation record

## SQL Server walkthrough — November 13, 2026

The project owner executed the scripts in SQL Server Management Studio against `PrescriptionPortfolio`. Supplied screenshots show SQL Server major version 15.x. This was an owner-operated walkthrough; no direct SQL Server connection was available to the reviewer.

| Check | Evidence / result |
|---|---|
| Five tables created in rx_portfolio | Confirmed by supplied schema/table-list screenshot |
| Sample loaded | Screenshot confirms 20 patients and 10 prescriptions |
| Seven data-quality checks | Owner confirmed all issue counts were zero |
| City coverage | Owner confirmed expected result; full-analysis screenshot shows four cities with prescription counts 5, 5, 0, 0 |
| Doctor workload | Screenshot confirms D11=4, D22=3, D33=3; distinct patients equal those counts |
| Medication counts, shares and ranks | Owner confirmed; screenshot shows counts 4/3/3, shares 40/30/30 and ranks 1/2/2 |
| Overview | Screenshot confirms 20 patients, 10 prescriptions, 10 distinct patients and 185 units; January 1–10, 2025 |
| Monthly grouping | Screenshot confirms January 2025 with 10 prescriptions and 10 patients |
| Patients without prescription records | Owner confirmed ten rows; full-analysis screenshot partially displays that result |
| Joined prescription detail | Included in the successful full-file run; ten rows expected. A separate complete result export was not supplied |
| Percentage display after DECIMAL cast | Owner confirmed rerun after formatting change |

## Final packaging review

The four saved scripts were supplied by the owner and compared with the original package. The final review removed a duplicate copy of the no-prescription query appended to `03_analysis.sql`. It added the same explicit `USE PrescriptionPortfolio` context to the schema script that was already present in the other three scripts. These final packaging edits were not separately rerun on SQL Server by the reviewer.

## Local relational checks

An equivalent SQLite model used the same CREATE TABLE and INSERT core with schema prefixes removed. YEAR and MONTH were registered as local date functions. All seven analysis queries and all seven quality checks were rerun using the final package. Patient and prescription records were reconciled to the supplied seed source. Negative checks rejected duplicate specialty IDs, orphan patient references, zero quantities and zero weights.

The CSV outputs in `results/` are generated from this local equivalent model, not exported from SQL Server. Decimal display precision may differ. SQL Server-specific transaction handling, schema guards and rollback behavior have not been tested through a live reviewer connection. Repeated-load/schema refusal and negative constraint tests have not been confirmed on SQL Server.
