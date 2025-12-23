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
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# PHP extensions
RUN docker-php-ext-install pdo pdo_mysql pdo_sqlite pdo_pgsql mbstring bcmath gd

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# ✅ IMPORTANT: correct working dir
WORKDIR /var/www/html

# Copy app
COPY . .

# Install deps
RUN composer install --no-interaction --optimize-autoloader \
    && npm install \
    && npm run build

# Permissions
RUN chown -R www-data:www-data storage bootstrap/cache

EXPOSE 80

CMD service nginx start && php-fpm