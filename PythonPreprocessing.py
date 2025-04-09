#!/usr/bin/env python
# coding: utf-8

# In[2]:


#pip will install the required libraries:

get_ipython().system(' pip install PyMysql')
get_ipython().system(' pip install ipython-sql')
get_ipython().system(' pip install mysqlclient')


# In[1]:


# import the libraries listed below:
#Data handling libraries
import numpy as np
import pandas as pd

#Data Visualization Libraries
import matplotlib.pyplot as plt
import seaborn as sns

#Database Libraries
import mysql.connector

#Filter Warnings
import warnings
warnings.filterwarnings("ignore")


# In[4]:


# Establish a connection to mysql database:
db_name = "machinedowntime"
db_host = "localhost"
db_username ="root"
db_password ="Trissy123"

try:
    conn =pymysql.connect(host=db_host,
                         port = int(3306),
                         user = "root",
                         password = db_password,
                         db = db_name)
    
except e:
        print(e)
if conn:
        print("connection sucessful")
else:
         
            print("error")


# In[5]:


df = pd.read_sql_query(" select * from Machine_Downtime_Preprocessed ", conn)
df


# In[6]:


#Data understanding
#Display the first few rows of the DataFrame
df.head()


# In[6]:


#Display the first 10 rows of the DataFrame
df.head(10)


# In[7]:


#Display the last 10 rows of the DataFrame
df.tail(10)


# In[8]:


df.describe()


# In[9]:


df.info()


# In[10]:


df.isnull()


# In[11]:


df.notnull()


# In[12]:


df.isnull().sum()


# In[19]:


# find missing value
# Find zero values in each column
missing_value = (df == 0).sum()

# Display the count of zero values for each column
print(missing_value)


# In[50]:


df.duplicated().sum()


# In[17]:


df.dtypes


# In[20]:


df.columns


# In[18]:


# Replace 'YourColumnName' with the actual column name
selected_column = 'Hydraulic_Pressure'  

# Calculate statistics for the selected column
count = df[selected_column].count()
avg = df[selected_column].mean()
min_value = df[selected_column].min()
max_value = df[selected_column].max()
stddev = df[selected_column].std()

# Display the calculated statistics
print(f"COUNT: {count}")
print(f"AVG: {avg}")
print(f"MIN: {min_value}")
print(f"MAX: {max_value}")
print(f"STDDEV: {stddev}")


# In[62]:


#Count of unique values in categorical columns:
df['Machine_ID'].value_counts()
df['Assembly_Line_No'].value_counts()


# In[23]:


# Group the data by 'Machine_ID' and calculate the average of 'Voltage' for each group
average_voltage_by_machine = df.groupby('Machine_ID')['Voltage'].mean().reset_index()

# Display the result
print(average_voltage_by_machine)


# In[24]:


# Convert the 'Coolant_Temperature' column to numeric (in case it's not already)
df['Coolant_Temperature'] = pd.to_numeric(df['Coolant_Temperature'], errors='coerce')

# Filter the DataFrame for machines with coolant temperature between 25 and 30 degrees
filtered_df = df[(df['Coolant_Temperature'] >= 25) & (df['Coolant_Temperature'] <= 30)]

# Group the filtered DataFrame by 'Machine_ID' and count the occurrences of downtime
machine_downtime_counts = filtered_df.groupby('Machine_ID')['Downtime'].count().reset_index()

# Display the result
print(machine_downtime_counts)


# In[25]:


# Create a scatter plot to visualize the relationship
plt.figure(figsize=(5, 5))
sns.scatterplot(data=df, x='Spindle_Vibration', y='Downtime', hue='Downtime')
plt.title('Scatter Plot of Spindle Vibration vs. Downtime')
plt.xlabel('Spindle Vibration')
plt.ylabel('Downtime')
plt.show()


# In[83]:


# Create box plots to compare the distribution of Spindle Vibration for each downtime category
plt.figure(figsize=(5, 3))
sns.boxplot(data=df, x='Downtime', y='Spindle_Vibration')
plt.title('Box Plot of Spindle Vibration by Downtime')
plt.xlabel('Downtime')
plt.ylabel('Spindle Vibration')
plt.show()


# In[84]:


# Create a box plot to compare the distribution of Cutting values for each downtime category
plt.figure(figsize=(3, 3))
sns.boxplot(data=df, x='Downtime', y='Cutting')
plt.title('Box Plot of Cutting by Downtime')
plt.xlabel('Downtime')
plt.ylabel('Cutting')
plt.show()


# In[80]:


# Create a box plot to compare the distribution of Torque values for each downtime category
plt.figure(figsize=(5, 3))
sns.boxplot(data=df, x='Downtime', y='Torque')
plt.title('Box Plot of Torque by Downtime')
plt.xlabel('Downtime')
plt.ylabel('Torque')
plt.show()


# In[29]:


df.duplicated().sum()


# In[30]:


#Summary Statistics (Univariate Analysis)
summary_stats = df.describe()
print("Summary Statistics:")
print(summary_stats)


# In[79]:


import matplotlib.pyplot as plt
import seaborn as sns
# Histograms (Univariate Analysis)
df.hist(figsize=(8, 10))
plt.suptitle("Histograms of Variables")
plt.show()


# In[69]:


import warnings
warnings.filterwarnings("ignore")
# Correlation Matrix (Multivariate Analysis)
correlation_matrix = df.corr()
plt.figure(figsize=(11, 3))
sns.heatmap(correlation_matrix, annot=True, cmap="coolwarm")
plt.title("Correlation Matrix")
plt.show()


# In[72]:


#create a scatter plot between 'Hydraulic_Pressure' and 'Downtime':
#Bivariate Analysis:
plt.figure(figsize=(5, 3))
plt.scatter(df['Hydraulic_Pressure'], df['Downtime'], alpha=0.5)
plt.xlabel('Hydraulic Pressure')
plt.ylabel('Downtime')
plt.title('Scatter Plot: Hydraulic Pressure vs. Downtime')
plt.show()


# In[71]:


#create a histogram for the 'Spindle_Speed' variable:
#Univariate Analysis:
plt.figure(figsize=(5, 3))
plt.hist(df['Spindle_Speed'], bins=20, edgecolor='k')
plt.xlabel('Spindle Speed')
plt.ylabel('Frequency')
plt.title('Histogram: Spindle Speed')
plt.show()


# In[73]:


import matplotlib.pyplot as plt
#Business-Focused Visualizations
# Example: Line chart showing the trend of Hydraulic_Pressure over time
plt.figure(figsize=(11, 3))
plt.plot(df['Date'], df['Hydraulic_Pressure'], label='Hydraulic Pressure')
plt.xlabel('Date')
plt.ylabel('Hydraulic Pressure')
plt.title('Trend of Hydraulic Pressure Over Time')
plt.legend()
plt.show()



# In[74]:


# Example: Box plot for Hydraulic_Pressure by Assembly Line
plt.figure(figsize=(6, 3))
sns.boxplot(x='Assembly_Line_No', y='Hydraulic_Pressure', data=df)
plt.xlabel('Assembly Line')
plt.ylabel('Hydraulic Pressure')
plt.title('Hydraulic Pressure Distribution by Assembly Line')
plt.show()


# In[59]:


#measures of central tendency.
import warnings
warnings.filterwarnings("ignore")
# Calculate the mean for numeric columns
mean_values = df.mean()

# Calculate the median for numeric columns
median_values = df.median()

# Calculate the mode for object (categorical) columns
mode_values = df.mode().iloc[0]  # Using iloc[0] to get the first mode if multiple exist

# Print the results
print("Mean:")
print(mean_values)
print("\nMedian:")
print(median_values)
print("\nMode:")
print(mode_values)


# In[75]:


# Pairs Plot (for numeric columns)
plt.figure(figsize=(3, 2))
sns.pairplot(df[['Hydraulic_Pressure', 'Coolant_Pressure', 'Voltage', 'Torque']])
plt.suptitle('Pairs Plot')
plt.show()


# In[66]:


# Bar Chart (Example: Count of Machine_ID values)
plt.figure(figsize=(5, 3))
sns.countplot(data=df, x='Machine_ID')
plt.title("Bar Chart - Machine_ID Count")
plt.xticks(rotation=45)
plt.show()


# In[65]:


# Pie Chart (Example: Count of Assembly_Line_No values)
assembly_line_counts = df['Assembly_Line_No'].value_counts()
plt.figure(figsize=(3, 3))
plt.pie(assembly_line_counts, labels=assembly_line_counts.index, autopct='%1.1f%%')
plt.title("Pie Chart - Assembly Line Counts")
plt.show()


# In[85]:


# Bar charts for categorical columns (Machine_ID and Assembly_Line_No)
categorical_columns = df.select_dtypes(include=['object'])
for column in categorical_columns:
    plt.figure(figsize=(2, 2))
    df[column].value_counts().plot(kind='bar')
    plt.title(f'Bar Chart for {column}')
    plt.xlabel(column)
    plt.ylabel('Count')
    plt.xticks(rotation=45)
    plt.show()


# In[58]:


import warnings
warnings.filterwarnings("ignore")
# Set the style of the plot (optional)
sns.set(style="whitegrid")

# Create a figure and axis for each column
plt.figure(figsize=(16, 8))

# Loop through each numeric column and create a box plot
numeric_columns = df.select_dtypes(include=['float64', 'int64']).columns
for i, column in enumerate(numeric_columns, 1):
    plt.subplot(3, 5, i)  # Create a subplot for each column
    sns.boxplot(x=df[column], orient="v", width=0.5)
    plt.title(column)

# Adjust the layout
plt.tight_layout()

# Show the plots
plt.show()


# In[60]:


# Calculate measures of dispersion for numeric columns
dispersion_measures = {
    'Column': [],
    'Mean': [],
    'Median': [],
    'Standard Deviation': [],
    'Variance': [],
    'Minimum': [],
    'Maximum': [],
}

numeric_columns = df.select_dtypes(include=['float64', 'int64'])

for column in numeric_columns.columns:
    dispersion_measures['Column'].append(column)
    dispersion_measures['Mean'].append(df[column].mean())
    dispersion_measures['Median'].append(df[column].median())
    dispersion_measures['Standard Deviation'].append(df[column].std())
    dispersion_measures['Variance'].append(df[column].var())
    dispersion_measures['Minimum'].append(df[column].min())
    dispersion_measures['Maximum'].append(df[column].max())

# Create a new DataFrame to display the results
dispersion_df = pd.DataFrame(dispersion_measures)

print(dispersion_df)


# In[67]:


import matplotlib.pyplot as plt
import seaborn as sns

# Example: Create a histogram for a numerical column
plt.figure(figsize=(5, 3))
plt.hist(df['Hydraulic_Pressure'], bins=20)
plt.xlabel('Hydraulic Pressure')
plt.ylabel('Frequency')
plt.title('Histogram of Hydraulic Pressure')
plt.show()


# In[64]:


# Box plots for numeric columns
plt.figure(figsize=(9, 3))
sns.boxplot(data=df[numeric_columns.columns], orient='v')
plt.title('Box Plots for Numeric Columns')
plt.xticks(rotation=45)
plt.show()


# In[86]:


#SKEWNESS AND KURTOSIS

# Import the necessary libraries
import pandas as pd

# Assuming you have already established a connection and read the data into 'df'

# Select only the numerical columns for skewness and kurtosis calculations
numerical_columns = df.select_dtypes(include=['float64', 'int64'])

# Calculate skewness for each numerical column
skewness = numerical_columns.skew()

# Calculate kurtosis for each numerical column
kurtosis = numerical_columns.kurtosis()

# Display the skewness and kurtosis for each column
skewness_and_kurtosis = pd.DataFrame({'Skewness': skewness, 'Kurtosis': kurtosis})
print(skewness_and_kurtosis)


# In[89]:


#SKEWNESS
# Get the list of numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64']).columns

# Create a bar plot for skewness for each numeric column
plt.figure(figsize=(10, 4))
skewness_values = []

for column_name in numeric_columns:
    skewness = df[column_name].skew()
    skewness_values.append(skewness)
    plt.bar(column_name, skewness)

plt.xlabel('Column Name')
plt.ylabel('Skewness')
plt.title('Skewness for Numeric Columns')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()


# In[90]:


#KURTOSIS

# Get the list of numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64']).columns

# Create a bar plot for kurtosis for each numeric column
plt.figure(figsize=(10, 5))
kurtosis_values = []

for column_name in numeric_columns:
    kurtosis = df[column_name].kurtosis()
    kurtosis_values.append(kurtosis)
    plt.bar(column_name, kurtosis)

plt.xlabel('Column Name')
plt.ylabel('Kurtosis')
plt.title('Kurtosis for Numeric Columns')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()


# In[92]:


# Get the list of numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64']).columns

# Set up subplots for univariate graphical analysis
num_plots = len(numeric_columns)
fig, axes = plt.subplots(num_plots, 1, figsize=(5, 5 * num_plots))
fig.subplots_adjust(hspace=0.5)

for i, column_name in enumerate(numeric_columns):
    # Create a histogram for each numeric column
    axes[i].hist(df[column_name], bins=20, color='skyblue', edgecolor='black')
    axes[i].set_title(f'Histogram for {column_name}')
    axes[i].set_xlabel(column_name)
    axes[i].set_ylabel('Frequency')

# Show the plots
plt.tight_layout()
plt.show()


# In[96]:


#OUTLIER DETECTION

# Set the matplotlib backend to display inline
get_ipython().run_line_magic('matplotlib', 'inline')

# Iterate through all columns in the DataFrame
for column in df.columns:
    if df[column].dtype in ['float64', 'int64']:  # Check if the column is numerical
        plt.scatter(df[column], df[column], c='blue', label='Data')
        
        # Identify outliers and change their color to red
        plt.figure(figsize=(5, 3))
        outliers = df[column].loc[df[column] > df[column].mean() + 2 * df[column].std()]
        plt.scatter(outliers.index, outliers, c='red', label='Outliers')  # Use 'index' to get x-coordinates
        
        plt.xlabel(column)
        plt.ylabel(column)
        plt.title(f'Scatter Plot - {column} (Outlier Detection)')
        plt.legend()
        plt.show()


# In[ ]:




