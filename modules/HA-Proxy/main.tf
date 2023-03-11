#Create HA-Proxy Server Server
resource "aws_instance" "K8_HA-Proxy-Server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.security_id]
  subnet_id                   = var.prvsubnet
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = <<-EOF
#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo -i
apt-get update -y
apt-get upgrade -y
apt install --no-install-recommends software-properties-common
add-apt-repository ppa:vbernat/haproxy-2.4 -y
apt install haproxy=2.4.\* -y 
haproxy -v
sudo bash -c 'echo "
frontend fe-apiserver
bind 0.0.0.0:6443
mode tcp
option tcplog
default_backend be-apiserver

backend be-apiserver
mode tcp
option tcplog
option tcp-check
balance roundrobin
default-server inter 10s downinter 5s rise 2 fall 2 slowstart 60s maxconn 250 maxqueue 256 weight 100

    server master1 ${var.Master1}:6443 check
    server master2 ${var.Master2}:6443 check
    server master3 ${var.Master3}:6443 check" > /etc/haproxy/haproxy.cfg'
systemctl restart haproxy
hostnamectl set-hostname HA-LB-node
EOF

  tags = {
    Name = "HA-LB"
  }
}


