terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "0.5.4"
    }
  }
}

provider "aci" {
  username = "admin"
  password = "C1sco12345"
  url      = "https://apic1-b.dcloud.cisco.com"
  insecure = true
}

resource "aci_local_user" "tform_user" {
  name = "tform"
  pwd  = "C1sco-321"
  clear_pwd_history = "yes"
}

resource "aci_x509_certificate" "aci_cert" {
  local_user_dn = aci_local_user.tform_user.id
  name = "tform"
  data = <<-EOT
(Add the content from the tform.crt file)
EOT
}

resource "aci_rest" "aaaUserDomain_all" {
  path       = "/api/mo/${aci_local_user.tform_user.id}/userdomain-all.json"
  class_name = "aaaUserDomain"
  content = {
    "name" = "all"
  }
}
 
resource "aci_rest" "aaaUserRole_admin" {
  path       = "/api/mo/${aci_rest.aaaUserDomain_all.id}/role-admin.json"
  class_name = "aaaUserRole"
  content = {
    "name"     = "admin"
    "privType" = "writePriv"
  }
}

