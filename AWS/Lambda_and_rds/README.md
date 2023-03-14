# Lambda_and_rds
 code that queries an rds via lambda using python

# for_python
"pip install -t $PWD pymysql" use this inside lambda folder for dependency 


# for_go_functionless
"go mod init Write_to_mysql" (inside the write folder)
"go run .\main.go" (inside the write folder) or "go run .\Go-Functions\Write_to_mysql\main.go" 
"go get -u github.com/aws/aws-lambda-go" (inside the write folder)
before upload we need to build the code into compiled binary for aws and zip it
$Env:GOOS = "linux" (inside the write folder)
"go build main.go"  (inside the write folder)


# for_go_Write_to_mysql
"go get -u github.com/go-sql-driver/mysql"
"go get -u github.com/aws/aws-lambda-go"
