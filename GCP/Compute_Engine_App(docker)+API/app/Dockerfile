FROM node
WORKDIR /app
COPY package*.json .
RUN npm install --force
COPY . .
EXPOSE 8080
CMD node server.js
