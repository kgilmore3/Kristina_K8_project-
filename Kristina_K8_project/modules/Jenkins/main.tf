#Create Jenkins Server
resource "aws_instance" "K8_Jenkins_Server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.security_id]
  subnet_id                   = var.prvsubnet
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = <<-EOF
#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt-get update wget maven git default-jre -y
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get upgrade -y
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
EOF

tags = {
    Name = "Jenkins"
  }
}
    