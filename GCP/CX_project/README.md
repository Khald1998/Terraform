cd app; npm init -y;
npm install express
npm install express graphql express-graphql
node server.js

query {
hello
}
<br>
{
getUser(id: 1) {
id
name
email
}
}
<br>
{
getUsers {
id
name
email
}
}
<br>
mutation {
addUser(name: "Bob Smith", email: "bobsmith@example.com") {
id
name
email
}
}
<br>
mutation {
deleteUser(id: 1)
}
<br>
mutation {
updateUser(id: 1, name: "John Smith", email: "johnsmith@example.com") {
id
name
email
}
}
