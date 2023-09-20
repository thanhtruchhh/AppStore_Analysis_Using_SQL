# App Store Analysis Using SQL

This project involves a analysis of app data from the Apple App Store. Utilizing SQLite for querying, I delve into two key datasets: `AppleStore` and `AppleStoreDesc`, aiming to extract valuable insights and trends related to user ratings, pricing, and user preferences within different app genres. The project was inspired by [Lore's YouTube video](https://www.youtube.com/watch?v=EKOWoInn46A&t=754s).

## Kaggle Dataset

The primary dataset used in this project can be accessed on [Kaggle](https://www.kaggle.com/datasets/ramamet4/app-store-apple-data-set-10k-apps). This dataset provides information on over 7,000 apps available on the Apple App Store, including details such as app names, user ratings, pricing, genres...

## Data Dictionary

Here is a brief description of the columns in the two datasets:

**AppleStore:**

- `id`: Unique app identifier.
- `track_name`: Name of the app.
- `size_bytes`: Size of the app in bytes.
- `currency`: Currency used for pricing.
- `price`: Price of the app.
- `rating_count_tot`: Total user ratings.
- `rating_count_ver`: User ratings for the current version.
- `user_rating`: Average user rating.
- `user_rating_ver`: Average user rating for the current version.
- `ver`: App version.
- `cont_rating`: Content rating.
- `prime_genre`: Primary genre of the app.
- `sup_devices.num`: Number of supported devices.
- `ipadSc_urls.num`: Number of screenshots displayed for iPad.
- `lang.num`: Number of supported languages.
- `vpp_lic`: If an app is available for VPP (Volume Purchase Program).

**AppleStoreDesc:**

- `id`: Unique app identifier.
- `track_name`: Name of the app.
- `size_bytes`: Size of the app in bytes.
- `app_desc`: App description.

## Project Overview
This project follows a structured approach, including:

- Exploratory data analysis: Understand the dataset's structure and quality and reveal issues in the dataset.

- Finding insights: Extract valuable insights from data by executing SQL queries..

- Make recommendations

## Stakeholder Requirements
The app development team seeks data-driven insights to make informed decisions about the type of app to build. They are specifically looking to answer the following questions:
- What app categories are most popular?
- What price should be set?
- How to maximize rating?

## Insights and recommendations

1. **Paid apps outperform free apps**: 
Paid apps tend to achieve slightly higher user ratings compared to free apps. This suggests that users are willing to pay for high-quality apps or unique features. To capitalize on this, we should consider offering free trials to allow users to experience the value of our paid products.

2. **Optimal language support**: 
Apps that support between 10 to 30 languages tend to receive the highest average ratings. Supporting an excessive number of languages does not necessarily lead to higher user ratings. Therefore, when developing our apps, we should prioritize support for commonly used languages among our target users rather than attempting to cover all languages.

3. **Challenges in certain genres**: 
The genres of Finance, Book, and Navigation receive lower average ratings. Users appear to be less satisfied with apps in these categories. To address this, our development team should consider creating high-quality apps or improving existing ones within these genres to meet user expectations. However, entering highly competitive genres such as Photo & Video, Music, and Productivity may pose challenges.

4. **App description length matters**: 
There is a positive relationship between app description length and user ratings. Users tend to favor longer app descriptions. To attract more users and enhance their understanding of our apps, we should provide detailed and informative app descriptions for users to read before installation.

5. **Aim for excellence**: 
The top-rated apps in each genre have consistently received a perfect rating of 5. Considering that the average rating for all apps is 3.53, we should aim for ratings higher than the average to stand out in the AppStore.

6. **Size matters**:
Larger apps tend to have lower user ratings compared to medium and small-sized apps. Users may prefer smaller apps due to their ease of use, minimal resource consumption, and storage-saving benefits. In light of this, our development strategy should prioritize creating smaller, more focused apps rather than large and complex ones.

7. **Content rating considerations**: 
Apps with a content rating of 17+ receive significantly lower ratings compared to apps with lower maturity ratings. Developers should carefully consider the target audience and content appropriateness when developing apps.

8. **Pricing strategy**: 
Medium-priced apps, typically priced between $5 to $10, receive the highest user ratings. In contrast, free apps tend to have the lowest ratings. When determining our pricing strategy, we should carefully evaluate factors such as pricing models, target audience, market analysis, and value propositions to maximize user satisfaction and profitability.

9. **Average prices by genre**: 
Medical apps have the highest average prices, followed by Business apps. In contrast, Finance and Social Networking genres have significantly lower average prices, and Shopping apps are either free or have very low costs. When formulating pricing strategies, we should take into account the average prices within specific genres to remain competitive and profitable.


