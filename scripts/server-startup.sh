#!/bin/bash -xe

sudo apt update
sudo apt install unzip

# Download Consul
sudo wget https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip
sudo unzip consul_1.2.2_linux_amd64.zip

# Move Consul and Create Data Directory
sudo mv consul /usr/bin/consul
sudo mkdir /etc/consul.d
sudo chmod a+w /etc/consul.d

# Download Nomad
sudo wget https://releases.hashicorp.com/nomad/0.8.4/nomad_0.8.4_linux_amd64.zip
sudo unzip nomad_0.8.4_linux_amd64.zip

# Move Nomad and Create Data Directory
sudo mv nomad /usr/bin/nomad
sudo mkdir -p /etc/nomad.d
sudo chmod a+w /etc/nomad.d

sudo bash -c 'cat <<EOF > /etc/nomad.d/server.hcl
data_dir = "/etc/nomad.d"
server {
  enabled          = true
  bootstrap_expect = 3
}
EOF'

consul agent -server -bootstrap-expect=3 \
    -data-dir=/tmp/consul \
    -enable-script-checks=true -config-dir=/etc/consul.d \
    -retry-join "provider=gce tag_value=consul-server" &

nomad agent -config=/etc/nomad.d/server.hcl