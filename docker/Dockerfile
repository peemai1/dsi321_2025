FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy everything from current directory into /app inside container
COPY . /app

# Install Python packages including a specific version of lakefs-client
# Using version 0.91.0 which should be compatible with lakeFS 1.7.0
# Adding fsspec and s3fs for remote storage access
# RUN pip install --no-cache-dir streamlit pandas numpy plotly lakefs-client==0.91.0 fsspec s3fs pyarrow openai
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Expose the port Streamlit will run on
EXPOSE 8503

# Command to run when the container starts
CMD ["streamlit", "run", "app.py", "--server.port=8503", "--server.enableCORS=false"]

# == Point Docket to this Dockerfile , build Docker image ==
# docker build -f docker/Dockerfile -t my-streamlit-prefect-app .

# == Rebuild the Docker image ==
# docker build -t my-streamlit-prefect-app .

# == Run the container ==
# docker run -p 8503:8503 my-streamlit-prefect-app
