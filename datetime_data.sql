-- Data on emails opened based on day
SELECT
	dayname(e.open_time) AS day,
    count(*) as total
FROM email_engagement e
JOIN users u
on e.user_id = u.user_id
WHERE e.open_time IS NOT NULL
group by dayname(e.open_time)
order by total desc;
--  Thursdays and Fridays have the most opens while Mondays and Sundays are the least. 

-- Data on open emails based on time of day
SELECT
    HOUR(e.open_time) AS hour_of_day,
    COUNT(*) AS total_opens
FROM email_engagement e
WHERE e.open_time is not null
GROUP BY HOUR(e.open_time)
ORDER BY total_opens desc;
-- Times vary in terms of openings but the pattern shows that early in the morning and 
-- late in the eveing have less openings in comparison to the middle of the day all the way to the early evening. 11:00 am and 
-- 6:00 pm had the most opens but i would say from 10:00 -11:00 am, 1:00 - 3:00 pm, and 6:00 pm are the best times to send emails.

-- data on signups based on time of year
SELECT month(signup_date), 
		count(*) total_signups
FROM users 
GROUP BY month(signup_date)
ORDER BY total_signups DESC;
-- the best time so send campaigns for signups is during the first 3rd of the year. 
-- the most amount of signups happened during the first 3-4 months of the year. We would want 
-- to avoid sending email camapaigns for signups anytime in September through December. The most amount of signups happened in Jan and March.
