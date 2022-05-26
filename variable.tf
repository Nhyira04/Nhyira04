
variable "vpc-cidr" {
  type        = string
  description = "name of vpc-cidr"
  default     = "10.0.0.0/16"

}

variable "pub-cidr1" {
  type        = string
  description = "name of pub-cidr1"
  default     = "10.0.0.0/24"

}

variable "pub-cidr2" {
  type         = string
  description  = "name of pub-cidr2"
  default = "10.0.1.0/24"

}

variable "pub-cidr3" {
  type        = string
  description = "name of pub-cidr3"
  default     = "10.0.2.0/24"

}

variable "priv-cidr1" {
  type        = string
  description = "name of priv-cidr1"
  default     = "10.0.3.0/24"

}

variable "priv-cidr2" {
  type        = string
  description = "name of priva-cidr2"
  default     = "10.0.4.0/24"

}


variable "abz-1" {
  type        = string
  description = "name of availability zone"
  default     = "eu-west-1a"
}

variable "abz-2" {
  type        = string
  description = "name of availability zone"
  default     = "eu-west-1b"
}

variable "abz-3" {
  type        = string
  description = "name of availability zone"
  default     = "eu-west-1c"
}

variable "abz-4" {
  type        = string
  description = "name of availability zone"
  default     = "eu-west-1a"
}

variable "region-name" {
  type        = string
  description = "name of region"
  default     = "eu-west-1b"
}
