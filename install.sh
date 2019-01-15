#!/usr/bin/env bash

echo "Step 1. Install Repositories to source folder"

source="sites"
frontend="address-frontend"
backend="address-backend"

if [ ! -d "$source" ]; then

  mkdir ${source}

fi

if [ ! -d "${source}/${frontend}" ]; then
    echo "  ...Installing ${frontend}"
    git clone https://github.com/olelarssen/address-frontend.git "${source}/${frontend}"
fi

if [ ! -d "${source}/${backend}" ]; then
    echo "  ...Installing ${backend}"
    git clone https://github.com/olelarssen/address-backend.git "${source}/${backend}"
fi

echo "Done"
echo "Step 2. Set environment variables"

if [[ ! -e ${source}/${backend}/.env ]] ; then
    echo "  Copy .env to backend"
    cp storage/app/env/.env ${source}/${backend}/.env
fi

if [ ! -d "storage/logs" ]; then
    echo "Setup logs folder"
    mkdir -p storage/logs
    if [ ! -d "storage/logs/nginx" ]; then
        mkdir -p storage/logs/nginx
        mkdir -p storage/logs/nginx/${frontend}
        touch storage/logs/nginx/${frontend}/error.log
        touch storage/logs/nginx/${frontend}/access.log
        mkdir -p storage/logs/nginx/${backend}
        touch storage/logs/nginx/${backend}/error.log
        touch storage/logs/nginx/${backend}/access.log
        touch storage/logs/nginx/error.log
        touch storage/logs/nginx/access.log
    fi
    echo "Done"
fi

echo "Step 3. Setup docker"
docker-compose up -d
docker exec php-fpm-test sh -c "cd /var/www/address-backend && composer install"
docker exec php-fpm-test sh -c "cd /var/www/address-backend && php bin/console doctrine:migrations:migrate --no-interaction && cd /var/www/address-frontend && npm install && npm run build"
echo "Done"
