
variable "region" {
  type        = string
  description = "aws region"
  default     = "us-east-1"
}
variable "vpc_cidr_block" {
  type        = string
  description = "VPC cidr block"
  default     = "10.0.0.0/16"

}

#list [] datatype
#subnet variables

variable "pub_subnet_cidr" {
  type        = list(string)
  description = "public subnet cidr block"
  default     = ["10.0.0.0/24", "10.0.2.0/24"]

}
variable "priv_subnet_cidr" {
  type        = list(string)
  description = "private cidr block"
  default     = ["10.0.1.0/24", "10.0.3.0/24"]

}
variable "priv_database_subnet_cidr" {
  type        = list(string)
  description = "private database cidr block"
  default     = ["10.0.51.0/24", "10.0.53.0/24"]

}