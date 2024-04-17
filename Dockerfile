FROM node:18.16.0-alpine

WORKDIR /srv/app

COPY ./package.json ./
COPY ./yarn.lock ./

RUN yarn install

COPY . .

ENV NODE_ENV production

EXPOSE 3000

CMD ["yarn", "start"]
