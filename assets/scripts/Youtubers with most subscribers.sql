/*

1. Define the variables.
2. Create a CTE that rounds the average views per video
3. Select the column you need and create calculated columns from the existing ones
4. Filter results by Youtube channels
5. Sort results by net profit (from high to low)


*/

select * 
from youtube_db..view_uk_youtubers

--1
DECLARE @conversionRate FLOAT = 0.02;		-- The conversion rate @ 2%
DECLARE @productCost FLOAT = 5.0;			-- The product cost @ $5
DECLARE @campaignCost FLOAT = 50000.0;		-- The campaign cost @ $50,000	

-- 2.  
WITH ChannelData AS (
SELECT ChannelNames, total_views, total_videos, ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
FROM youtube_db..view_uk_youtubers
)


-- 3. 
SELECT 
    ChannelNames,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost) AS net_profit
FROM 
    ChannelData


-- 4. 
WHERE 
    ChannelNames in ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')    


-- 5.  
ORDER BY
	net_profit DESC