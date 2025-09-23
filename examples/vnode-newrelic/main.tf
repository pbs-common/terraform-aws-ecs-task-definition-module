module "task" {
  source = "../.."

  mesh_name    = "mesh_name"
  virtual_node = "virtual_node"

  newrelic_secret_arn = "arn:aws:secretsmanager:*:*:secret:fake-newrelic-secret-arn"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
