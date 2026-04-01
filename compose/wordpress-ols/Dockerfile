FROM litespeedtech/openlitespeed:latest

USER root

# WP-CLI
RUN curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Configuración OLS para WordPress (rewrite rules + PHP handler)
COPY ols-wordpress.conf /usr/local/lsws/conf/vhosts/Example/vhconf.conf

# Script de inicio: descarga WordPress si no existe
COPY entrypoint-wp.sh /entrypoint-wp.sh
RUN chmod +x /entrypoint-wp.sh

ENTRYPOINT ["/entrypoint-wp.sh"]
