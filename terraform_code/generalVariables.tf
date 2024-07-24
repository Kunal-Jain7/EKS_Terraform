locals {
  stack_env = terraform.workspace
  vpc_cidr = lookup(
    var.vpc_cidr,
    terraform.workspace,
    var.vpc_cidr[var.default_value],
  )
  vpc_name = lookup(
    var.vpc_name,
    terraform.workspace,
    var.vpc_name[var.default_value],
  )
  public_cidrs = lookup(
    var.public_cidrs,
    terraform.workspace,
    var.public_cidrs[var.default_value],
  )
  eu_availibility_zone = lookup(
    var.eu_availibility_zone,
    terraform.workspace,
    var.eu_availibility_zone[var.default_value],
  )
}

variable "default_value" {
  description = "This is the default value for every variables"
  default     = "default"
}

variable "vpc_cidr" {
  type = map(string)
  default = {
    prod    = ""
    preprod = ""
    default = "10.0.0.0/16"
  }
}

variable "vpc_name" {
  default = {
    default = "kubernetes-terraform-vpc"
  }
}

variable "public_cidrs" {
  type = map(list(string))
  default = {
    prod    = [""]
    preprod = [""]
    default = ["10.0.1.0/24", "10.0.2.0/24"]
  }
}

variable "eu_availibility_zone" {
  description = "Availability Zone details"
  type        = map(list(string))
  default = {
    prod    = [""]
    preprod = [""]
    default = ["eu-west-1a", "eu-west-1b"]
  }
}