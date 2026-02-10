# Introduction

Docker configuration for the [Etherpad](https://github.com/ether/etherpad-lite) application.

# Development with Docker

## Docker installation

A working [Docker](https://docs.docker.com/engine/install/) installation is mandatory.

## Docker environment file

Please make sure to copy & rename the **example.env** file to **.env**.

``cp example.env .env``

You can replace the values if needed, but the default ones should work for local development.

Please also make sure to copy & rename the **docker-compose.override.yml.dev** file to **docker-compose.override.yml**.

`cp docker-compose.override.yml.dev docker-compose.override.yml`

You can replace the values if needed, but the default ones should work for local development.

## Build & run

Build & run all the containers for this project.

``docker compose up`` (add -d if you want to run in the background and silence the logs)

## Frontends

To access the main application please use the following link.

[http://localhost:9001](http://localhost:9001)

To access the administration please use the following link.

[http://localhost:9001/admin](http://localhost:9001/admin)

+ admin / admin

# Deployment with Docker

Copy and rename the environment file.

``cp example.env .env``

You should replace the values since the default ones are not ready for production.

Please also make sure to copy & rename the **docker-compose.override.yml.prod** file to **docker-compose.override.yml**.

`cp docker-compose.override.yml.prod docker-compose.override.yml`

You can replace the values if needed, but the default ones should work for production. You can do the same with the `docker-compose.override.yml.stage` file if your environment is staging.

Build & run all the containers for this project:

`docker compose up -d`

Use a reverse proxy configuration to map the url to port `9001`. Examples can be found in the [wiki of the project](https://github.com/ether/etherpad-lite/wiki/How-to-put-Etherpad-Lite-behind-a-reverse-Proxy).

# Application updates

This application uses a custom build of the Etherpad docker image. We trigger a [GitHub Actions workflow](https://github.com/unil-lettres/etherpad/blob/main/.github/workflows/docker.yml) to build the custom image and push it to our [Docker Hub repository](https://hub.docker.com/repository/docker/unillett/etherpad/general).

When a new [Etherpad version](https://github.com/ether/etherpad-lite/tags) is available, you should update the value in the [VERSION](https://github.com/unil-lettres/etherpad/blob/main/VERSION) file to reference the new tag. When the change is pushed to the repository, the workflow will automatically build the new image and push it to [Docker Hub](https://hub.docker.com/repository/docker/unillett/etherpad/general).

Changes in the `development` branch will create a new image tagged with `stage-latest`, while changes in the `main` branch will create a new image tagged with `latest` and a new image tagged with the version number from the VERSION file.

If you need to trigger a rebuild or mark a custom image version, you can add a revision suffix (such as `-rev1`) to the value in the `VERSION` file. This suffix will be ignored when fetching the Etherpad source code, but it allows you to distinguish builds in your workflow and Docker image tags.