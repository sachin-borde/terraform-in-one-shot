# key pair
resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("/root/.ssh/id_ed25519.pub")
}


#vpc for security group
resource "aws_default_vpc" "default_vpc" {

}

resource "aws_security_group" "security_group" {
  name        = "automate-sg"
  description = "this is the default security group"
  vpc_id      = aws_default_vpc.default_vpc.id

  #inbound rule

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Cuctom port open"
  }

  #outbound rule

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access all"
  }

  tags = {
    Name = "automate-sg"
  }
}

# ec2_instance

resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.security_group.name]
  instance_type   = var.aws_ec2_instance_type
  ami             = var.aws_ec2_ami_id
  user_data       = file("/home/workspace/VSCODE/aws-ec2/install_ngnix.sh")

  root_block_device {
    volume_size = var.aws_root_storage_size
    volume_type = var.aws_root_storage_type
  }

  tags = {
    Name = "sachin-automate"
  }

}
