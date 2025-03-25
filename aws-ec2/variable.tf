variable "aws_ec2_instance_type" {
  default = "t2.micro"
  type    = string
}

variable "aws_root_storage_size" {
  default = 15
  type    = number
}

variable "aws_ec2_ami_id" {
  default = "ami-084568db4383264d4"
  type    = string
}

variable "aws_root_storage_type" {
  default = "gp3"
  type    = string
}
