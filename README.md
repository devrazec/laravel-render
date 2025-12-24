# Laravel as a Docker on render.com

Building a Project with Laravel + React + Docker + Apache + SQLite

# Commands

```

-- Create App

composer create laravel/laravel .

npm i

php artisan migrate:fresh

php artisan db:seed

php artisan key:generate
php artisan key:generate --show

-- Edit composer.json 

"require": { 
    "ext-pdo_sqlite": "*",
    "ext-sqlite3": "*"
}

composer update
npm run build

-- Composer

composer require symfony/clock:^7.0 symfony/css-selector:^7.0
composer update
change /laravel-docker/composer.lock where are "^8.4", to 8.2

-- Run Bankend

php artisan serve --port=8080
php artisan serve

-- Docker

docker build -t laravel-render -f Dockerfile .

docker run -itd \
--restart unless-stopped \
--name laravel-render \
--hostname laravel-render.local \
-p 80:80 \
laravel-render

```

# Links


