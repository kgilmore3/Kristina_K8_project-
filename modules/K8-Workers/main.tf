#Create Worker Nodes (WN) Host
resource "aws_instance" "K8-WN-Server" {
  ami                    = var.ami
  instance_type          = var.inst-type
  vpc_security_group_ids = [var.K8-sg]
  subnet_id              = var.prvsubnet
  key_name               = var.kp
  count                  = var.instance_count
 
  tags = {
    Name = "${var.WN-host}${count.index}"
  }
}


