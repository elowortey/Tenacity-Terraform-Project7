# My Provider
variable "region" {
  default     = "eu-west-2"
  description = "aws region"
}

# My VPC
variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "prod-vpc"
}

# Public Subnets
variable "prod_public_subnet-1" {
  default     = "10.0.1.0/24"
  description = "prod_public_subnet-1"
}

variable "prod_public_subnet-2" {
  default     = "10.0.2.0/24"
  description = "prod_public_subnet-2"
}

# My Private Subnets
variable "prod_private_subnet-1" {
  default     = "10.0.3.0/24"
  description = "prod_public_subnet-2"
}

variable "prod_private_subnet-2" {
  default     = "10.0.4.0/24"
  description = "prod_public_subnet-2"
}

# My Public Route-Table 
variable "prod_public_rt" {
  default     = "prod_public_rt"
  description = "prod_public_rt"
}

# My Private Route-Table
variable "prod_private_rt" {
  default     = "prod_private_rt"
  description = "prod_private_rt"
}