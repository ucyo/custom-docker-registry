# Deploy your own Docker Registry

## 0. Prepare VM

Basic setup of the environment and network for a docker registry
```shell
# Install docker
yum install -y yum-utils
yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker
```

Install apache
```
yum install httpd
systemctl start httpd
systemctl enable httpd
```

Install certbot for apache
```
yum install certbot
yum install python2-certbot-apache
```

Create config and restart
```
vim apache.cert.conf
ln -s apache.cert.conf /etc/httpd/conf.d/apache.cert.conf
systemctl restart httpd
```

Try getting certificates
```
certbot certonly --dry-run
```

If error: Check if ports free and are listened to (check company firewalls)
```
netstat -tulpn | grep LISTEN
```

Get certificates
```
certbot certonly --dry-run
```

## Start & stop registry

Start registry
```
docker run -d -p 5000:5000 --name registry registry:2.7.1
```

Stop registry and remove data
```shell
docker container stop registry && docker container rm -v registry
```

## Usage

Usage involves three steps: pull, tag and push. The following shows how to use a local ubuntu docker image.
We assume that the docker registry is running on `localhost:5000`.

1. Pull image from docker hub 
```
docker pull ubuntu
```
2. Tag image with address of registry
```
docker image tag ubuntu localhost:5000/myfirstimage
```
3. Push it to the registry
```
docker push localhost:5000/myfirstimage
```
Now you can use the image with `docker pull localhost:5000/myfirstimage`. 

## Usage from different machine in the network (insecure)

1. Start docker registry on e.g. host machine `docker-registry` with ip `<docker-registry-ip>`
```
docker run -d -p 5000:5000 --name registry registry:2.7.1
```

2. Upload images to the registry as described above
3. Since the registry is currently running unsecure, the guest machine therefore add following lines to `/etc/docker/daemon.json` of the guest machine (assuming registry runs on default port `5000`)
```json
{
    "insecure-registries": ["<docker-registry-ip>:5000"]141.52.184.146:5000
}
```
4. Restart docker on guest machine
5. Pull image from registry
```shell
docker pull <docker-registry-ip>:5000/localubuntu
```


# Resources

- https://docs.docker.com/registry/
- https://docs.docker.com/registry/recipes/nginx/
