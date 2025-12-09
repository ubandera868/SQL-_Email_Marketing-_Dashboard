--  open rate,  click rate, and total unsibscribes per region
SELECT  u.region, 
		sum(e.opened) total_opened_emails, 
		sum(e.opened)/count(*) * 100 as percent_opened, 
        sum(e.clicked) total_clicked, 
        sum(e.clicked)/ count(*) * 100 as percent_clicked, 
        count(DISTINCT un.unsubscribe_id) total_unsubscribes
FROM email_engagement e
JOIN users u
ON e.user_id = u.user_id
LEFT JOIN unsubscribes un 
ON u.user_id = un.user_id
GROUP BY u.region;
-- There seems to be no mass differences in open emails and clicked emails between regions. They are very close to one another, with about 60% open rate. The click rate is pretty low
-- being under 20 percent for all regions. Asia has the most unsibscribes while South America has the least

-- data on device_type category
SELECT  u.device_type, 
		sum(e.opened) total_opened, 
        sum(e.opened)/count(*) percent_opened, 
        sum(e.clicked) total_clicked, 
        sum(e.clicked)/count(*) percent_clicked
FROM users u
JOIN email_engagement e
ON u.user_id = e.user_id
LEFT JOIN unsubscribes un 
ON un.user_id = u.user_id
GROUP BY u.device_type;
-- No noticeable difference in percent opened and percent clicked among device types. Desktop has the least unsubscribes while tablet has the most. 
