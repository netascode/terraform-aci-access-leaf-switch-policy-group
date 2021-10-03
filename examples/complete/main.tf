module "aci_access_leaf_switch_policy_group" {
  source  = "netascode/access-leaf-switch-policy-group/aci"
  version = ">= 0.0.1"

  name                    = "SW-PG1"
  forwarding_scale_policy = "HIGH-DUAL-STACK"
}
