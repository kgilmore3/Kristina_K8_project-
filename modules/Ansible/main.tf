resource "aws_instance" "K8_Ansible-Server" {
  ami                         = var.ami
  instance_type               = var.inst-type
  key_name                    = var.kp
  vpc_security_group_ids      = [var.ansible-sg]
  subnet_id                   = var.prvsubnet
  iam_instance_profile        = var.iam-profile
  associate_public_ip_address = true
  user_data                   = <<-EOF
#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt-get update -y 
sudo apt install python3-pip -y
sudo pip3 install boto boto3 botocore
sudo apt-add-repository ppa:ansible/ansible 
sudo apt-get install ansible -y
sudo -i
sudo chown ubuntu:ubuntu /etc/ansible/hosts
sudo chown -R ubuntu:ubuntu /etc/ansible && chmod +x /etc/ansible
sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
sudo chmod 400 /home/ubuntu/K8-kp
sudo chmod 777 /etc/ansible/hosts
sudo touch /home/ubuntu/playbooks/ha-ip.yml
sudo echo ha_prv_ip: "${var.HA_priv_ip}" >> /home/ubuntu/playbooks/ha-ip.yml
sudo echo "[HAProxy]" >> /etc/ansible/hosts
sudo echo "${var.HA_priv_ip} ansible_ssh_private_key_file=/home/ubuntu/K8-kp" >> /etc/ansible/hosts
sudo echo "[Main-Master]" >> /etc/ansible/hosts
sudo echo "${var.mn_priv_ip1} ansible_ssh_private_key_file=/home/ubuntu/K8-kp" >> /etc/ansible/hosts
sudo echo "[Member-Masters]" >> /etc/ansible/hosts
sudo echo "${var.mn_priv_ip2} ansible_ssh_private_key_file=/home/ubuntu/K8-kp" >> /etc/ansible/hosts
sudo echo "${var.mn_priv_ip3} ansible_ssh_private_key_file=/home/ubuntu/K8-kp" >> /etc/ansible/hosts
sudo echo "[Workers]" >> /etc/ansible/hosts
sudo echo "${var.wn_priv_ip1} ansible_ssh_private_key_file=/home/ubuntu/K8-kp" >> /etc/ansible/hosts
sudo echo "${var.wn_priv_ip2} ansible_ssh_private_key_file=/home/ubuntu/K8-kp" >> /etc/ansible/hosts
sudo su -c 'ansible-playbook -i /etc/ansible/hosts /home/ubuntu/playbooks/installation.yml' ubuntu
sudo su -c 'ansible-playbook -i /etc/ansible/hosts /home/ubuntu/playbooks/main-master.yml' ubuntu
sudo su -c 'ansible-playbook -i /etc/ansible/hosts /home/ubuntu/playbooks/member-master.yml' ubuntu
sudo su -c 'ansible-playbook -i /etc/ansible/hosts /home/ubuntu/playbooks/join-workers.yml' ubuntu
sudo su -c 'ansible-playbook -i /etc/ansible/hosts /home/ubuntu/playbooks/HA-lb.yml' ubuntu
sudo su -c 'ansible-playbook -i /etc/ansible/hosts /home/ubuntu/playbooks/ReadyMade_helm.yml' ubuntu
EOF
tags = {
    Name = "Ansible"
  }
}
