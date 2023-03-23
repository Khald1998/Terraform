resource "null_resource" "docker_push" {

    triggers = {
        always_run = timestamp()
    }
    provisioner "local-exec" {
        command     = "docker push ${docker_image.main.name}"
    }
    depends_on = [
        google_project_service.gcr_api
        ,docker_image.main     
    ]
    # Only run during `terraform apply`
    count = fileexists("${path.root}/.terraform/terraform.plan")

}
