# Base

### base_transaction
In this model, we combined all the sources.
Here we have done major cleaning and transformation according to the best practices.
As the data is divided into a couple of sources, we need to model the data accordingly.
Here the data modeling strategy that is being followed is Star Schema methodology.
To address this, we need to combine all of the sources as needed to later convert it into facts and dimensions in the mart layer.

# Assumption
Some assumptions are taken into consideration, to create surrogate key.
In the data, we are missing product_id to uniquely identify each product, that is why a hash function is used to 
get unique combination of product_name and product_sku.

# Data Cleaning
There are some data cleaning done through regexp function to get rid of special characters. Also upper function is used
to keep the data in sync.

# Future works
In this layer, we can add all of the heavy duty transformations that is needed to make sure we have the right data according to business.

# Optimization
As this table can carry billions of row, we have tried to use dbt incremental strategy and clustering using config blog.
We used micro batch processing based on created_at, where it'll update the data. By default lookback window is 1 day. 
We can increase it if we want to check the past data for couple of days.
The 'delete+insert' strategy is not chosen because, updating is easier with micro batch. 
If anything is changed, we can identify the time horizon for only updating those values.