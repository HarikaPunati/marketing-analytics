-- ============================================================
-- Marketing Analytics — Data Quality Checks
-- Author: Harika Punati
-- Description: Run these queries manually to validate data
--              after loading CSVs into the platform tables.
-- ============================================================


-- 1. Row count by platform (expect ~110 rows each)
SELECT platform, COUNT(*) AS row_count
FROM public.unified_ads
GROUP BY 1
ORDER BY 1;


-- 2. Date range and total rows
SELECT
  MIN(date)  AS earliest_date,
  MAX(date)  AS latest_date,
  COUNT(*)   AS total_rows
FROM public.unified_ads;


-- 3. Null check on core columns
SELECT
  SUM(CASE WHEN impressions  IS NULL THEN 1 ELSE 0 END) AS missing_impressions,
  SUM(CASE WHEN clicks       IS NULL THEN 1 ELSE 0 END) AS missing_clicks,
  SUM(CASE WHEN cost         IS NULL THEN 1 ELSE 0 END) AS missing_cost,
  SUM(CASE WHEN conversions  IS NULL THEN 1 ELSE 0 END) AS missing_conversions
FROM public.unified_ads;


-- 4. Sanity check derived metrics — spot any zeros or nulls
SELECT
  platform,
  SUM(CASE WHEN ctr IS NULL THEN 1 ELSE 0 END) AS null_ctr,
  SUM(CASE WHEN cpc IS NULL THEN 1 ELSE 0 END) AS null_cpc,
  SUM(CASE WHEN cpa IS NULL THEN 1 ELSE 0 END) AS null_cpa
FROM public.unified_ads
GROUP BY 1;


-- 5. Platform-level performance summary
SELECT
  platform,
  SUM(impressions)                                        AS total_impressions,
  SUM(clicks)                                             AS total_clicks,
  ROUND(SUM(cost), 2)                                     AS total_spend,
  SUM(conversions)                                        AS total_conversions,
  ROUND(AVG(ctr), 4)                                      AS avg_ctr,
  ROUND(AVG(cpc), 2)                                      AS avg_cpc,
  ROUND(AVG(cpm), 2)                                      AS avg_cpm,
  ROUND(AVG(cpa), 2)                                      AS avg_cpa
FROM public.unified_ads
GROUP BY 1
ORDER BY total_spend DESC;

