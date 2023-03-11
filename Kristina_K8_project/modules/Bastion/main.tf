#Create Bastian Server
resource "aws_instance" "K8-Bastion" {
  ami                         = var.ami
  instance_type               = var.inst-type
  vpc_security_group_ids      = [var.bastion-sg]
  subnet_id                   = var.pubsubnet
  key_name                    = var.key_name
  associate_public_ip_address = true
  provisioner "file" {
    source      = "~/keypairs/K8-kp"
    destination = "/home/ubuntu/K8-kp"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname bastion",
      "sudo chmod 400 /home/ubuntu/K8-kp"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/keypairs/K8-kp")
    host        = self.public_ip
  }
  tags = {
    Name = var.bastion-host
  }

  }