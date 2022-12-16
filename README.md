# docker-ckpool

Run your own ckpool solo instance in a docker container

## First steps

1. Install Docker (see https://docs.docker.com/engine/install/ for details)
2. Clone this repository: `git clone https://github.com/golden-guy/docker-ckpool.git`
3. Build the container image with `./build_image.sh` or use a custom build command: `docker build -t docker-ckpool:latest .`

### Configuration
The pool configuration file is located in conf/ckpool.conf
 - Amend the pool configuration for your bitcoind instance. For a local instance, you just need to set the correct RPC credentials.
 - Set the donation rate and address - or even disable donation.

`donaddress=<BTC_ADDRESS>`

`donrate=1 (-> 1% donation)`

`donrate=0 (-> disable donation)`

 
To make a local bitcoind available to the docker container, add these two lines to bitcoin.conf to bind it to the docker host gateway address:

`rpcbind=172.17.0.1`

`zmqpubhashblock=tcp://172.17.0.1:28332`

### Container quick-start

Create and start the container with `docker compose up -d`

- To stop the container use `docker compose stop`
- To start the container use `docker compose start`
- Whenever you need to change the ckpool conf, stop the container first. Once done with your changes, start the container again.
