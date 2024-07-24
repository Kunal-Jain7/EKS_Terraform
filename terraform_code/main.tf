terraform {
  backend "s3" {
    bucket = "terraform-k8s-project"
    key    = "devops-project/kubernetes/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "vpc" {
  source = "./vpc"

  instance_tenancy        = "default"
  vpc_cidr                = local.vpc_cidr
  vpc_name                = local.vpc_name
  access_ip               = "0.0.0.0/0"
  public_sn_count         = 2
  public_cidrs            = local.public_cidrs
  map_public_ip_on_launch = true
  rt_route_cidr_block     = "0.0.0.0/0"
  stack_env               = local.stack_env
  eu_availibility_zone    = local.eu_availibility_zone
}

module "eks" {
  source = "./eks"

  aws_public_subnet       = module.vpc.public_subnet
  vpc_id                  = module.vpc.vpc_id
  endpoint_public_access  = true
  endpoint_private_access = false
  public_access_cidrs     = ["0.0.0.0/0"]
  node_group_name         = "eksnodegroup"
  scaling_desired_size    = 1
  scaling_max_size        = 1
  scaling_min_size        = 1
  instance_types          = ["t3.large"]
  key_pair                = "K8s_Mac_Kubernetes"
  stack_env               = local.stack_env
}
