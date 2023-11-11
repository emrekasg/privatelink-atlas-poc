variable "aws_access_key" {
  description = "AWS Access Key"

  type    = string
  default = ""
}

variable "aws_secret_key" {
  description = "AWS Secret Key"

  type    = string
  default = ""
}

variable "aws_region" {
  description = "AWS Region"

  type    = string
  default = "eu-west-1"
}

variable "vpc_azs" {
  description = "VPC Availability Zones"

  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "atlas_public_key" {
  description = "MongoDB Atlas Public Key"

  type    = string
  default = ""
}

variable "atlas_private_key" {
  description = "MongoDB Atlas Private Key"

  type    = string
  default = ""
}

variable "atlas_organization_id" {
  description = "MongoDB Atlas Organization ID"

  type    = string
  default = ""
}

variable "atlas_region_name" {
  description = "MongoDB Atlas Region Name"

  type    = string
  default = "EU_WEST_1"
}

variable "mongodb_username" {
  description = "MongoDB Username"

  type    = string
  default = "poc-user"
}

variable "mongodb_password" {
  description = "MongoDB Password"

  type    = string
  default = "poc-user-password"
}
 