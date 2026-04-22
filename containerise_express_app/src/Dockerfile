FROM node:22
WORKDIR /app
COPY package*.json ./
RUN npm ci 
COPY index.js index.js
EXPOSE 5000
ENV PORT=5000
CMD ["node", "index.js"]    
