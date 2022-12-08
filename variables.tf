variable "jenkinsInstanceName" {
  type = string
}
variable "public_key" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}
variable "ingress_rules" {
  type    = list(number)
  default = [22, 80, 443]
}
variable "egress_rules" {
  type    = list(number)
  default = [0]
}