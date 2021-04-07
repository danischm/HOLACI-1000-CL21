variable "tenants" {
}

module "tenant" {
  source = "./modules/mso_tenant"
  for_each = toset(var.tenants)
  tenant_name = each.value
  site_1_id = mso_site.SF_site.id
  site_2_id = mso_site.NY_site.id
}
