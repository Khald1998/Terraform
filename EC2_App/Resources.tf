data "archive_file" "go" {
    type = "zip"
    source_dir  = "./Go-Functions/myLmbda"
    output_path = "./Go-Functions/myLmbda.zip"
}

