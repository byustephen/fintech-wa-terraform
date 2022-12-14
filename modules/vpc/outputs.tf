#   ██████╗ ██╗   ██╗████████╗██████╗ ██╗   ██╗████████╗███████╗
#  ██╔═══██╗██║   ██║╚══██╔══╝██╔══██╗██║   ██║╚══██╔══╝██╔════╝
#  ██║   ██║██║   ██║   ██║   ██████╔╝██║   ██║   ██║   ███████╗
#  ██║   ██║██║   ██║   ██║   ██╔═══╝ ██║   ██║   ██║   ╚════██║
#  ╚██████╔╝╚██████╔╝   ██║   ██║     ╚██████╔╝   ██║   ███████║
#   ╚═════╝  ╚═════╝    ╚═╝   ╚═╝      ╚═════╝    ╚═╝   ╚══════╝
#                                                               

output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.main.id, "")
}

output "subnet_a_id" {
  description = "The ID of subnet a"
  value       = try(aws_subnet.subnet-a.id, "")
}

output "subnet_b_id" {
  description = "The ID of subnet b"
  value       = try(aws_subnet.subnet-b.id, "")
}

output "subnet_c_id" {
  description = "The ID of subnet c"
  value       = try(aws_subnet.subnet-c.id, "")
}