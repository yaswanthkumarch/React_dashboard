# Step 1: Use an official Node.js runtime as a parent image
FROM node:16 AS build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json into the container
COPY package*.json ./

# Step 4: Install dependencies inside the container
RUN npm install

# Step 5: Copy the rest of the React app into the container
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use an official Nginx image to serve the app
FROM nginx:alpine

# Step 8: Copy the build folder from the previous image to Nginx's public folder
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 80 to the outside world
EXPOSE 80

# Step 10: Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
