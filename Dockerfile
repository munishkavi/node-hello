FROM node:18 AS builder 
WORKDIR /app

COPY package*.json ./
RUN npm install 

COPY . .
# add obfuscator step here...

RUN npm install -g javascript-obfuscator
RUN javascript-obfuscator ./src --output ./dist
RUN npm run build
 

FROM node:18-slim
WORKDIR /app
COPY --from=builder /app/dist ./dist

# Expose port (your app listens on)
EXPOSE 3000

CMD ["node", "dist/index.js"]
