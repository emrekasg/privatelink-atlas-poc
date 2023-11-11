resource "mongodbatlas_project" "poc" {
  name   = "mongodb-poc-project"
  org_id = var.atlas_organization_id

  is_data_explorer_enabled              = true
  is_realtime_performance_panel_enabled = true
}

resource "mongodbatlas_cluster" "poc_cluster" {
  project_id = mongodbatlas_project.poc.id
  name       = "poc-cluster"

  provider_name               = "AWS"
  provider_instance_size_name = "M10"

  provider_region_name = var.atlas_region_name
}

resource "mongodbatlas_database_user" "poc_user" {
  username   = var.mongodb_username
  password   = var.mongodb_password
  project_id = mongodbatlas_project.poc.id

  auth_database_name = "admin"
  roles {
    role_name     = "readAnyDatabase"
    database_name = "admin"
  }
}
