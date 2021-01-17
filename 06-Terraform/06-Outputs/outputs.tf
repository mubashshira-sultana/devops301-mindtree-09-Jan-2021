provider "aws" {
   region = "us-east-2"
   version = ">=3.7,<=3.11"
}

resource "aws_instance" "backend" {
  ami           = "ami-0a0ad6b70e61be944"
  instance_type = "t2.micro"
  count = 2
 
 lifecycle {
   prevent_destroy = false
}

}

resource "aws_instance" "frontend" {
#  ami= "ami-0ebc8f6f580a04647"
   ami= "ami-0a0ad6b70e61be944"
  instance_type = "t2.micro"
  depends_on = [aws_instance.backend]

  lifecycle {
    create_before_destroy = true
}

}

output "backend_public_ips" {

  value = aws_instance.backend.*.public_ip
}

output "backend_public_dns" {
  value = aws_instance.backend.*.public_dns
}

output "frontend_public_ips" {
  value = aws_instance.frontend.*.public_ip
}

output "backend_ips" {
  value = "${list(aws_instance.backend.*.public_ip, aws_instance.backend.*.private_ip)}"
} 
