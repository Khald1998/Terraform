FROM node
WORKDIR /backend
COPY package*.json .
RUN npm install --force
COPY . .
EXPOSE 8080
CMD node server.js
