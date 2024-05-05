#TBC

resource "aws_instance" "sample_server" {
  ami           = "ami-07edc58546d708802"
  instance_type = "t2.micro"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y aws-cli jq curl
              DD_API_KEY=$(aws secretsmanager get-secret-value --secret-id datadog_api_key)
              DD_SITE="datadoghq.com"  bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
              EOF

  tags = {
    Name = "Tines Sample EC2 Instance"
  }
}
