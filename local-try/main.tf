variable "users" {
type = list
default = ["pankaj","pratik","haresh"]
}

variable "flavors" {
type = map
default = {
"rs10" = "1xCPU-5GB"
"rs20" = "1xCPU-16GB"
}
}

variable "set_password" {
### type = bool      ## optional
default = true
}

resource "null_resource" "operation1"{
provisioner "local-exec" {
command = "echo Users are: ${var.users[0]} ${var.users[1]} ${var.users[2]} >> file1.txt"
}
}

resource "null_resource" "operation2"{
provisioner "local-exec" {
command = "echo values of mapping are: rs10 for ${var.flavors["rs10"]} and rs20 for ${var.flavors["rs20"]} >> file1.txt"
}
}


resource "null_resource" "operation3"{
provisioner "local-exec" {
command = "echo values of set_password var is ${var.set_password} >> file1.txt"
}
}