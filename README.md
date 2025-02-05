# Sonatype: Nexus 3
              
# Nexus Docker Setup
This repository provides a Docker setup for Sonatype Nexus Repository Manager (version 3.72.0-04) running on Alpine Linux. The setup includes necessary configurations, user creation scripts, and a custom entrypoint for initializing Nexus.

# Overview
    Dockerfile: Installs Nexus and OpenJDK 17, sets environment variables, and prepares the necessary directories and user permissions.
    User Creation: A script automatically creates a user after Nexus is fully initialized. The user has admin roles by default.
    Entrypoint: The custom entrypoint script starts Nexus, waits for it to be fully up, and then triggers the user creation script.

## Build the Docker Image
Clone the repository and build the Docker image:
  ```
  docker build -t <your-image-name> .
  ```
## Push to Azure Container Registry (ACR)
To push the Docker image to Azure Container Registry (ACR), first tag your image with the ACR repository name:
  ```
  docker tag <your-image-name> <your-acr-name>.azurecr.io/<your-image-name>:<tag>
  ```
Then, push the image:
  ```
  docker push <your-acr-name>.azurecr.io/<your-image-name>:<tag>
  ```
## Running the Container
Simply run the Docker container to get Nexus up and running. The user creation script will run automatically once Nexus is available.
  ```
  docker run -d -p 8081:8081 --name nexus-repository <your-image-name>
  ```
