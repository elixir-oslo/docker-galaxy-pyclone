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

## Adding a tool

Two files need to be modified to add a tool.
1. config/tool_conf.xml
Follow the official documentation to add your tool: https://docs.galaxyproject.org/en/master/admin/tool_panel.html
2. Dockerfile
If your tool is not part of Galaxy toolshed you need to add the wrapper and code to the Docker images.
For example, with Pyclone-VI:
```sh
# Clone Pyclone-VI tools from GitHUb
RUN git clone https://github.com/jCHENEBY/galaxy-tool-pyclone-vi.git /galaxy/server/tools/pyclone_vi
RUN chown -R galaxy:galaxy /galaxy/server/tools/pyclone_vi
```

This Docker image uses conda to install requirements from the tool XML file, so you don't need to modify the Dockerfile further.
