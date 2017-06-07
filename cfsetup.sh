#!/bin/bash

sudo apt-get update

sudo apt-get install -q -y git unzip curl
cd ~vagrant

git clone https://github.com/cloudfoundry/bosh-lite

git clone https://github.com/cloudfoundry/cf-release

sudo gem install bundler --pre

wget https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.8/spiff_linux_amd64.zip

unzip spiff_linux_amd64.zip

sudo mv spiff /usr/local/bin/

cd cf-release

./scripts/update

git checkout tags/v226

./bin/add-route

bosh login admin admin 
bosh target 192.168.69.4 lite

bosh upload release releases/cf-226.yml

cd ../bosh-lite

./bin/add-route
./bin/provision_cf

bosh upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent\?v\=3312.12

sudo ~/cf-release/scripts/generate-bosh-lite-dev-manifest

bosh deployment /home/vagrant/cf-release/bosh-lite/deployments/cf.yml


echo "yes" | bosh deploy 

sudo chown -R vagrant:vagrant ~vagrant
