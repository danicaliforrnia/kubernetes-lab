FROM node:20-alpine3.17

RUN mkdir -p /usr/app

WORKDIR /usr/app

COPY . .

RUN npm install

COPY server.js /usr/app

EXPOSE 8080

CMD [ "npm", "start" ]