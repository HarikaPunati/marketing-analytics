-- ============================================================
-- Marketing Analytics — Multi-Platform Ad Performance
-- Author: Harika Punati
-- Description: Creates platform tables and a unified view
--              combining Facebook, Google, and TikTok ad data
--              with derived performance metrics.
-- ============================================================


-- ------------------------------------------------------------
-- SECTION 1: Table Definitions
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.facebook_ads (
  date               DATE,
  campaign_id        TEXT,
  campaign_name      TEXT,
  ad_set_id          TEXT,
  ad_set_name        TEXT,
  impressions        BIGINT,
  clicks             BIGINT,
  spend              NUMERIC,
  conversions        BIGINT,
  video_views        BIGINT,
  engagement_rate    NUMERIC,
  reach              BIGINT,
  frequency          NUMERIC
);

CREATE TABLE IF NOT EXISTS public.google_ads (
  date                      DATE,
  campaign_id               TEXT,
  campaign_name             TEXT,
  ad_group_id               TEXT,
  ad_group_name             TEXT,
  impressions               BIGINT,
  clicks                    BIGINT,
  cost                      NUMERIC,
  conversions               BIGINT,
  conversion_value          NUMERIC,
  ctr                       NUMERIC,
  avg_cpc                   NUMERIC,
  quality_score             INTEGER,
  search_impression_share   NUMERIC
);

CREATE TABLE IF NOT EXISTS public.tiktok_ads (
  date              DATE,
  campaign_id       TEXT,
  campaign_name     TEXT,
  adgroup_id        TEXT,
  adgroup_name      TEXT,
  impressions       BIGINT,
  clicks            BIGINT,
  cost              NUMERIC,
  conversions       BIGINT,
  video_views       BIGINT,
  video_watch_25    BIGINT,
  video_watch_50    BIGINT,
  video_watch_75    BIGINT,
  video_watch_100   BIGINT,
  likes             BIGINT,
  shares            BIGINT,
  comments          BIGINT
);


-- ------------------------------------------------------------
-- SECTION 2: Unified View
--
-- Normalizes column names across all three platforms and
-- computes derived metrics: CTR, CPC, CPM, CVR, CPA.
--
-- Note: Platform-specific columns (e.g. Facebook engagement_rate,
-- Google quality_score, TikTok video completion rates) are
-- intentionally excluded from this unified view to maintain a
-- consistent cross-platform schema. Query the raw tables directly
-- for platform-specific analysis.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW public.unified_ads AS

WITH base AS (

  -- Facebook
  SELECT
    date,
    'facebook'              AS platform,
    campaign_id,
    campaign_name,
    ad_set_id               AS ad_group_id,
    ad_set_name             AS ad_group_name,
    impressions,
    clicks,
    spend                   AS cost,
    conversions
  FROM public.facebook_ads

  UNION ALL

  -- Google
  SELECT
    date,
    'google'                AS platform,
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    impressions,
    clicks,
    cost,
    conversions
  FROM public.google_ads

  UNION ALL

  -- TikTok
  SELECT
    date,
    'tiktok'                AS platform,
    campaign_id,
    campaign_name,
    adgroup_id              AS ad_group_id,
    adgroup_name            AS ad_group_name,
    impressions,
    clicks,
    cost,
    conversions
  FROM public.tiktok_ads

)

SELECT
  date,
  platform,
  campaign_id,
  campaign_name,
  ad_group_id,
  ad_group_name,
  impressions,
  clicks,
  cost,
  conversions,

  -- Derived metrics
  -- NULLIF(..., 0) prevents divide-by-zero errors
  ROUND(clicks::NUMERIC / NULLIF(impressions, 0), 4)          AS ctr,
  ROUND(cost / NULLIF(clicks, 0), 2)                          AS cpc,
  ROUND((cost / NULLIF(impressions, 0)) * 1000, 2)            AS cpm,
  ROUND(conversions::NUMERIC / NULLIF(clicks, 0), 4)          AS cvr,
  ROUND(cost / NULLIF(conversions, 0), 2)                     AS cpa

FROM base;
