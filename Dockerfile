FROM node:16-alpine as builder

WORKDIR ./app

COPY *.json ./
RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest
RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
