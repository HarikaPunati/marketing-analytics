# Marketing Analytics — Cross-Platform Ad Performance

Consolidates ad data from Facebook, Google, and TikTok into a unified PostgreSQL view and visualizes performance in Tableau.

---

## Stack

- PostgreSQL, SQL (CTEs, UNION ALL, Views)
- Tableau

---

## Files

| File | Description |
|------|-------------|
| `01_facebook_ads.csv` | Raw Facebook Ads data |
| `02_google_ads.csv` | Raw Google Ads data |
| `03_tiktok_ads.csv` | Raw TikTok Ads data |
| `Unified_ads.csv` | Merged output across all platforms |
| `Marketing project.sql` | Table creation, normalization, unified view |
| `Marketing_qc_checks.sql` | Row counts, null checks, metric validation |
| `Marketing Analytics Tableau.twbx` | Tableau workbook |

---

## How to Run

1. Load each CSV into PostgreSQL as its platform table (`facebook_ads`, `google_ads`, `tiktok_ads`)
2. Run `Marketing project.sql` to normalize columns and create the unified view
3. Run `Marketing_qc_checks.sql` to validate row counts, nulls, date ranges, and metric integrity
4. Connect Tableau to the unified view or open `Marketing Analytics Tableau.twbx`

---

## Unified View Schema

```
date | platform | campaign_id | campaign_name | ad_group_id | ad_group_name
impressions | clicks | cost | conversions | ctr | cpc | cpm | cvr | cpa
```

Derived metrics (CTR, CPC, CPM, CVR, CPA) are computed in the view with `NULLIF` guards for divide-by-zero safety.

---

## Dataset

- 330 rows — 110 per platform
- 12 campaigns, Jan 1–30 2024
- No nulls

---

## Key Findings

| Platform | Spend | Impressions | Clicks | Conversions | CPA |
|----------|-------|-------------|--------|-------------|-----|
| Facebook | $18K | — | — | — | $7.64 |
| Google | $37K | — | — | 4,218 | $8.93 |
| TikTok | — | 28M | 461K | — | $11.00 |

- **Facebook** — lowest CPA ($7.64) on the smallest budget; most cost-efficient
- **TikTok** — highest volume (28M impressions, 461K clicks), cheapest CPC ($0.16), worst CPA ($11.00)
- **Google** — middle ground across all metrics
- CTR was consistent across platforms (~1.6–2.0%); conversion quality, not reach, drove CPA differences

---

Harika Punati — Data Analyst | SQL · Python · Power BI · Tableau