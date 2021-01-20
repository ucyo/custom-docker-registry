#!/usr/bin/sh
sudo docker container stop registry && \
sudo docker container rm -v registry && \
sudo docker run -d -p 5000:5000 --restart=unless-stopped --name registry registry:2.7.1
