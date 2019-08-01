FROM node:alpine as builder
WORKDIR '/app'
#COPY package.json .
COPY package*.json ./ 
# fix for AWS above
RUN npm install
COPY . .
RUN npm run build

#/app/build <---- all the stuff we care about

FROM nginx
EXPOSE 80 
# this is for ElasticBeanStalk - port mapped for incoming traffic - EXPOSE
COPY --from=builder /app/build /usr/share/nginx/html 
# something from the first phase
#default command is to start nginx :)
