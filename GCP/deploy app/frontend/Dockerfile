FROM node
WORKDIR /frontend
EXPOSE 3000
ENV REACT_APP_BACKEND_URL=http://localhost:8000 
COPY package*.json .
RUN npm install 
COPY . .
RUN npm run build
CMD [ "npm","run", "dev" ]

