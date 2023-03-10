FROM node:16-alpine

WORKDIR ./app

COPY *.json ./
RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest
#COPY conf/default.conf /etc/nginx/nginx.conf
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
