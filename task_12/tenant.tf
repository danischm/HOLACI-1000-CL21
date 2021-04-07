variable "tenant_name" {
  default = "CL"
}


resource "mso_tenant" "tenant" {
  name = var.tenant_name
  display_name = var.tenant_name
  description = "This tenant was created by Terraform."
  site_associations { site_id = mso_site.SF_site.id }
  site_associations { site_id = mso_site.NY_site.id }
}

resource "mso_schema" "schema" {
  name = var.tenant_name
  template_name = "SF-NY"
  tenant_id = mso_tenant.tenant.id
}

resource "mso_schema_site" "schema_site_SF" {
  schema_id = mso_schema.schema.id
  site_id = mso_site.SF_site.id
  template_name = mso_schema.schema.template_name
}

resource "mso_schema_site" "schema_site_NY" {
  schema_id = mso_schema.schema.id
  site_id = mso_site.NY_site.id
  template_name = mso_schema.schema.template_name
}

resource "mso_schema_template_vrf" "schema_vrf_VRF1" {
  schema_id = mso_schema.schema.id
  template = mso_schema.schema.template_name
  name = "VRF1"
  display_name = "VRF1"
}

resource "mso_schema_template_bd" "schema_bd" {
  for_each = toset(["BD1", "BD2", "BD3"])

  schema_id = mso_schema.schema.id
  name = each.value
  display_name = each.value
  template_name = mso_schema.schema.template_name
  vrf_name = mso_schema_template_vrf.schema_vrf_VRF1.name
}

resource "mso_schema_template_anp" "schema_anp_ANP1" {
  schema_id = mso_schema.schema.id
  template = mso_schema.schema.template_name
  name = "ANP1"
  display_name = "ANP1"
}

resource "mso_schema_template_anp_epg" "schema_epg" {
  for_each = {
    "EPG1" = "BD1"
    "EPG2" = "BD2"
    "EPG3" = "BD3"
  }

  schema_id = mso_schema.schema.id
  template_name = mso_schema.schema.template_name
  anp_name = mso_schema_template_anp.schema_anp_ANP1.name
  name = each.key
  display_name = each.key
  bd_name = each.value
  vrf_name = mso_schema_template_vrf.schema_vrf_VRF1.name
}

resource "mso_schema_template_deploy" "schema_deploy" {
  schema_id = mso_schema.schema.id
  template_name = mso_schema.schema.template_name
}
