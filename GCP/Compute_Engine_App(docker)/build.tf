resource "time_static" "tag" {}

resource "docker_image" "main" {
  name = "gcr.io/${var.gcp_project}/${var.image_name}:${time_static.tag.unix}"
  build {
    context    = "${path.module}/Dockerize_me/."
    dockerfile = "Dockerfile"
    no_cache   = true
  }

}

