FROM node:16-alpine as builder
WORKDIR app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# path `/app/build` <-- all of the stuff we care about

# `FROM` statements terminate blocks
FROM nginx

EXPOSE 80 ## does nothing at all, supposed to be an "instruction" to a developer
## but AWS Elastic Beanstalk will look at it

#                                vvv  nginx's config
COPY --from=builder /app/build /usr/share/nginx/html
# no need for `RUN`, because default `nginx`'s run command already does that
