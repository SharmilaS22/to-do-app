
FROM node:16.13-alpine3.14 AS build
WORKDIR /app
COPY package.json ./
RUN yarn
COPY . /app
RUN yarn build

#Run
FROM nginx:1.12-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]