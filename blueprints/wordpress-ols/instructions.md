
## WordPress + OpenLiteSpeed

Despliega WordPress con OpenLiteSpeed (OLS) como servidor web, MySQL 8.0 y Redis 7.

### Tras el despliegue

Una vez que el servicio esté en verde, instala WordPress ejecutando en la terminal del contenedor `wordpress`:

```bash
WP_PATH=/var/www/vhosts/localhost/html

# Descargar WordPress (ajusta --locale si necesitas otro idioma)
wp core download --path=$WP_PATH --locale=es_ES --allow-root

# Crear wp-config.php (usa las variables de entorno del stack)
wp config create \
  --path=$WP_PATH \
  --dbname=$DB_NAME \
  --dbuser=$DB_USER \
  --dbpass=$DB_PASSWORD \
  --dbhost=db \
  --allow-root

# Instalar WordPress
wp core install \
  --path=$WP_PATH \
  --url=https://TU_DOMINIO \
  --title="Mi Sitio" \
  --admin_user=admin \
  --admin_email=tu@email.com \
  --allow-root

# Instalar plugin de caché Redis
wp plugin install redis-cache --activate --path=$WP_PATH --allow-root
wp config set WP_REDIS_HOST redis --path=$WP_PATH --allow-root
wp redis enable --path=$WP_PATH --allow-root

# Ajustar permisos
chown -R nobody:nogroup $WP_PATH
```

### Redis Object Cache

El stack incluye Redis configurado. Para activar la caché de objetos en WordPress, instala el plugin **Redis Object Cache** desde el panel de administración o con WP-CLI (ya incluido en los comandos anteriores).

### Notas

- OLS sirve en el puerto `8088` internamente; Traefik redirige el tráfico HTTPS.
- Los datos de WordPress persisten en el volumen `wp_data`.
- La configuración del vhost OLS se genera automáticamente al arrancar.
