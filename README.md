# Automate Data Pipelines for Real-Time Weather Analytics
![Create at](https://img.shields.io/github/created-at/peemai1/dsi321_2025)

## Project Overview
This project is a part of <b>DSI321: BIG DATA INFRASTRUCTURE</b> course, building a complete system to gather, process, and show real-time weather data from the OpenWeatherMap API. Every 15 minutes, it automatically pulls weather updates for Satitram and 14 nearby spots, so the information is always fresh. Behind the scenes, it uses Prefect 3 to keep the data workflows running smoothly on schedule, and LakeFS helps keep track of data versions and history. Users can explore the weather details on an interactive dashboard built with Streamlit, available in both English and Thai. To make sure everything runs consistently no matter where it’s deployed, the whole setup is packaged in Docker containers. Finally, the weather data is stored efficiently as partitioned Parquet files with optimized formats for convenience in querying and analysis.

## Benefits
- **Real-Time Weather Updates:** <br>
    The system checks the weather every 15 minutes, so users always have the latest info. This means users can make quick decisions and stay on top of any sudden changes.

- **Data-Driven Choices:** <br>
    Reliable weather data helps various stakeholders (such as farmers, city planners, and energy professionals) optimize operations, improve resource management, and prepare for weather-related risks

- **Clear, Actionable Insights:** <br>
    Instead of overwhelming users with raw data, weather info get organized into easy-to-understand groups. This way, users gets concise summaries and practical takeaways, making the dashboard much more user-friendly.

- **Personalized Preparation Tips:** <br>
    By grouping together places with similar weather, the system can give users tailored advice—like what to wear, whether to bring an umbrella, or how to prepare for each conditions.


## Dataset
Data is stored in Parquet format in the LakeFS repository, partitioned by year, month, day, and hour.<br>
Data Schema :
| Column Name         | Data Type                     | Description                                           |
|---------------------|-------------------------------|-------------------------------------------------------|
| timestamp           | datetime64[ns, Asia/Bangkok]  | Date and time when the weather data was collected     |
| minute              | int64                         | Minute component of the timestamp                     |
| created_at          | datetime64[ns, Asia/Bangkok]  | Date and time when the record was created             |
| province            | category                      | Thai province where data was collected                |
| location_name       | category                      | Name of the location as provided in configuration     |
| api_location        | category                      | Location name returned by the OpenWeatherMap API      |
| weather_main        | category                      | Main weather condition (Clear, Clouds, Rain, etc.)    |
| weather_description | category                      | Detailed weather description                          |
| main.temp           | float32                       | Temperature in Celsius                                |
| main.humidity       | int64                         | Humidity percentage                                   |
| wind.speed          | float32                       | Wind speed in meters per second                       |
| rain.1h             | float32                       | Rainfall volume for the last 1 hour in mm             |
| rain.3h             | float32                       | Rainfall volume for the last 3 hours in mm            |
| precipitation       | float32                       | Total precipitation (sum of rainfall and snowfall)    |
| year                | category                      | Year component of the timestamp (for partitioning)    |
| month               | category                      | Month component of the timestamp (for partitioning)   |
| day                 | category                      | Day component of the timestamp (for partitioning)     |
| hour                | category                      | Hour component of the timestamp (for partitioning)    |

Data Storage Structure :
```
weather/
├── main/                  # Main branch
│   └── weather.parquet/   # Partitioned parquet dataset
│       ├── year=2025/
│       │   ├── month=4/
│       │   │   ├── day=10/
│       │   │   │   ├── hour=7/
│       │   │   │   │   └── [parquet files]
│       │   │   │   ├── hour=8/
│       │   │   │   │   └── [parquet files]
│       │   │   │   └── ...
│       │   │   └── ...
│       │   └── ...
│       └── ...
```

| Quality Check | Status |
|--------------|--------|
| Contains at least 1,000 records | ✅ |
| Covers a full 24-hour time range | ✅ |
| At least 90% data completeness | ✅ |
| No columns with data type 'object' | ✅ |
| No duplicate records | ✅ |

## Project structure
```
.
├── LICENSE
├── README.md
├── __pycache__
│   └── streamlit.cpython-312.pyc
├── docker
│   ├── Dockerfile
│   └── requirements.txt
├── docker-compose.yml
├── make
│   ├── Dockerfile.jupyter
│   ├── Dockerfile.prefect-worker
│   ├── requirements.txt
│   └── wait-for-server.sh
├── myflow
│   ├── deploy-local.py
│   └── flow.py
└── visualization
    └── app.py
```

## Streamlit Interface
![alt text](<Screenshot 2568-05-27 at 18.33.41.png>) <br>
**Key Features :**
- **Weather Overview:** <br>
    Visualizes key weather metrics over time, including temperature, humidity, wind speed, and precipitation, to give a quick snapshot of current and historical conditions.

- **Temperature:** <br>
    Focuses on temperature patterns using a heatmap visualization. It also provides rule-based insights such as the highest temperature, average temperature during the selected period, and daily temperature range.

- **Raw Data:** <br>
    Allows users to view the raw weather data exactly as collected—matching what's stored and versioned in LakeFS.

- **Smart Weather Analysis:** (using unsupervised learning ML)<br>
    Enhances insights by applying K-means clustering to group similar weather conditions and generate basic advice that matches the clustered results.

## Tools
Containerize application environment: Docker<br>
Orchestration: Prefect<br>
Data Versioning: lakeFS<br>
Visualization: Streamlit<br>
CI/CD: GitHub Actions<br>

## To Run
- Install required packages:
    ```
    pip install -r docker/requirements.txt
    ```
- Start Docker containers:
    ```
    docker compose up -d --build
    ```
- For scheduled execution, run in your terminal or Jupyter notebook:
    ```
    python deploy-local.py
    prefect worker start --pool 'default-agent-pool' # Use this if the default work pool doesn’t start properly.
    ```
- Ensure the LakeFS repository is created before running the system to store data.

## For Grading
### Part 1
1. **Repository Setup:** 
    [https://github.com/peemai1/dsi321_2025](https://github.com/peemai1/dsi321_2025)

2. **Commit Frequency:** 
| Commit  | Author  | Date      | Message                       |
|---------|---------|-----------|-------------------------------|
| 3f83b82 | Peemai01 | 2025-05-27 | update readme              |
| daad331 | Peemai01 | 2025-05-27 | Update README.md           |
| e9687b8 | Peemai01 | 2025-05-27 | Update README.md           |
| 96fff90 | Peemai01 | 2025-05-27 | Update README.md           |
| 7e9e48c | Peemai01 | 2025-05-27 | Update README.md           |
| 41e7f71 | Peemai01 | 2025-05-27 | Update README.md           |
| c0d80c2 | Peemai01 | 2025-05-27 | Update README.md           |
| 697d288 | Peemai01 | 2025-05-27 | pull data                  |
| 9bd21a3 | Peemai01 | 2025-05-27 | Update README.md           |
| 2f0181a | Peemai01 | 2025-05-27 | update README              |
| 85c4c8b | Peemai01 | 2025-05-27 | Update app.py              |
| e5e5b6b | Peemai01 | 2025-05-27 | update                     |
| a363567 | Peemai01 | 2025-05-27 | Update SCHEMA.md           |
| f727b65 | Peemai01 | 2025-05-27 | Update SCHEMA.md           |
| 49de4fd | Peemai01 | 2025-05-27 | update schema              |
| c4afb5e | Peemai01 | 2025-05-27 | Create SCHEMA.md           |
| 2ddbb11 | Peemai01 | 2025-05-18 | Update                     |
| 9fd1a98 | Peemai01 | 2025-05-18 | rename                     |
| 86796dd | Peemai01 | 2025-05-18 | debug , remake app         |
| 852b928 | Peemai01 | 2025-05-17 | fix streamlit              |
| 22ea530 | Peemai01 | 2025-05-17 | fix path                   |
| 7cd1d6c | Peemai01 | 2025-05-17 | add streamlit              |
| 33886eb | Peemai01 | 2025-05-17 | Create jupyter pipeline    |
| c17209a | Peemai01 | 2025-05-17 | Create docker-compose.yml  |
| 64f1812 | Peemai01 | 2025-05-17 | Create make/Docker         |
| 9c66917 | Peemai01 | 2025-05-17 | Create Dockerfile          |
| ad7f8c3 | Peemai01 | 2025-05-17 | Create requirements.txt    |
| b5a4011 | Peemai01 | 2025-05-03 | Update LICENSE             |
| fd60c6e | Peemai01 | 2025-05-03 | Initial commit             |


3. **README Quality:** 
    Total alphabet characters:     4184

4. **Dataset Quality:** 
    [Dataset](#dataset)

### Part 2
1. **Data Visualization:** 
    look at [Streamlit Interface](#streamlit-interface)
2. **Machine Learning Application:**
    look at [Streamlit Interface](#streamlit-interface)




