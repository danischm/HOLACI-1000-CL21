variable "tenant_name" {
  default = "CL"
}

# Define an MSO Tenant
resource "mso_tenant" "tenant" {
  name = var.tenant_name
  display_name = var.tenant_name
  description = "This tenant was created by Terraform"
  site_associations { site_id = mso_site.SF_site.id }
  site_associations { site_id = mso_site.NY_site.id }
}
