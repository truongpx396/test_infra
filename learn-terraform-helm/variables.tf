variable "region" {
  default     = "ap-southeast-1"
  description = "AWS region"
}

variable "application_name" {
  type    = string
  default = "terramino"
}

variable "slack_app_token" {
  type        = string
  description = "token"
}

