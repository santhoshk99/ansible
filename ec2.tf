resource "aws_key_pair" "ec2key" {
  key_name = var.kname
  public_key = tls_private_key.keys.public_key_openssh
}

resource "tls_private_key" "keys" {
  algorithm = "RSA"
}

resource "aws_instance" "ec2control" {
  ami = "ami-07c8bc5c1ce9598c3"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  key_name = aws_key_pair.ec2key.key_name

  tags = merge(local.project_tags, {Name = "Controller Node"})

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y python",
      "sudo yum install -y python-pip",
      "sudo pip install ansible",
      "sudo useradd ansible"
    ]

    connection {
      type = "ssh"
     user = "ec2-user"
     private_key = tls_private_key.keys.private_key_pem
     host = self.public_ip
    }

  }
}

output "key" {
  value = tls_private_key.keys.private_key_pem
}

output "public" {
  value = tls_private_key.keys.public_key_openssh
}
