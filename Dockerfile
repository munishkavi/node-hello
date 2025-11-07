# Use Node.js base image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package files first (for caching dependencies)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the code
COPY . .

# Expose port (your app listens on)
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
