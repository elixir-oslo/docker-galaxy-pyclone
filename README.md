# docker-galaxy-pyclone

## Overview
`docker-galaxy-pyclone` is a project that integrates the PyClone-VI tool with Galaxy Docker. 

## Features
- **Clonal Evolution Analysis**: Analyze clonal evolution in cancer samples.
- **Cluster Prevalence Plotting**: Visualize cluster prevalence over samples.
- **Docker Integration**: Easily deploy and run the tool in a Docker container.


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

## Usage
1. Run the Docker container:
    ```sh
    docker run -p 8081:8081 docker-galaxy-pyclone
    ```

2. Access the Galaxy instance at `http://localhost:8081`.

3. Upload your data and run the PyClone-VI tool. 

For more information on PyClone-IV, refer to the [publication](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-020-03919-2) and [github](https://github.com/Roth-Lab/pyclone-vi).

