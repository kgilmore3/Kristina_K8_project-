# Kristina_K8_project

This is a guide for setting up a Kubernetes cluster in AWS with Ansible. The resources are created using Terraform and then Ansible is used to provision the Kubernetes cluster. This uses kubeadm for installation. Requirements • AWS account with credentials • Terraform installed on your system • Ansible installed on your system Usage Terraform

Run terraform init to initialize the working directory and terraform apply to apply the changes and create the AWS resources. Resources Created VPC Infrastructure A VPC infrastructure is created with the following resources: • VPC • Public subnet 1 • Public subnet 2 • Internet gateway • Route table for public subnets • Route table associations for public subnets • Security group EC2 Instances The following EC2 instances are created: • Master server • Worker servers (2) • Ansible server Load Balancer A Jenkins load balancer is created with the following resources: • Load balancer • Load balancer listener • Target group • Target group attachment
Workflow

Once the infrastructure is created the user data from the Ansible Node will be trigger the playbooks to deploy the initial application Playbook #1 installation.yml - Using docker as container runtime, Kubernetes is installed on the master node and worker nodes 
Playbook #2 main-master - Configures Kubernetes on the master node 
Playbook #3 member-master - joins the two other master nodes to the main-master 
Playbook #4 join-workers - Configures the worker node and joins them to the cluster 
Playbook #5 HA-Proxy - the Load balancer between Master Nodes



Jenkins will pull source code from GitHub and deploy into cluster for CD/CD
