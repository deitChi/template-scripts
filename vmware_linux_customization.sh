#!/bin/sh
# The following Command must be run against the template first
# vmware-toolbox-cmd config set deployPkg enable-custom-scripts true
# Test with:
# vmware-toolbox-cmd config get deployPkg enable-custom-scripts

extend_partition () {
	growpart /dev/sda 3
	pvresize /dev/sda3
	lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
	resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
}

if [ x$1 = x"precustomization" ]; then
    echo "Do Precustomization tasks"
	extend_partition
elif [ x$1 = x"postcustomization" ]; then
    echo "Do Postcustomization tasks"
fi