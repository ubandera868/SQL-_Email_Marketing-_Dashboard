-- Unsubscribe reasons 
SELECT  reason, 
		count(*)
FROM unsubscribes
GROUP BY reason
ORDER BY count(*) desc;
-- Privacy Concerns is the number one reason 

-- Grouped by reason and category to see what are the top resaaons per category and the percentage of unsubscribers. I used the "over" function to apply the aggregate over the entire result set
-- meaning the total unsibscribed members. 
SELECT  u.reason, 
		c.category, 
        count(*) total_unsubscribes, 
        count(*) / sum(count(*)) OVER () * 100 AS percent_of_unsubscribed
FROM unsubscribes u
JOIN campaigns c
on c.campaign_id = u.campaign_id
GROUP BY reason, category
order by category DESC;
-- overall trend between all cateogries is privacy concerns while too many emails sometimes was second

-- Data on amount of people who unsubscribed during each campaign. 
SELECT  campaign_id, 
		count(*) total_unsubscribes
FROM unsubscribes
GROUP BY campaign_id
ORDER BY total_unsubscribes DESC;
-- Campaings 1 and 2 had the most unsubscribers while campaign 13 had the least amount of unsubscribes

--  Data below shows how long, on average, it took for people to unsibscribe after a campaign was sent out
SELECT  c.campaign_id, 
		avg(DATEDIFF(u.unsubscribe_date, c.send_date)) avg_days,
        cp.total_unsubscribes
FROM campaigns c
JOIN campaign_performance cp
ON c.campaign_id = cp.campaign_id
JOIN unsubscribes u
on c.campaign_id = u.campaign_id
WHERE u.unsubscribe_date > c.send_date -- if the value is negative, people unsubscribed before the campiagn was sent out. Omiting this data because it is not connected to the relationship between date unsubscribed and campaign sent date
GROUP BY c.campaign_id
ORDER BY avg_days;

-- unsubscribe rate total and unsubscribe rate per campaign
SELECT sum(total_unsubscribes) / sum(total_sent) *100 as unsubscribe_rate
FROM campaign_performance;

SELECT campaign_id, total_unsubscribes, total_unsubscribes / total_sent *100 as unsubscribe_rate
FROM campaign_performance
order by unsubscribe_rate DESC
-- the total unsubscribe rate is 5.05% of all the emeails sent. 
