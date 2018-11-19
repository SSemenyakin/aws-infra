variable "infra_subnets" {
  type = "map"

  default = {
    public  = "192.168.1.0/24"
    private = "192.168.2.0/24"
  }
}

variable "AZ" {
  type = "list"

  default = ["us-east-1a"]
}
