-- Campaign Performance Overview. Extracting key columns and creating aggregations 
SELECT  
    SUM(c.total_sent) AS total_sents, 
    SUM(c.total_opens) AS total_opens, 
    SUM(c.total_clicks) AS total_clicks,
    
    SUM(c.total_opens) / SUM(c.total_sent) * 100 AS open_rate,
    SUM(c.total_clicks)  / SUM(c.total_sent) * 100 AS click_rate,
    SUM(c.total_clicks) / SUM(c.total_opens) * 100 AS open_to_click_rate
    
FROM Campaign_Performance c;
-- Highlights: Opene rate is about 60% and unsubscribe rate is less than 1%

-- Restructuring campaign_performance table in a longer format to use for tableau in a funnel chart
SELECT campaign_id, 'Sent' AS stage, total_sent AS value FROM campaign_performance
UNION ALL
SELECT campaign_id, 'Opened', total_opens FROM campaign_performance
UNION ALL
SELECT campaign_id, 'Clicked', total_clicks FROM campaign_performance
UNION ALL
SELECT campaign_id, 'Unsubscribed', total_unsubscribes FROM campaign_performance;


-- Grouping data by campaign to see which campaigns had the highest open rate
SELECT  
    c.campaign_id,
    SUM(c.total_sent) AS total_sends, 
    SUM(c.total_opens) AS total_opens, 
    SUM(c.total_clicks) AS total_clicks,
    
    SUM(c.total_opens) / SUM(c.total_sent) * 100 AS open_rate,
    SUM(c.total_clicks)  / SUM(c.total_sent) * 100 AS click_rate,
    SUM(c.total_clicks) / SUM(c.total_opens) * 100 AS click_to_open_rate
FROM Campaign_Performance c
GROUP BY c.campaign_id
ORDER BY open_rate DESC;
-- Middle campaigns had the best results. Earlier campaigns struggled more than the later campaigns
