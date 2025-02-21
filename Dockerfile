# Use official Nginx Alpine image for a lightweight base
FROM nginx:alpine

# Metadata
LABEL maintainer="bigsk1"
LABEL description="Netflix Secret Codes Webpage"

# Remove default Nginx HTML files
RUN rm -rf /usr/share/nginx/html/*

# Copy the built HTML file into the Nginx directory
COPY html/ /usr/share/nginx/html/

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Set permissions for security
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chown nginx:nginx /etc/nginx/nginx.conf && \
    chmod 644 /etc/nginx/nginx.conf

# Harden Nginx by removing unnecessary tools and setting secure defaults
RUN apk update && apk upgrade && \
    rm -rf /var/cache/apk/*

# Expose port 80
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]