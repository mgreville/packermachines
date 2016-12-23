#!/bin/sh

curl -k https://puppet.grevco.org:8140/packages/current/install.bash | bash
mkdir -p /etc/puppetlabs/facter/facts.d
echo 'role: standard' > /etc/puppetlabs/facter/facts.d/role.yaml 

