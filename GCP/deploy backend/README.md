cd app; npm init -y;
npm install express
npm install express graphql express-graphql
node server.js

echo Y | gcloud auth configure-docker us-central1-docker.pkg.dev 

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



gcloud projects add-iam-policy-binding terraform-31308 --member="serviceAccount:terraform-service-account@terraform-31308.iam.gserviceaccount.com" --role="roles/run.admin"