# 78 - GitHub Actions

End state of [IaC CI/CD with GitHub Actions](https://pxl-automation-ii.github.io/terraform-course/#/78-github-actions): the Terragrunt project of the [Terragrunt workshop](https://pxl-automation-ii.github.io/terraform-course/#/57-terragrunt-workshop), with a pipeline that runs on a self-hosted runner in the AWS Academy Learner Lab.

| Directory | Contents |
| --- | --- |
| `runner` | Terraform configuration of the runner, an EC2 instance with `LabInstanceProfile`. You apply it once from your own computer. |
| `live` | The Terragrunt project, with `staging` and `prod`. |
| `.github` | The workflows, and the composite action that installs Terraform and Terragrunt. |

The workflows:

| Workflow | Starts on | Runs on | Runs |
| --- | --- | --- | --- |
| `checks.yml` | every pull request and push to `main` | GitHub's runner | formatting, `validate`, TFLint and Trivy |
| `plan.yml` | a pull request that changes `live` | the lab runner | `terragrunt run --all plan` |
| `deploy-staging.yml` | a push to `main` that changes staging | the lab runner | `terragrunt run --all apply` in `live/staging` |
| `deploy-prod.yml` | the **Run workflow** button | the lab runner | `terragrunt run --all apply` in `live/prod` |
| `drift.yml` | weekdays at 06:00 UTC, or the button | the lab runner | a plan of staging that fails on changes |

GitHub only runs workflows from `.github` at the root of a repository. Copy the contents of this directory into the root of your own private repository.

Before you push:

- Replace `terraform-pxl-ci-state-1234` in `live/root.hcl` with your own bucket name, and create the bucket with `terragrunt backend bootstrap` from one unit.
- Create the repository secrets `DB_USERNAME` and `DB_PASSWORD`.
- Start the runner, as the page describes, with your repository URL and a registration token.

Keep the repository private: the runner runs the code of every pull request with the rights of the lab role.
