# base image 
FROM node:20-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm cache clean --force
# && npm ci --omit=dev
RUN npm install --production


# bring in app code
COPY server.js .
COPY public ./public

EXPOSE 8080
CMD ["npm", "start"]
