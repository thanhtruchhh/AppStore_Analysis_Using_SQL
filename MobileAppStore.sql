-- ** EDA **
-- 1. Check if there are any duplicated apps in both tables
SELECT 
	id,
	COUNT(*) AS id_cnt
FROM AppleStore
GROUP BY id
HAVING COUNT(*) > 1;

SELECT 
	id,
	COUNT(*) AS id_cnt
FROM appleStore_description
GROUP BY id
HAVING COUNT(*) > 1;
-- -> All id apps are unique.

-- 2. Check if there are any apps existing only 1 of 2 tables.
SELECT COUNT(*)
FROM AppleStore a
LEFT JOIN appleStore_description d ON a.id = d.id
WHERE a.id IS NULL;

SELECT COUNT(*)
FROM appleStore_description d
LEFT JOIN AppleStore a ON a.id = d.id
WHERE d.id IS NULL;
-- -> All apps in 1 table have corresponding entries in the other table.

-- 3. Check there are any missing values in key fields
-- AppleStore: id, track_name, currency, user_rating, lang.num, size_bytes
SELECT COUNT(*)
FROM AppleStore
WHERE
	id IS NULL
	OR track_name IS NULL
	OR currency IS NULL
	OR user_rating IS NULL
	OR "lang.num" IS NULL
	OR size_bytes IS NULL;
	
-- appleStore_description: id, app_desc
SELECT COUNT(*)
FROM appleStore_description
WHERE 
	id IS NULL
	OR app_desc IS NULL;
-- -> There are no null values in specifed key fields.

-- 4. Calc #of apps in each genre
SELECT
	prime_genre,
	COUNT(id) AS app_cnt
FROM AppleStore
GROUP BY 1
ORDER BY COUNT(id) DESC;
-- -> Games, entertainment, education lead in terms of #of apps.

-- 5. Get an overview of app ratings
SELECT 
	MIN(user_rating),
	MAX(user_rating),
	AVG(user_rating)
FROM AppleStore;
-- -> Ratings are in range [1, 5]  with an avg rating of approximately 3.5.

-- 6. Get an overview of price
SELECT 
	MIN(price),
	MAX(price),
	AVG(price)
FROM AppleStore;
-- -> There are both free and paid apps on App Store, avg price of approximately $1.73.

-- 7. Get an overview of lang.num
SELECT 
	MIN("lang.num"),
	MAX("lang.num"),
	AVG("lang.num")
FROM AppleStore;
-- -> #of language supported is in range [0, 75] with an avg of approximately 5.4. 0 may present that apps only use default language setting.

-- 8. Get an overview of size_bytes
SELECT 
	MIN(size_bytes),
	MAX(size_bytes),
	AVG(size_bytes)
FROM AppleStore;
-- -> Size bype is in range [589824, 4025969664] with an avg of approximately 199134453.8.

-- 9. Get an overview of app description
SELECT 
	MIN(LENGTH(app_desc)),
	MAX(LENGTH(app_desc)),
	AVG(LENGTH(app_desc))
FROM appleStore_description;
-- -> Length of app desc is in range [17, 4000] with an avg of approximately 1553.71.


-- ** Find insights **
-- 1. Determine if paid apps have higher ratings than free apps
SELECT 
	CASE
		WHEN price > 0 THEN 'Paid app'
		ELSE 'Free app'
	END AS app_types,
	AVG(user_rating) AS user_rating_avg
FROM AppleStore
GROUP BY 1;
-- -> Rating of paid apps is slightly higher than of free app.

-- 2. Check if apps with more supported language have higher rating
SELECT
	CASE 
		WHEN "lang.num" < 10 THEN '<10 languages'
		WHEN "lang.num" < 30 THEN '10-30 languages'
		ELSE '>30 languages'
	END AS lang_bins,
	AVG(user_rating) AS user_rating_avg
FROM AppleStore
GROUP BY 1
ORDER BY 2 DESC;
-- -> The middle bin has the highest avg rating.

-- 3. Find out genres with low ratings
SELECT 
	prime_genre,
	AVG(user_rating) AS user_rating_avg
FROM AppleStore
GROUP BY 1
ORDER BY 2;
-- -> Catalogs, finance, and book are the top 3 genres that users rate poorly.

-- 4. Check if there is correlation between app description length and user ratings.
SELECT 
	CASE
		WHEN LENGTH(app_desc) < 500 THEN 'Short'
		WHEN LENGTH(app_desc) < 1000 THEN 'Medium'
		ELSE 'Long'
	END AS len_desc_bins,
	AVG(user_rating) AS user_rating_avg
FROM appleStore_description
JOIN AppleStore USING(id)
GROUP BY 1
ORDER BY 2 DESC;
-- -> Apps with longer descriptions tend to have higher ratings.

-- 5. Determine the top-rated app for each genre
SELECT 
	prime_genre,
	track_name,
	user_rating
FROM (
	SELECT
		track_name,
		prime_genre,
		RANK() OVER(
			PARTITION BY prime_genre
			ORDER BY user_rating DESC
		) AS rank,
		user_rating
	FROM AppleStore
) AS r
WHERE rank = 1;
--> All of them have recived a rating of 5

-- 6. Check if larger apps have higher rating
SELECT
	CASE 
		WHEN size_bytes <= 1000000000 THEN 'Small'
		WHEN size_bytes <= 2000000000 THEN 'Medium'
		ELSE 'Large'
	END AS size_cats,
	AVG(user_rating) AS user_rating_avg
FROM AppleStore
GROUP BY 1
ORDER BY 2 DESC;
-- -> Larger apps have the lowest average user ratings.

-- 7. Check if more mature content apps have low ratings
SELECT 
	cont_rating,
	AVG(user_rating) AS user_rating_avg
FROM AppleStore
GROUP BY 1
ORDER BY 2 DESC;
-- -> 17+ apps have lower rating than apps with less mature content ratings.

-- 8. Check if there is correlation between price and rating
SELECT
	CASE
		WHEN price = 0 THEN 'Free'
		WHEN price <= 5 THEN 'Low-priced'
		WHEN price <= 10 THEN 'Medium-priced'
		ELSE 'High-priced'
	END AS price_bins,
	AVG(user_rating) AS user_rating_avg
FROM AppleStore
GROUP BY 1
ORDER BY 2 DESC;
-- -> App cost $5-10 have the highest rating. Free app have the lowest rating.

-- 9. Find out avg price of apps in each genres
SELECT
	prime_genre,
	AVG(price) AS price_avg
FROM AppleStore
GROUP BY 1
ORDER BY 2 DESC;

-- ** Conclusion **
/*Insights:
 * 1. Paid apps achieve slightly better ratings than free apps.
 * Users are willing to pay for high-quality apps or special features.
 * We should offer them free trials to experience our products.
 * 
 * 2. Apps supporting 10-30 languages have the highest avg rating.
 * Supporting too many languages doesn't increase user ratings.
 * Instead of configuring multiple languages, we can focus on supporting the commonly used languages for the app's target users.
 * 
 * 3. Finance, Book, and Navigation have low average ratings.
 * Users are generally less satisfied with apps in these categories. 
 * Our dev can create a new quality app or improve an existing app to meet user expectations.
 * Opting for higher-ratings markets (Photo & Video, Music, Productivity...) can be a challenge.
 *
 * 4. There is a positive relationship between app description length and rating.
 * User prefer long app descriptions.
 * We should provide detailed app descriptions for users to read before installing.
 * 
 * 5. All top-rated apps for each genre have received rating of 5.
 * Avg rating of all apps is 3.53.
 * Our apps should aim for a rating being higher than the avg in order to stand out.
 *
 * 6. Larger apps tend to have lower ratings compared to medium and small-sized apps.
 * Users may prefer smaller apps for some reasons: easy to use, consume fewer system resources, save storage...
 * We should create smaller and more focused apps instead of large and complex ones.
 *
 * 7. Apps with a 17+ maturity rating have significantly lower rating compared to the others.
 * Dev should consider the target audience and content appropriateness when developing apps.
 * 
 * 8. Medium-priced apps ($5-10) have the highest ratings.
 * Free apps have the lowest ratings.
 * We should consider pricing strategies carefully: a pricing model, target audience, market analysis, value proposition...
 *
 * 9. Avg prices by genre
 * Medical have the highest avg price, followed by business.
 * Finance and social networking genres have mush lower avg prices.
 * Shopping are either free or have a very low cost.
 * When determining the pricing strategy, we can consider the average prices with in specific genres.
 */