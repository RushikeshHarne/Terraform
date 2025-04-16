variable "names" {
  type    = list(string)
  default = ["pavan", "rajesh"]
}

output "upper_names" {
  value = [for name in var.names : upper(name)]
}

resource "null_resource" "operation1" {
  provisioner "local-exec" {
    command = "echo Users are: ${join(" ", var.names)} >> file1.txt"
  }
}
