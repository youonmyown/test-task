## Test taskfor Junior\Trainee Devops

[![Terraform Apply and Deploy](https://github.com/youonmyown/test-task/actions/workflows/terraform.yml/badge.svg)](https://github.com/youonmyown/test-task/actions/workflows/terraform.yml)

### Usage:
Requirments: `terraform, ansible, rsync`.

Create and set up `terraform.tfvars`, exaple: `example.tfvars`.

Init terraform:
```
terraform init
```

Apply terraform:
```
terraform apply
```

Setup ansible host file and deploy site:
```
bash ip_to_inventory.sh
```

Enjoy!