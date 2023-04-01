// const express = require('express');
// const app = express();
// const port = 8080;

// app.get('/', (req, res) => {
//     res.send('Hello, World!');
// });

// app.listen(port, () => {
//   console.log(`Server listening on port ${port}`);
// });


const express = require('express');
const { graphqlHTTP } = require('express-graphql');
const { buildSchema } = require('graphql');

// Define a schema
const schema = buildSchema(`
  type Query {
    hello: String
  }
`);

// Define a resolver
const root = {
  hello: () => 'Hello world!'
};

// Create an express server and add the graphql middleware
const app = express();
app.use('/graphql', graphqlHTTP({
  schema: schema,
  rootValue: root,
  graphiql: true // This enables the GraphiQL UI for testing and exploring the API
}));

// Start the server
app.listen(3000, () => {
  console.log('Server running on http://localhost:3000/graphql');
});
