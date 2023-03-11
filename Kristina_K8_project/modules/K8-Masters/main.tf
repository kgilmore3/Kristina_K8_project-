#Create Master Nodes (MN) Host
resource "aws_instance" "K8-MN-Server" {
  ami                    = var.ami
  instance_type          = var.inst-type
  vpc_security_group_ids = [var.K8-sg]
  subnet_id              = var.prvsubnet
  key_name               = var.kp
  count                  = var.instance_count
 
  tags = {
    Name = "${var.MN-host}${count.index}"
  }
}


