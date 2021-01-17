provider "aws" {
   region = "us-east-2"
   version = ">=3.7,<=3.11"
}

resource "aws_instance" "backend" {
  ami           = "ami-0a0ad6b70e61be944"
  instance_type = "t2.micro"
  count = 2
}

resource "aws_instance" "frontend" {
  ami= "ami-0a0ad6b70e61be944"
  instance_type = "t2.micro"
  depends_on = [aws_instance.backend]
} 
