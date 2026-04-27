# Build Stage
FROM node:22-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production Stage (Under 30MB footprint)
FROM nginx:alpine-slim

# Nginx natively handles SIGQUIT for graceful shutdown.
# Setting the stopsignal ensures Docker waits for current requests to finish before killing the container.
STOPSIGNAL SIGQUIT

# Remove default nginx config and replace with our optimized one
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy static assets from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port and start nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
