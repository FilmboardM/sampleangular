# Use the official Node.js LTS (Long Term Support) image as the base image
FROM node:18.19.0 as builder

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the entire project to the container
COPY . .

# Build the Angular app for production
RUN npm run build 

# Use a smaller image for the final build
FROM nginx:alpine

# Copy the built Angular app from the builder image to the nginx image
COPY --from=builder /app/dist/my-app/browser /usr/share/nginx/html

# Expose port 80 to the external world
EXPOSE 80

# Start nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
