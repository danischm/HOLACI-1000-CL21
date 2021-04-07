module "tenant_CL1" {
  source = "./modules/mso_tenant"
  tenant_name = "CL1"
  site_1_id = mso_site.SF_site.id
  site_2_id = mso_site.NY_site.id
}

module "tenant_CL2" {
  source = "./modules/mso_tenant"
  tenant_name = "CL2"
  site_1_id = mso_site.SF_site.id
  site_2_id = mso_site.NY_site.id
}
