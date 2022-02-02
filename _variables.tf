variable "name" {
  type        = string
  description = "Cluster name"
}

variable "es_version" {
  type        = string
  description = "ElasticSearch version"
}

variable "instance_type" {
  type        = string
  description = "ElasticSearch instance type"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Number of instances. When using two AZs, this value must be an even number"
}

variable "zone_awareness_enabled" {
  type    = string
  default = false
}

variable "dynamic_zone_awareness_config" {
  type        = any
  default     = []
  description = "Dynamic zone_awareness_config block"
}

variable "az_count" {
  type        = number
  default     = 2
  description = "Number of AZs. Must be equal to availability_zone_count, inside zone_awareness_config"
}

variable "ebs_enabled" {
  type    = bool
  default = true
}

variable "volume_size" {
  type    = string
  default = 15
}

variable "encrypt" {
  type        = bool
  default     = false
  description = "Flag to whether encrypt or not ES"
}

variable "vpc_id" {
  type        = string
  description = "Account VPC id"
}

variable "subnet_ids" {
  description = "Subnet ids to deploy the cluster"
}

variable "allow_security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of Security Group IDs to allow connection from"
}

variable "allow_cidrs" {
  type        = list(string)
  default     = []
  description = "List of CIDRs to allow connection from"
}