-- Facebook

create table if not exists public.facebook_ads (
  date date,
  campaign_id text,
  campaign_name text,
  ad_set_id text,
  ad_set_name text,
  impressions bigint,
  clicks bigint,
  spend numeric,
  conversions bigint,
  video_views bigint,
  engagement_rate numeric,
  reach bigint,
  frequency numeric
);

-- Google

create table if not exists public.google_ads (
  date date,
  campaign_id text,
  campaign_name text,
  ad_group_id text,
  ad_group_name text,
  impressions bigint,
  clicks bigint,
  cost numeric,
  conversions bigint,
  conversion_value numeric,
  ctr numeric,
  avg_cpc numeric,
  quality_score integer,
  search_impression_share numeric
);

-- TikTok

create table if not exists public.tiktok_ads (
  date date,
  campaign_id text,
  campaign_name text,
  adgroup_id text,
  adgroup_name text,
  impressions bigint,
  clicks bigint,
  cost numeric,
  conversions bigint,
  video_views bigint,
  video_watch_25 bigint,
  video_watch_50 bigint,
  video_watch_75 bigint,
  video_watch_100 bigint,
  likes bigint,
  shares bigint,
  comments bigint
);


select * from facebook_ads;

create or replace view public.unified_ads as

-- Facebook
select
    date,
    'facebook' as platform,
    campaign_id,
    campaign_name,
    ad_set_id as ad_group_id,
    ad_set_name as ad_group_name,
    impressions,
    clicks,
    spend as cost,
    conversions
from public.facebook_ads

union all

-- Google
select
    date,
    'google',
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    impressions,
    clicks,
    cost,
    conversions
from public.google_ads

union all

-- TikTok
select
    date,
    'tiktok',
    campaign_id,
    campaign_name,
    adgroup_id as ad_group_id,
    adgroup_name as ad_group_name,
    impressions,
    clicks,
    cost,
    conversions
from public.tiktok_ads;




select platform, count(*)
from public.unified_ads
group by 1;

select min(date), max(date), count(*) 
from public.unified_ads;

select
  sum(case when impressions is null then 1 else 0 end) as missing_impressions,
  sum(case when clicks is null then 1 else 0 end) as missing_clicks,
  sum(case when cost is null then 1 else 0 end) as missing_cost,
  sum(case when conversions is null then 1 else 0 end) as missing_conversions
from public.unified_ads;







select table_type
from information_schema.tables
where table_schema = 'public'
and table_name = 'unified_ads';


drop table public.unified_ads;


create or replace view public.unified_ads as

select
    date,
    'facebook' as platform,
    campaign_id,
    campaign_name,
    ad_set_id as ad_group_id,
    ad_set_name as ad_group_name,
    impressions,
    clicks,
    spend as cost,
    conversions
from public.facebook_ads

union all

select
    date,
    'google',
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    impressions,
    clicks,
    cost,
    conversions
from public.google_ads

union all

select
    date,
    'tiktok',
    campaign_id,
    campaign_name,
    adgroup_id as ad_group_id,
    adgroup_name as ad_group_name,
    impressions,
    clicks,
    cost,
    conversions
from public.tiktok_ads;



select * 
from public.unified_ads;




