# Source audit

User-confirmed fictional coursework inputs. Original uploads were not modified.

| Input | Role |
|---|---|
| Week_2_Query.sql | Original five-table definition |
| Original-Jan-31-2025-0154PM.SQLQuery7.sql | Canonical 20-patient and 10-prescription seed source |
| SQLQuery7.sql | 20-patient seed, identical to the two files below |
| SQL Query.sql | Duplicate patient seed |
| Recovered-Jan-31-2025-0154PM.SQLQuery7.sql | Duplicate patient seed |
| Recovered-Jan-31-2025-0154PM.~vs4207.sql | Overlapping 10-prescription seed and exploratory SELECTs |

The original prescription comments conflict with patient cities: P104/P105 are San Antonio, not Austin; P106/P107 are Austin, not Houston; P108/P109/P110 are Austin, not Dallas. The original patient IDs are retained. Houston and Dallas have no supplied prescription rows.

## Original input hashes (SHA-256)

- `Original-Jan-31-2025-0154PM.SQLQuery7.sql`: `91284d02fae7849db89551dfa555940df4150bc798beb907b6de66db8cc72f4a`
- `Recovered-Jan-31-2025-0154PM.SQLQuery7.sql`: `3a70c3093c0e5da29bd02ca837755ed6e18c993c49fe99a159cc3370478873eb`
- `Recovered-Jan-31-2025-0154PM.~vs4207.sql`: `acef4799710b93b84018b63885eb92971eefa22dad18a9ef90ffaf0ead4049ca`
- `SQL Query.sql`: `3a70c3093c0e5da29bd02ca837755ed6e18c993c49fe99a159cc3370478873eb`
- `SQLQuery7.sql`: `3a70c3093c0e5da29bd02ca837755ed6e18c993c49fe99a159cc3370478873eb`
- `Week_2_Query.sql`: `9e9e1faf6eea0e2a32de1fb60587dce5ebf22268cc31b6646fc88a4443f19ef6`

## Final scripts reviewed

The owner supplied saved copies of `01_create_schema.sql`, `02_load_sample_data.sql`, `03_analysis.sql` and `04_data_quality.sql` after the SQL Server walkthrough. Database context and percentage formatting edits were retained. The appended duplicate no-prescription query was removed from the packaged analysis. Original uploaded copies were left unchanged.
