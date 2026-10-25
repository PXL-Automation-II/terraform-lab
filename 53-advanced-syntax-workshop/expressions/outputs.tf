output "upper_names" {
  value = [for name in var.names : upper(name)]
}

output "short_upper_names" {
  value = [for name in var.names : upper(name) if length(name) < 5]
}

output "descriptions" {
  value = [for name, weight in var.weight_classes : "${name} is the ${weight}"]
}

output "upper_weights" {
  value = { for name, weight in var.weight_classes : upper(name) => upper(weight) }
}

output "for_directive" {
  value = "%{for name in var.names}${name}, %{endfor}"
}

output "for_directive_index" {
  value = "%{for i, name in var.names}(${i}) ${name}, %{endfor}"
}

output "for_directive_index_if_strip" {
  value = <<EOF
%{~for i, name in var.names~}
${name}%{if i < length(var.names) - 1}, %{endif}
%{~endfor~}
EOF
}

output "for_directive_index_if_else_strip" {
  value = <<EOF
%{~for i, name in var.names~}
${name}%{if i < length(var.names) - 1}, %{else}.%{endif}
%{~endfor~}
EOF
}
