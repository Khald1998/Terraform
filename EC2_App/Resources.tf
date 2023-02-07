data "archive_file" "go" {
  depends_on = [
    null_resource.main
  ]
  type        = "zip"
  source_dir  = "./func"
  output_path = "./func.zip"
}

