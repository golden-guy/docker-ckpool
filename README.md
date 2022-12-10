# docker-ckpool

Run your own ckpool instance in a docker container.

## tl;dr

1. Clone this repository
2. Build the container image with './build_image.sh'

### conf/ckpool.conf
1. Amend the pool configuration for your bitcoind instance. 
2. Set the donation rate and address - or even disable donation.

- donaddress=<BTC_ADDRESS>
- donrate=1 (1% donation)
- donrate=0 (disable donation)
 
To make a local bitcoind available to the docker container, add these two lines to bitcoin.conf:

- rpcbind=172.17.0.1
- zmqpubhashblock=tcp://172.17.0.1:28332

### container 101
Create and start the container with 'docker compose up -d'

- To stop the container use 'docker compose stop'
- To start the container use 'docker compose start'
- When you need to change the ckpool conf, stop the container first. Once done, start the container again.
