AWS VPC module
=======================================

Terraform module which creates/manages AWS VPC with public and private subnets, route tables, NAT's, Internet Gateways and Bastion hosts. 

Usage
-----

```hcl
module "vpc" {
  source = "../../../modules/aws/vpc"
  bastion_ssh_public_key = "${var.bastion_ssh_public_key}"
}
````

Parameters
-----

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| azs | Run the EC2 Instances in these Availability Zones | list | `<list>` | no |
| bastion\_ami | AMI for bastion host, if not defined Latest Amazon Linux 2 will be used | string | `false` | no |
| bastion\_host | Feature toggle for bastion host creation | string | `true` | no |
| bastion\_instance\_type | Instance type for bastion host | string | `t2.micro` | no |
| bastion\_ssh\_access\_cidr | List of cidrs with SSH access to bastion host | list | `<list>` | no |
| bastion\_ssh\_public\_key | Public ssh key for bastion host login | string | - | yes |
| environment | Environment name, used for tagging | string | `production` | no |
| private\_cidrs | Use these CIDRs for subnets | list | `<list>` | no |
| project | Project name, used for tagging | string | `platform` | no |
| public\_cidrs | Use these CIDRs for subnets | list | `<list>` | no |
| vpc\_cidr\_block | VPC cidr block | string | `172.31.0.0/16` | no |
| vpc\_enable\_dns\_hostnames | Feature toggle for managing DNS hostnames support | string | `true` | no |
| vpc\_enable\_dns\_support | Feature toggle for managing DNS support | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_subnet\_private\_ids | - |
| aws\_subnet\_public\_ids | - |
| bastion\_private\_ip | - |
| bastion\_public\_ip | - |
| id | - |
| vpc\_cidr | - |