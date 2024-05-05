#TBC

resource "aws_instance" "sample_server" {
  ami           = "ami-07edc58546d708802"
  instance_type = "t2.micro"

  tags = {
    Name = "Tines Sample EC2 Instance"
  }
}
