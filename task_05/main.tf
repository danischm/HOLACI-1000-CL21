# configures the required providers, and source.
terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "0.5.4"
    }
  }
}

# configure provider with your cisco aci credentials.
provider "aci" {
  username = "tform"
  private_key = "tform.key"
  cert_name   = "tform"
  url      = "https://apic1-b.dcloud.cisco.com"
  insecure = true
}
