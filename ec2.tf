resource "aws_instance" "murkulu" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.web.id]

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>Welcome to Murkulu!</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = "Murkulu-Web-Server"
  }
}