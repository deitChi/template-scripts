#!/bin/bash

# Instruction taken from Guide
# https://medium.com/@dsykes012/making-a-custom-ubuntu-20-04-lts-focal-fossa-vm-template-that-works-with-cloud-init-2cfffb6783b4

# Ensure Root

# to be added

# Update
apt update && apt upgrade -y && apt autoremove -y && apt clean

# Clear Hostname
truncate -s0 /etc/hostname
hostnamectl set-hostname localhost

# Clear Machine ID
truncate -s0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Reset cloud-init trigger
cloud-init clean

# Clear Shell History for root
truncate -s0 ~/.bash_history
history -c

# Shutdown
poweroff
