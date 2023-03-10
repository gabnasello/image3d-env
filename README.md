# Image3D-env - Docker Image for processing 3D biomedical images

# Build the Docker Image

From the project folder, run the command below:

```bash build.sh```

# Run Docker container

## Docker-compose approach (recommended)

Be aware that the user ```researhcer``` within you Docker container won't share the same ID as the host user!

From the project folder, run the command below:

```docker-compose up -d```

To connect to a container that is already running ("image3d" is the service name):

```docker-compose exec image3d bash```

Close the container with:

```docker-compose down```


## Alternative approach

You can run the following command:

```docker run -d -it --rm  -p 8888:8888 --volume $HOME:/home/sliceruser/work --entrypoint /bin/bash --user root --name image3d gnasello/image3d-env:latest```

To connect to a container that is already running ("slicer" is the container name):

```docker exec -it image3d /bin/bash```

After use, you close the container with:

```docker rm -f image3d```

# Acknowledgements

This Docker is built on [slicer/slicer-notebook](https://hub.docker.com/r/slicer/slicer-notebook)