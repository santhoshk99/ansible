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
  user_data = file("hi.sh")

  tags = merge(local.project_tags, {Name = "Controller Node"})
}


output "key" {
  value = tls_private_key.keys.private_key_pem
}

output "public" {
  value = tls_private_key.keys.public_key_openssh
}
