resource "mso_site" "SF_site" {
  name = "San Francisco"
  username = "admin"
  password = "C1sco12345"
  apic_site_id = "1"
  urls = ["https://apic1-a.dcloud.cisco.com"]
}

resource "mso_site" "NY_site" {
  name = "New York"
  username = "admin"
  password = "C1sco12345"
  apic_site_id = "2"
  urls = ["https://apic1-b.dcloud.cisco.com"]
}
