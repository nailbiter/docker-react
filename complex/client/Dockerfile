FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# path `/app/build` <-- all of the stuff we care about

# `FROM` statements terminate blocks
FROM nginx
#                                vvv  nginx's config
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
# no need for `RUN`, because default `nginx`'s run command already does that
