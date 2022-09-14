variable "primary-vpc" {
  type    = string
  default = ""
}

variable "primary-subnets" {
  type    = list(string)
  default = []
}