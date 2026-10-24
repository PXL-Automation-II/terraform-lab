# 57 - Terragrunt workshop

End state of the [Terragrunt workshop](https://pxl-automation-ii.github.io/terraform-course/#/57-terragrunt-workshop).

- `live`: `root.hcl`, an `env.hcl` per environment, and one `terragrunt.hcl` per unit.
- `modules`: the reusable modules, as released in [tf-lab-modules](https://github.com/PXL-Automation-II/tf-lab-modules) `v1.0.0`. The units use that tag.

Before you run anything:

- Replace `terraform-pxl-tg-state-1234` in `live/root.hcl` with your own bucket name.
- To use your own module repository, replace `github.com/PXL-Automation-II/tf-lab-modules` with `github.com/YOUR-USER/terraform-modules` in every `terragrunt.hcl`.

The databases need the credentials as environment variables, in bash:

```bash
export TF_VAR_db_username="pxl"
export TF_VAR_db_password="pxlpxlpxl"
```

Create the bucket once, from one unit, and answer `y`:

```bash
cd live/staging/data-storage/mysql
terragrunt backend bootstrap
cd ../../..
```

Then, from `live`:

```bash
terragrunt run --all apply
terragrunt run --all destroy
```

`live/00-backend-bootstrap` is the bucket of the state workshop. It has no `terragrunt.hcl`, so `run --all` skips it.
