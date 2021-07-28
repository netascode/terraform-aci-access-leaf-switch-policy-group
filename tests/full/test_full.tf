terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name                    = "SW-PG1"
  forwarding_scale_policy = "HIGH-DUAL-STACK"
}

data "aci_rest" "infraAccNodePGrp" {
  dn = "uni/infra/funcprof/accnodepgrp-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "infraAccNodePGrp" {
  component = "infraAccNodePGrp"

  equal "name" {
    description = "name"
    got         = data.aci_rest.infraAccNodePGrp.content.name
    want        = module.main.name
  }
}

data "aci_rest" "infraRsTopoctrlFwdScaleProfPol" {
  dn = "${data.aci_rest.infraAccNodePGrp.id}/rstopoctrlFwdScaleProfPol"

  depends_on = [module.main]
}

resource "test_assertions" "infraRsTopoctrlFwdScaleProfPol" {
  component = "infraRsTopoctrlFwdScaleProfPol"

  equal "tnTopoctrlFwdScaleProfilePolName" {
    description = "tnTopoctrlFwdScaleProfilePolName"
    got         = data.aci_rest.infraRsTopoctrlFwdScaleProfPol.content.tnTopoctrlFwdScaleProfilePolName
    want        = "HIGH-DUAL-STACK"
  }
}
