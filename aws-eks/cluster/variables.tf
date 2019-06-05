
variable "credentials_file" {
  default = "~/.aws/credentials"
}
variable "profile" {
  default = "default"
}
variable "region" {
  default = "us-west-2"
}
variable "cluster_name" {
  default = "kubernetes-apix2019"
}
variable "cluster_name_node" {
  default = "kubernetes-apix2019-node"
}
variable "disk" {
  default = "50"
}
variable "disk_type" {
  default = "gp2"
}
variable "ami" {
  default = "ami-0280ac619ed294a8a"
}
variable "instance_type" {
  default = "t3.large"
}
