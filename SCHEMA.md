Data Schema
---

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

