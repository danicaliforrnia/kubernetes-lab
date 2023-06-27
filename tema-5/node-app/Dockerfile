FROM node:20-alpine3.17

RUN mkdir -p /opt/app

WORKDIR /usropt/app


COPY package.json /opt/app/

RUN npm install

COPY server.js /usr/src/app

EXPOSE 8080

CMD [ "npm", "start" ]