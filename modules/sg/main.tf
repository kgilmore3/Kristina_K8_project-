
#Create Security Group for Ansible
resource "aws_security_group" "K8_Ansible_SG" {
  name        = "${var.name}-Ansible-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.k8-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Ansible_SG"
  }
}

#Create Security Group for Jenkins
resource "aws_security_group" "K8_Jenkins_SG" {
  name        = "${var.name}-Jenkins-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.k8-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Jenkins_SG"
  }
}

#Create Security Group for LC ALB
resource "aws_security_group" "K8_ALB_SG" {
  name        = "${var.name}-ALB-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.k8-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

   ingress {
    description = "Allow http access"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.cluster_port
    to_port     = var.cluster_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

    ingress {
    description = "Allow inbound traffic"
    from_port   = var.https_lb
    to_port     = var.https_lb
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-ALB_SG"
  }
}

#Create Security Group for Bastion
resource "aws_security_group" "K8_bastion_SG" {
  name        = "${var.name}-bastion-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.k8-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

    ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-bastion_SG"
  }
}

# Security group for master and worker
resource "aws_security_group" "K8_Mast_Wor_SG" {
  name        = "${var.name}-Mast_Wor_sg"
  description = "traffic"
  vpc_id      = var.k8-vpc

  ingress {
    description = "Allow access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.https_lb]
  }
   ingress {
    description = "Allow access"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [var.https_api]
  }

    ingress {
    description = "Allow access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.http_port]
    }
      ingress {
    description = "Allow access"
    from_port   = 30220
    to_port     = 30220
    protocol    = "tcp"
    cidr_blocks = [var.cluster_port]
      }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-_SG"
  }
}
