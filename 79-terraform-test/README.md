# 79 - terraform test

The module and the tests of [Testing Terraform](https://pxl-automation-ii.github.io/terraform-course/#/79-terraform-test).

| Directory | Contents |
| --- | --- |
| `modules/app-logs` | A module with one CloudWatch log group. |
| `modules/app-logs/tests` | The tests. |
| `.github/workflows/module-test.yml` | A workflow that runs the unit and mocked tests on GitHub's runners. It only works in the root of a repository. |

The test files:

| File | Needs AWS | Tests |
| --- | --- | --- |
| `unit.tftest.hcl` | no | the planned name and retention, and two validations that must fail |
| `mocked.tftest.hcl` | no | an apply with a mock provider, and the outputs |
| `integration.tftest.hcl` | yes | an apply that creates a real log group and destroys it again |

Run all tests, with the credentials of your Learner Lab session:

```bash
cd modules/app-logs
terraform init
terraform test
```

Run only the tests that need no AWS:

```bash
terraform test -filter=tests/unit.tftest.hcl -filter=tests/mocked.tftest.hcl
```

On Windows, write the paths with a backslash: `-filter=tests\unit.tftest.hcl`.
