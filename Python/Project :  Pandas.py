# import data
import pandas as pd
df = pd.read_csv("sample-store.csv")

# shape of dataframe
df.shape

# see data frame information using .info()
df.info()

# example of pd.to_datetime() function
pd.to_datetime(df['Order Date'].head(), format='%m/%d/%Y')

# TODO - convert order date and ship date to datetime in the original dataframe
df['Order Date'] = pd.to_datetime(df['Order Date'], format='%m/%d/%Y')
df['Ship Date'] = pd.to_datetime(df['Ship Date'], format='%m/%d/%Y')
df

# TODO - count nan in postal code column
df['Postal Code'].isna().sum()

# TODO - filter rows with missing values
df[df['Postal Code'].isna()]

# TODO - Explore this dataset on your owns, ask your own questions

# customer segment in any city have the most profit and how much?
consumer = df.query("Segment == 'Consumer'")
consumer.groupby('City')['Profit'].agg('sum').sort_values(ascending=False).head(1).reset_index()

# TODO 01 - how many columns, rows in this dataset
print(f"{df.shape[0]} ; {df.shape[1]}")

# TODO 02 - is there any missing values?, if there is, which colunm? how many nan values?
df.isna().sum().sum()
# column 12 have nan 11 numbers 

# TODO 03 - your friend ask for `California` data, filter it and export csv for him
result = df.query("State == 'California' ")
result.to_csv("California.csv")

# TODO 04 - your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send him csv file
Y2017 = df[(df['Order Date'] > '2017/01/01') & (df['Order Date'] < '2017/12/31')]
Y2017.query("State == ['California', 'Texas']")

# TODO 05 - how much total sales, average sales, and standard deviation of sales your company make in 2017
Y2017 = df[(df['Order Date'] > '2017/01/01') & (df['Order Date'] < '2017/12/31')]
Y2017['Sales'].agg(['sum', 'mean', 'std'])

# TODO 06 - which Segment has the highest profit in 2018
Y2018 = df[(df['Order Date'] > '2018/01/01') & (df['Order Date'] < '2018/12/31')]
#Y2018.sort_values('Profit', ascending=False)
Y2018.groupby('Segment')['Profit'].sum().sort_values(ascending=False)

# TODO 07 - which top 5 States have the least total sales between 15 April 2019 - 31 December 2019
Y2019 = df[(df['Order Date'] > '2019/04/15') & (df['Order Date'] < '2019/12/31')]
Y2019.groupby('State')['Sales'].sum().sort_values(ascending=False).head(5).reset_index()

# TODO 08 - what is the proportion of total sales (%) in West + Central in 2019 e.g. 25% 
Y2019 = df[(df['Order Date'] > '2019/04/15') & (df['Order Date'] < '2019/12/31')]
WC_Y2019 = Y2019.query("Region == ['West','Central']")
Total_sales_WC_Y2019 = WC_Y2019['Sales'].sum()
Total_sales_Y2019 = Y2019['Sales'].sum()
proportion = (Total_sales_WC_Y2019 / Total_sales_Y2019) * 100
proportion

# TODO 09 - find top 10 popular products in terms of number of orders vs. total sales during 2019-2020

Y2019_2020 = df[(df['Order Date'] > '2019/01/01') & (df['Order Date'] < '2020/12/31')]
Top_10_product_orders = Y2019_2020.groupby('Product Name')['Quantity'].agg('sum')\
    .sort_values(ascending=False).head(10).reset_index()

Top_10_product_sales = Y2019_2020.groupby('Product Name')['Sales'].agg('sum')\
    .sort_values(ascending=False).head(10).reset_index()

result = pd.concat([Top_10_product_orders,Top_10_product_sales], axis=1, join='inner')
result.columns = ['Product','Total Quantity','Product','Total Sales']
result


# TODO 10 - plot at least 2 plots, any plot you think interesting :)
# Top 5 product total sales during 2018-2019
import matplotlib.pyplot as plt
Y2018_2019 = df[(df['Order Date'] > '2018/01/01') & (df['Order Date'] < '2019/12/31')]
Y2018_2019.groupby('Product Name')['Sales'].agg('sum').head(5).plot(kind='pie', autopct='%1.0f%%')

plt.title('Top 5 product total sales during 2018-2019')

# the segment highest of profit
df.groupby('Segment')['Profit'].agg('sum').sort_values(ascending=False)\
    .plot(kind='bar', color=['royalblue','cornflowerblue','lightsteelblue'])

plt.title('the segment highest of profit')

# TODO Bonus - use np.where() to create new column in dataframe to help you answer your own questions

import numpy as np
df['threshold'] = np.where(df['Profit'] >50, 'Profit', 'Loss' )
df
