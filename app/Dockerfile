# base image 
FROM node:20-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install --production

# bring in app code
COPY server.js .
COPY public ./public

EXPOSE 80
CMD ["npm", "start"]
