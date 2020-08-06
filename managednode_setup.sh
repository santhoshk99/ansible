#!/bin/bash
echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sed -i -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/g' -e 's/PasswordAuthentication no/#PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo useradd ansible
echo -e "Success@99\nSuccess@99" | passwd ansible
sudo service sshd restart
