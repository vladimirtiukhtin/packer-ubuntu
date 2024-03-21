variable "region" {
  description = ""
  type        = string
  default     = "eu-west-1"
}

variable "instance_type" {
  description = ""
  type        = string
  default     = "t3.micro"
}

variable "extra_tags" {
  description = "Map of additional tags/labels to add to resulting image"
  type        = map(string)
  default     = {}
}
