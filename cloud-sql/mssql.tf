locals {
  mssql_database_versions = ["SQLSERVER_2017_STANDARD", "SQLSERVER_2017_ENTERPRISE", "SQLSERVER_2017_EXPRESS", "SQLSERVER_2017_WEB", "SQLSERVER_2019_STANDARD", "SQLSERVER_2019_ENTERPRISE", "SQLSERVER_2019_EXPRESS", "SQLSERVER_2019_WEB"]
}

module "mssql" {
  count = contains(local.mssql_database_versions, var.database_version) ? 1 : 0

  source  = "GoogleCloudPlatform/sql-db/google//modules/mssql"
  version = "~> 10.0"

  database_version     = var.database_version
  name                 = var.name
  project_id           = data.google_client_config.current.project
  region               = data.google_client_config.current.region
  zone                 = data.google_client_config.current.zone
  db_name              = var.db_name
  user_name            = var.db_user
  user_password        = var.db_password
  deletion_protection  = false
  random_instance_name = var.random
  availability_type    = var.availability_type

  ip_configuration = {
    authorized_networks = var.authorized_networks
    ipv4_enabled        = var.public_ip
    private_network     = local.private_network
    require_ssl         = false
    allocated_ip_range  = local.allocated_ip_range
  }
}
