provider "aws" {
 region = "eu-west-1"
}

resource "aws_instance" "example" {
 ami = "ami-01720b5f421cf0179"
 instance_type = "t2.micro"
}

