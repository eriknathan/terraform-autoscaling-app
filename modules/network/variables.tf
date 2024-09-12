variable "cidr_block" {
  type        = string
  description = "Network CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project Name to be used to name the resources (tags)"
}

variable "region" {
  type        = string
  description = "Region AWS"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS Resources"
}