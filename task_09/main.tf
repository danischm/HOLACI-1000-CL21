terraform {
  required_providers {
    mso = {
      source = "CiscoDevNet/mso"
      version = "0.1.5"
    }
  }
}

provider "mso" {
  username = "admin"
  password = "C1sco123456!"
  url = "https://198.18.135.70"
  insecure = true
}
