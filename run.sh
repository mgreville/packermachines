#!/bin/bash

BUILD_NUMBER=${BUILD_NUMBER:-0}

#This creates the server1.iso used for the cloud-init first boot configuration
./mk.cloudinit.image.sh --hostname server-${BUILD_NUMBER} --ssh-key ~/.ssh/id_rsa.pub \
--user-data userdata.set.role.sh server-${BUILD_NUMBER}.iso

if [ -d output_centos ]; then rm -fr output_centos; fi

packer build centos.7.builder.packerfile

cp tdhtest /var/lib/libvirt/servers/server-${BUILD_NUMBER}

#Need to remove the need for sudo here
sudo virt-install -n server-${BUILD_NUMBER} --network bridge=kvmbr0 --os-type linux -r 1024 \
--disk /var/lib/libvirt/servers/server-${BUILD_NUMBER} \
--import --disk path=server-${BUILD_NUMBER}.iso,device=cdrom

