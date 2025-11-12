# ---------- STAGE 1: BUILD + OBFUSCATE ----------
FROM node:18 AS builder
WORKDIR /app

# copy package files
COPY package*.json ./

RUN npm install

# copy index.js code
COPY index.js ./

# install obfuscator
RUN npm install -g javascript-obfuscator

# obfuscate index.js only
RUN mkdir -p dist
RUN javascript-obfuscator index.js --output dist/index.js



# ---------- STAGE 2: FINAL RUNTIME ----------
#FROM node:18-slim
#WORKDIR /app

# Copy only obfuscated output
#COPY --from=builder /app/dist ./dist
#COPY package*.json ./
Run rm -f index.js && javascript-obfuscator index.js --output dist/index.js

RUN npm prune --production
Run npm cache clean -f
EXPOSE 3000

CMD ["node", "dist/index.js"]
