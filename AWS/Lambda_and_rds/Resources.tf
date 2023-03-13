data "archive_file" "go" {
    type = "zip"
    source_dir  = "./Go-Functions/Write_to_mysql"
    output_path = "./Go-Functions/Write_to_mysql.zip"
}

