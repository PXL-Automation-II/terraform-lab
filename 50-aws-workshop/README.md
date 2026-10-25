# 50 - AWS workshop

End state of the [AWS workshop](https://pxl-automation-ii.github.io/terraform-course/#/50-aws-workshop): a cluster of web servers in an Auto Scaling Group behind an Application Load Balancer, in the default VPC of `us-east-1`. The instances use `LabInstanceProfile`, so you log in with Session Manager; port 22 is closed.

Run it with the credentials of your Learner Lab session:

```bash
terraform init
terraform apply
curl "http://$(terraform output -raw alb_dns_name)"
```

The load balancer takes about two minutes, and answers `Hello, World!` shortly after the apply. Clean up with `terraform destroy`.

The [state workshop](https://pxl-automation-ii.github.io/terraform-course/#/51-state-workshop-en) starts from this `main.tf`.
