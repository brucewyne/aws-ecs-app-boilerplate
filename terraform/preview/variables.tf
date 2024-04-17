variable "service_name" {
  description = "Unique value for the service name - probably based on the PR"
  type        = string
  default     = "app-pr-x"
}

variable "docker_image" {
  description = "path and tag to docker image"
  type        = string
  default     = ""
}
