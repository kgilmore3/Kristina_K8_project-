
output "Bastion_publicip" {
  value = module.Bastion.Bastion_publicip
}

output "Worker_privateip" {
  value = module.K8-Workers.wn_privateip
}

output "Master_privateip" {
  value = module.K8-Masters.mn_privateip
}

output "Ansible_privateip" {
  value = module.Ansible.ansible_privateip
}

output "Jenkins_privateip" {
  value = module.Jenkins.jenkins_privateip
}

output "HAProxy-lB" {
  value = module.HA-Proxy.HAProxy-id
}

output "HAProxy-privateip" {
  value = module.HA-Proxy.HAProxy-privateip
}

output "Jenkins-ElasticLB" {
  value = module.Jenkins-ElasticLB.jenkins-lb
}

output "Route53" {
  value = module.Route53.nameservers
}

output "App_LB" {
  value = module.App_LB.lb_dns
}




