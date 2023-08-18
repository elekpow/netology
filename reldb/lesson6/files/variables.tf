variable "ssh_key_private" {
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "ssh_key_public" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_user" {
  type        = string
  default     = "igor"
}

variable "hostnames" {
  default = {
    "0" = "master"
    "1" = "slave"
   # "2" = "slave2"
  }
}

