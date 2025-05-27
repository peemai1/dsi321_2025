## Data Schema

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
last week

new changes
| precipitation       | float32                       | Total precipitation (sum of rainfall and snowfall)    |
last week

new changes
| year                | category                      | Year component of the timestamp (for partitioning)    |
| month               | category                      | Month component of the timestamp (for partitioning)   |
| day                 | category                      | Day component of the timestamp (for partitioning)     |
| hour                | category                      | Hour component of the timestamp (for partitioning)    |


## Storage Structure
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

