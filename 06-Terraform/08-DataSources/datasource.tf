terraform {
  backend "local" {
   path = "/var/tmp/terraform-local-backend/terraform.tfstate"
  }
}

provider "aws" {
   region = var.region
   version = ">=3.7,<=3.11"
}

variable "region" {
  default = "us-east-2"
}

data "aws_availability_zones" "zones_east" {}

data "aws_ami" "myami" {
  most_recent = true
  owners = ["amazon"]
 
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
}
}

resource "aws_instance" "dev-app" {
   ami= data.aws_ami.myami.id
   availability_zone = data.aws_availability_zones.zones_east.names[count.index]   
   instance_type = "t2.micro"
   count = 2
   lifecycle {
     create_before_destroy = true
}
   tags = {
     Name = "Dev-app-test"
}
}

output "frontend_public_ips" {
  value = aws_instance.dev-app.*.public_ip
}

