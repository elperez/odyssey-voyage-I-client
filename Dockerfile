FROM node:lts-alpine as build 

WORKDIR /client

COPY package.json .
RUN npm install 
COPY . .
RUN npm run build

FROM nginx
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf 

COPY --from=build /client/build /usr/share/nginx/html 