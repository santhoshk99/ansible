#!/bin/bash
echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sed -i -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/g' -e 's/PasswordAuthentication no/#PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo yum install -y python
sudo yum install -y python-pip
sudo pip install ansible
sudo useradd ansible
echo -e "Success@123\nSuccess@123" | passwd ansible
sudo mkdir /home/ansible/.ssh
sudo chmod -R 777 /home/ansible/.ssh/
sudo su - ansible
ansibleHome="/home/ansible"		# Mention home directory of ansible user
test -f $ansibleHome/.ssh/id_rsa || echo | ssh-keygen -t rsa -f $ansibleHome/.ssh/id_rsa  	# Create a rsa file if not exist already
file="$ansibleHome/ip.txt"
echo "172.31.21.192" >> /home/ansible/ip.txt 
sudo su -c "while IFS= read -r line; do ip=$line;echo -e Success@99 |sudo ssh-copy-id $ip; done < $file" ansible
