# 53 - Advanced syntax workshop

End state of every example directory of the [advanced syntax workshop](https://pxl-automation-ii.github.io/terraform-course/#/53-advanced-syntax-workshop). Each directory keeps its state locally.

| Directory | Topic |
| --- | --- |
| `loops-count` | `count`, `count.index`, splat expressions |
| `loops-for-each` | `for_each` with `toset()`, `values()` |
| `loops-modules` | `for_each` on a module, with `modules/log-group` |
| `dynamic-blocks` | `dynamic "tag"` blocks, filtered with a `for` expression |
| `expressions` | `for` expressions and string directives, no AWS resources |
| `conditionals` | conditional expressions, `count` as if and if-else, `one(concat())` |
| `gotchas-count` | `count` from a data source |
| `gotchas-import` | an `import` block, then a `moved` block |

`loops-count`, `loops-for-each` and `loops-modules` create log groups with the same names: destroy one before you apply the next.

`gotchas-import` expects a log group that you create first, outside Terraform:

```bash
aws logs create-log-group --log-group-name manual-log-group --region us-east-1
```
