# Terraform module structure

Simple terraform modules and recommendations

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

[Terraform installation](https://www.terraform.io/intro/getting-started/install.html)

### Installing

1. Create S3 bucket for tfstate

Put required values in variables.tf or terraform.tfvars or use -var during terraform plan and apply.
Initiate, plan and apply your main.tf
```
cd ${repo}/preparation/
terraform init
terraform plan -var access_key=${AWS_ACCESS_KEY} -var secret_key=${AWS_SECRET_KEY} -var-file terraform.tfvars
terraform apply -var access_key=${AWS_ACCESS_KEY} -var secret_key=${AWS_SECRET_KEY} -var-file terraform.tfvars
```

2. Design your own infra

Go to ./environments/${environment}/${infrastructure}
Use modules from modules/ for creation your own base_network or any infrastructure
Initiate terraform configuration to verify your tfstate storage (s3, consul, ...)
```
cd ${repo}/environments/production/base_network/
terraform init
terraform plan -var access_key=${AWS_ACCESS_KEY} -var secret_key=${AWS_SECRET_KEY} -var-file terraform.tfvars
terraform apply -var access_key=${AWS_ACCESS_KEY} -var secret_key=${AWS_SECRET_KEY} -var-file terraform.tfvars
```

You can skip '-var-file terraform.tfvars' if you are defined all variables in variables.tf

3. Modify your modules

Modify your modules
Apply these changes on integration/dev environment first by changing module source 'ref' in ${environment}/${infrastructure}/main.tf
Don't forget to 'get' your modules changes
'Promote' your change to production (can be done through any pipeline or manually)
```
terraform get
terraform plan -var access_key=${AWS_ACCESS_KEY} -var secret_key=${AWS_SECRET_KEY} -var-file terraform.tfvars
terraform apply -var access_key=${AWS_ACCESS_KEY} -var secret_key=${AWS_SECRET_KEY} -var-file terraform.tfvars
```

## Tips and tricks

1. Use modules and environments to have repeatable code and consistent environments
2. Use aws tags, ex. terraform=true, environment="production"
3. Store [tfstate remotely](https://www.terraform.io/intro/getting-started/remote.html) (S3, consul, ..)
4. Use [Lock](https://www.terraform.io/docs/state/locking.html) for teamwork with same tfstate
5. Enable versioning for tfstate S3
6. Enable [encryption](https://www.terraform.io/docs/state/sensitive-data.html) for remote tfstate as you can have sensitive data in tfstate
7. Variables from remote tfstate can be used through [terraform_remote_state](https://www.terraform.io/docs/providers/terraform/d/remote_state.html)
8. Keep modules in [vcs](https://www.terraform.io/docs/modules/sources.html) and use 'ref' to use specific commit or branch
9. Use loops, conditions and [built-in functions](https://www.terraform.io/docs/configuration/interpolation.html)

## Inspired by

- [Terraform up&running](https://blog.gruntwork.io/a-comprehensive-guide-to-terraform-b3d32832baca)
- [Hashicorp github](https://github.com/hashicorp/best-practices/tree/master/terraform)
- [Charity.wtf](https://charity.wtf/tag/terraform/)
- [Terraform official](https://www.terraform.io/)

## TODO:
1. Add locking
2. More modules
