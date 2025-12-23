FROM php:8.2-fpm

# System deps
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    sqlite3 \
    libsqlite3-dev \
    curl

# PHP extensions
RUN docker-php-ext-install pdo pdo_mysql pdo_sqlite mbstring bcmath gd

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# ✅ IMPORTANT: correct working dir
WORKDIR /var/www/html

# Copy app
COPY . .

# Install deps
RUN composer install --no-dev --optimize-autoloader

# Permissions
RUN chown -R www-data:www-data storage bootstrap/cache

# Nginx
COPY docker/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD service nginx start && php-fpm
