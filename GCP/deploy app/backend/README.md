# README

## Project Description
This is a simple Node.js server that generates a random string and returns it in a JSON response. The server uses the Express.js framework and listens on port 8080.

## Installation
1. Clone the repository or download the code
2. Install the required dependencies by running `npm install`

## Usage
1. Start the server by running `node index.js` or `npm start`
2. Send a GET request to `http://localhost:8080/`
3. The server will respond with a JSON object containing a randomly generated string in the `word` field

## Dependencies
- express
- nodemon (dev dependency)

## Endpoints

### `GET /`
This endpoint returns a JSON object containing a randomly generated string in the `word` field. It also sets the `Access-Control-Allow-Origin` header to allow cross-origin resource sharing.

### Example Response
json
{
  "word": "rj7r8ek"
}

## License
This project is licensed under the MIT License.
