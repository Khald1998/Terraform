data "mongodbatlas_roles_org_id" "test" {
}
resource "mongodbatlas_project" "my_project" {
  name   = "my-atlas-project"
  org_id = data.mongodbatlas_roles_org_id.test.org_id
}
resource "mongodbatlas_cluster" "my_cluster" {
  name         = "my-atlas-cluster"
  project_id   = mongodbatlas_project.my_project.id
  cluster_type = "REPLICASET"

  provider_name               = "GCP"
  num_shards                  = 1
  disk_size_gb                = 40
  backup_enabled              = true
  provider_backup_enabled     = true
  provider_region_name        = "us-central1"
  provider_instance_size_name = "M30"
  #   cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.2"



}

