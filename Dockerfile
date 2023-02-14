FROM node:lts-alpine as build
WORKDIR /app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install 
COPY . .
RUN npm run build

FROM node:lts-alpine
WORKDIR /app
COPY package.json .
RUN npm install --only=production
COPY --from=build /app/dist  ./dist
CMD npm run start:prod