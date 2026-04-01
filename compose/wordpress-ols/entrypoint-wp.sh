#!/bin/bash
set -e

WP_PATH="/var/www/vhosts/localhost/html"

# Descargar WordPress si no existe
if [ ! -f "$WP_PATH/wp-config.php" ] && [ ! -f "$WP_PATH/wp-login.php" ]; then
    echo "Descargando WordPress..."
    mkdir -p "$WP_PATH"
    wp core download --path="$WP_PATH" --locale=es_ES --allow-root

    # Generar wp-config.php
    wp config create \
        --path="$WP_PATH" \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST:-db}" \
        --allow-root

    chown -R nobody:nogroup "$WP_PATH"
    echo "WordPress descargado y configurado."
fi

# Arrancar OLS
exec /entrypoint.sh
