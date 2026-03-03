# Marketing Analytics — Multi-Platform Ad Performance

A end-to-end marketing analytics project that consolidates ad performance data from Facebook, Google, and TikTok into a single unified view using PostgreSQL, then visualizes key metrics in Tableau.

---

## Project Overview

Paid media data lives in silos. Each platform exports different schemas, uses different terminology, and tracks different metrics. This project solves that by building a unified data layer in SQL that normalizes all three platforms into one consistent structure — making cross-channel analysis straightforward.

---

## Tools & Technologies

| Layer | Tool |
|---|---|
| Data Storage & Querying | PostgreSQL |
| Data Transformation | SQL (Views, UNION ALL) |
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
- Builds a unified view (`unified_ads`) combining all three platforms via `UNION ALL`
- Runs data quality checks: null counts, date range validation, row count by platform

### Unified View Schema

```sql
date | platform | campaign_id | campaign_name | ad_group_id | ad_group_name | impressions | clicks | cost | conversions
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

## Project Structure

```
marketing-analytics/
│
├── 01_facebook_ads.csv
├── 02_google_ads.csv
├── 03_tiktok_ads.csv
├── Unified_ads.csv
├── Marketing_project.sql
├── Marketing_Analytics_Tableau.twbx
└── README.md
```

---

## Author

**Harika Punati**  
Data Analyst | SQL · Python · Power BI · Tableau  
[LinkedIn](https://www.linkedin.com/in/harikapunati/) · [GitHub](https://github.com/HarikaPunati)
