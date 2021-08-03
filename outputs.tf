output "dn" {
  value       = aci_rest.infraAccNodePGrp.id
  description = "Distinguished name of `infraAccNodePGrp` object."
}

output "name" {
  value       = aci_rest.infraAccNodePGrp.content.name
  description = "Leaf switch policy group name."
}
