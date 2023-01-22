package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	_ "github.com/go-sql-driver/mysql"
)

var (
	username = os.Getenv("rds_username")
	password = os.Getenv("rds_password")
	endpoint = os.Getenv("rds_endpoint")
	port     = os.Getenv("rds_port")
	db_name  = os.Getenv("rds_db_name")
)

func main() {
	lambda.Start(handler)
}

func handler(request events.APIGatewayProxyRequest) {

	var open_state string = "Success"
	var ping_state string = "Success"
	var dbname string = "calc"

	argment := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", username, password, endpoint, port, db_name)
	connection, err := sql.Open("mysql", argment)

	if err != nil {
		open_state = "Not A Success!"
		log.Fatalf("impossible to create the connection: %s", err)
		os.Exit(1)
	} else {
		log.Printf("Open Connection: %s!", open_state)
		log.Printf("Connection with %s", argment)
		log.Println("")
	}

	err = connection.Ping()

	if err != nil {
		ping_state = "Not A Success!"
		log.Fatalf("impossible to Ping: %s", err)
		os.Exit(1)
	} else {
		log.Printf("Ping: %s!", ping_state)
	}

	// if no error. Ping is successful
	log.Println("Ping to database successful, connection is still alive")

	log.Println("CREATE TABLE")

	_, err = connection.Exec("CREATE TABLE IF NOT EXISTS " + dbname + " (X INT,Y INT,OP CHAR,RES INT)")
	if err != nil {
		panic(err)
	}
	log.Println("INSERT TIME")

	for i := 0; i < 10; i++ {
		X := strconv.Itoa(i)
		Y := strconv.Itoa(i)
		OP := "add"
		RES := strconv.Itoa(i + i)

		log.Println("INSERT INTO " + dbname + "(" + X + "," + Y + "," + OP + "," + RES + ")")

		_, err = connection.Exec("INSERT INTO "+dbname+"(X,Y,OP,RES) VALUES (?,?,?,?)", X, Y, OP, RES)
		if err != nil {
			panic(err.Error())
		}
	}

	// lastId, err := res.LastInsertId()

	// if err != nil {
	// 	log.Fatalf("impossible to see Last Insert Id: %s", err)
	// }

	// log.Printf("The last inserted row id: %d\n", lastId)

	connection.Close()

}

//$Env:GOOS = "linux"
//go build main.go
