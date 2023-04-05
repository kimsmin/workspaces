terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 0.13"
}

provider "akamai" {
  edgerc         = var.edgerc_path
  config_section = var.config_section
}

data "akamai_group" "group" {
  group_name  = "20230323012443"
  contract_id = "ctr_V-41DUHPB"
}

data "akamai_contract" "contract" {
  group_name = data.akamai_group.group.name
}

data "akamai_property_rules_template" "rules" {
  template_file = abspath("${path.module}/property-snippets/main.json")
}

resource "akamai_edge_hostname" "lab001-akamai-lab-com-edgesuite-net" {
  product_id    = "prd_Fresca"
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_group.group.id
  ip_behavior   = "IPV6_COMPLIANCE"
  edge_hostname = "lab001.akamai-lab.com.edgesuite.net"
}

resource "akamai_property" "lab001-akamai-lab-com" {
  name        = "lab001.akamai-lab.com"
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_group.group.id
  product_id  = "prd_Fresca"
  rule_format = "latest"
  hostnames {
    cname_from             = "lab001.akamai-lab.com"
    cname_to               = akamai_edge_hostname.lab001-akamai-lab-com-edgesuite-net.edge_hostname
    cert_provisioning_type = "CPS_MANAGED"
  }
  rules = data.akamai_property_rules_template.rules.json
}

resource "akamai_property_activation" "lab001-akamai-lab-com" {
  property_id = akamai_property.lab001-akamai-lab-com.id
  contact     = ["learn@akamai.com"]
  version     = akamai_property.lab001-akamai-lab-com.latest_version
  network     = upper(var.env)
}
