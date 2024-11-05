# docker-galaxy-pyclone

## Overview
`docker-galaxy-pyclone` is a project that integrates the PyClone-VI tool with Galaxy Docker.

## Features
- **Clonal Evolution Analysis**: Analyze clonal evolution in cancer samples.
- **Cluster Prevalence Plotting**: Visualize cluster prevalence over samples.
- **Docker Integration**: Easily deploy and run the tool in a Docker container.

## Requirements
- Docker

## Installation
1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/docker-galaxy-pyclone.git
    cd docker-galaxy-pyclone
    ```

2. Build the Docker image:
    ```sh
    docker build -t galaxy-pyclone .
    ```

## Configuration

Set the following environment variables to configure the Galaxy instance and PyClone-VI tool:

```sh
export GALAXY_URL='http://your-galaxy-instance-url'
export PYLONE_API_KEY='your-pyclone-api-key'
export PYLONE_DATA_PATH='/path/to/your/data'
```

## Usage
1. Run the Docker container:
    ```sh
    docker run -p 8081:8081 -e GALAXY_URL -e PYLONE_API_KEY -e PYLONE_DATA_PATH galaxy-pyclone
    ```

2. Access the Galaxy instance at `http://localhost:8081`.


