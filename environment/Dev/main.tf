module "vpc" {
  source = "../../modules/vpc"
}

module "sg" {
  source   = "../../modules/sg"
  k8-vpc = module.vpc.vpc_id
}

module "keypair" {
  source = "../../modules/keypair"
}

module "ec2_iam" {
  source = "../../modules/ec2_iam"
}

module "Bastion" {
  source     = "../../modules/Bastion"
  ami        = var.ami
  bastion-sg = module.sg.bastion-sg-id
  pubsubnet  = module.vpc.pubsn1-id
  key_name   = module.keypair.keypair_id
}

module "K8-Masters" {
  source    = "../../modules/K8-Masters"
  ami       = var.ami
  K8-sg     = module.sg.mast-wor-sg-id
  prvsubnet = module.vpc.prvsn1-id
  kp        = module.keypair.keypair_id
}

module "K8-Workers" {
  source    = "../../modules/K8-Workers"
  ami       = var.ami
  K8-sg     = module.sg.mast-wor-sg-id
  prvsubnet = module.vpc.prvsn2-id
  kp        = module.keypair.keypair_id
}

module "HA-Proxy" {
  source      = "../../modules/HA-Proxy"
  ami         = var.ami
  security_id = module.sg.mast-wor-sg-id
  prvsubnet   = module.vpc.prvsn1-id
  key_name    = module.keypair.keypair_id
  Master1     = module.K8-Masters.mn_privateip[0]
  Master2     = module.K8-Masters.mn_privateip[1]
  Master3     = module.K8-Masters.mn_privateip[2]
}

module "Ansible" {
  source      = "../../modules/Ansible"
  ami         = var.ami
  ansible-sg  = module.sg.ansible-sg-id
  prvsubnet   = module.vpc.prvsn1-id
  kp          = module.keypair.keypair_id
  mn_priv_ip1 = module.K8-Masters.mn_privateip[0]
  mn_priv_ip2 = module.K8-Masters.mn_privateip[1]
  mn_priv_ip3 = module.K8-Masters.mn_privateip[2]
  wn_priv_ip1 = module.K8-Workers.wn_privateip[0]
  wn_priv_ip2 = module.K8-Workers.wn_privateip[1]
  HA_priv_ip = module.HA-Proxy.HAProxy-privateip
  iam-profile = module.ec2_iam.iam-profile-name
  bashion_public_ip = module.Bastion.Bastion_publicip 
}

resource "null_resource" "ansible_configure" {
  connection {
    type                = "ssh"
    host                = module.Ansible.ansible_privateip
    user                = "ubuntu"
    private_key         = file("~/keypairs/K8-kp")
    bastion_host        = module.Bastion.Bastion_publicip
    bastion_user        = "ubuntu"
    bastion_private_key = file("~/keypairs/K8-kp")
  }
  provisioner "file" {
    source      = "~/Kristina_K8_project/environment/Dev/playbooks" 
    destination = "/home/ubuntu/playbooks"
  }
  provisioner "file" {
    source      = "~/keypairs/K8-kp"
    destination = "/home/ubuntu/K8-kp"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ansible",
      "sudo chmod 400 /home/ubuntu/K8-kp"
    ]
  }
}

module "Jenkins" {
  source             = "../../modules/Jenkins"
  ami                = var.ami
  security_id        = module.sg.jenkins-sg-id
  prvsubnet          = module.vpc.prvsn1-id
  key_name           = module.keypair.keypair_id
}

module "Jenkins-ElasticLB" {
  source           = "../../modules/Jenkins-ElasticLB"
  subnet_id1        = module.vpc.pubsn1-id
  subnet_id2        = module.vpc.pubsn2-id
  securitygroup_id = module.sg.alb-sg-id
  instance_id      = module.Jenkins.jenkins_id
}

module "App_LB" {
  source = "../../modules/App_LB" 
  lb_sg = module.sg.alb-sg-id 
  lb_subnet1 = module.vpc.pubsn1-id 
  lb_subnet2 = module.vpc.pubsn2-id 
  vpc = module.vpc.vpc_id 
  lb_instance = module.K8-Workers.WN_host_id
}

module "AWS-ACM" {
  source = "../../modules/AWS-ACM"
  lb_arn = module.App_LB.lb_arn
  lb_target_arn = module.App_LB.lb-tg
}

module "ASG" {
  source = "../../modules/ASG" 
  asg_subnet = module.vpc.pubsn1-id   
  asg_subnet2 = module.vpc.pubsn2-id
  ami_source_instance = module.K8-Workers.WN_host_id[0]
  sg_name =  module.sg.mast-wor-sg-id
  keypair = module.keypair.keypair_name
  lc_instancetype = var.instance_type 
  lb_tg_arn = module.App_LB.lb-tg
} 

module "Route53" {
  source      = "../../modules/Route53"
  lb_dns     = module.App_LB.lb_dns
  lb_zoneid  = module.App_LB.lb_zoneID
}
