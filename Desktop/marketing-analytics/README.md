# Marketing Analytics — Multi-Platform Ad Performance

An end-to-end marketing analytics project that consolidates ad performance data from Facebook, Google, and TikTok into a single unified view using PostgreSQL, then visualizes key metrics in Tableau.

---

## Project Overview

Paid media data lives in silos. Each platform exports different schemas, uses different terminology, and tracks different metrics. This project solves that by building a unified data layer in SQL that normalizes all three platforms into one consistent structure — making cross-channel analysis straightforward.

---

## Dataset

- Date range: January 1–30, 2024
- 330 total rows across 3 platforms (110 rows each)
- 12 campaigns total (4 per platform)
- No missing values across any column

---

## Tools & Technologies

| Layer | Tool |
|---|---|
| Data Storage & Querying | PostgreSQL |
| Data Transformation | SQL (Views, CTEs, UNION ALL) |
| Visualization | Tableau |
| Data Sources | Facebook Ads, Google Ads, TikTok Ads |

---

## Data Sources

| Platform | File | Key Fields |
|---|---|---|
| Facebook Ads | `01_facebook_ads.csv` | impressions, clicks, spend, conversions, video_views, engagement_rate, reach, frequency |
| Google Ads | `02_google_ads.csv` | impressions, clicks, cost, conversions, conversion_value, CTR, avg_CPC, quality_score |
| TikTok Ads | `03_tiktok_ads.csv` | impressions, clicks, cost, conversions, video_views, video completion rates (25/50/75/100%), likes, shares, comments |

---

## What the SQL Does

- Creates platform-specific tables for Facebook, Google, and TikTok
- Normalizes column names across platforms (e.g., `spend` → `cost`, `ad_set_id` → `ad_group_id`)
- Uses a CTE to build a clean base layer via `UNION ALL`, then computes derived metrics on top
- Computes derived metrics directly in the view: CTR, CPC, CPM, CVR, CPA — using `NULLIF` to prevent divide-by-zero errors
- Platform-specific columns are intentionally excluded from the unified view to maintain a consistent cross-platform schema — query the raw tables directly for platform-specific analysis:
  - **Facebook:** `engagement_rate`, `reach`, `frequency`
  - **Google:** `quality_score`, `conversion_value`, `search_impression_share`
  - **TikTok:** video completion rates (25/50/75/100%), `likes`, `shares`, `comments`
- Separate QC script (`Marketing_qc_checks.sql`) validates row counts, date ranges, null checks, and derived metric integrity after loading

### Unified View Schema

```sql
date | platform | campaign_id | campaign_name | ad_group_id | ad_group_name | impressions | clicks | cost | conversions | ctr | cpc | cpm | cvr | cpa
```

---

## Tableau Dashboard

The Tableau workbook (`Marketing_Analytics_Tableau.twbx`) connects to the unified dataset and visualizes:

- Spend, impressions, clicks, and conversions by platform
- CTR and CPC trends over time
- Campaign-level performance breakdown
- Cross-platform comparison

---

## Key Metrics Tracked

- **CTR** (Click-Through Rate) = Clicks / Impressions
- **CPC** (Cost Per Click) = Cost / Clicks
- **CPM** (Cost Per Mille) = (Cost / Impressions) × 1000
- **CVR** (Conversion Rate) = Conversions / Clicks
- **CPA** (Cost Per Acquisition) = Cost / Conversions

---

## Key Findings

- Facebook had the lowest CPA at $7.64 despite the smallest budget ($18K), making it the most cost-efficient platform for conversions
- TikTok drove the highest volume (28M impressions, 461K clicks) at the cheapest CPC ($0.16) but had the worst CPA at $11.00
- Google sat in the middle on all metrics — higher spend ($37K) with consistent conversion volume (4,218 conversions) and a CPA of $8.93
- Across all platforms, CTR was consistent (~1.6–2.0%), suggesting click quality rather than reach was the key differentiator in conversion efficiency

---

## Project Structure

```
marketing-analytics/
│
├── 01_facebook_ads.csv
├── 02_google_ads.csv
├── 03_tiktok_ads.csv
├── Unified_ads.csv
├── Marketing_project.sql
├── Marketing_qc_checks.sql
├── Marketing_Analytics_Tableau.twbx
└── README.md
```

---

**Harika Punati**  
Data Analyst | SQL · Python · Power BI · Tableau  
[LinkedIn](https://www.linkedin.com/in/harikapunati/) · [GitHub](https://github.com/HarikaPunati)
