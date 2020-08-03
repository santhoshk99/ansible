#!/bin/bash
echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sed -i -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/g' -e 's/PasswordAuthentication no/#PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo yum install -y python
sudo yum install -y python-pip
sudo pip install ansible
sudo useradd ansible
echo -e "Success@123\nSuccess@123" | passwd ansible
