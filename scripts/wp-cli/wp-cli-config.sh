#!/bin/bash

# Wordpress Configuration
echo -e "\e[96m================================================="
    echo -e "\e[96m=============== Install Wordpress ==============="
    echo -e "\e[96m================================================="
    
    # Verify if Wordpress it's installed
    if ! $(wp core is-installed); then
        wp core install \
        --path="/var/www/html" \
        --url="${WPCLI_WOOCOMMERCE_URL}" \
        --title="${WPCLI_WOOCOMMERCE_TITLE}" \
        --admin_user="${WPCLI_WOOCOMMERCE_ADMIN_USER}" \
        --admin_password="${WPCLI_WOOCOMMERCE_ADMIN_PASSWORD}" \
        --admin_email="${WPCLI_WOOCOMMERCE_ADMIN_EMAIL}" 
        # --skip-email
    else
        echo "✅ Wordpress Installed"
    fi

    # [Database] Update Wordpress Home
    wp option update home "${MACHINE_HOST}:${WORDPRESS_LOCALHOST_PORT}"
    
    # [Database] Update Wordpress Site URL
    wp option update siteurl "${MACHINE_HOST}:${WORDPRESS_LOCALHOST_PORT}"
    
    # [Database] Update Wordpress Blog Name
    wp option update blogname "Nome de um blog"
    
    # [Database] Update Wordpress Blog Description
    wp option update blogdescription "Descrição de um blog"

    wp option update mailserver_url "mail.example.com"

    wp option update mailserver_login "login@example.com"

    wp option update mailserver_pass "password"

    wp option update mailserver_port "110"

    

    

    

    
    
    # [Config File] Update Wordpress Config File Wordpress Home
    wp config set WP_HOME "${MACHINE_HOST}:${WORDPRESS_LOCALHOST_PORT}"
    
    # [Config File] Update Wordpress Config File Wordpress Site URL
    wp config set WP_SITEURL "${MACHINE_HOST}:${WORDPRESS_LOCALHOST_PORT}"
    
    # Configure Permalinks
    wp rewrite structure '/%postname%/'
    
    # Plugins Configuration
    echo -e "\e[96m================================================="
    echo -e "\e[96m========== Install and Activate Plugins ========="
    echo -e "\e[96m================================================="
    
    # Install and activate Woocommerce
    if ! $(wp plugin is-active woocommerce); then
        wp plugin install woocommerce --activate
    else
        echo "✅ Woocommerce Installed and Activated"
    fi
    
    # Install and activate Google Tag Manager
    if ! $(wp plugin is-active duracelltomi-google-tag-manager); then
        wp plugin install duracelltomi-google-tag-manager --activate
    else
        echo "✅ Google Tag Manager Installed and Activated"
    fi

    # Install and activate wp-rest-api-authentication
    if ! $(wp plugin is-active wp-rest-api-authentication); then
        wp plugin install wp-rest-api-authentication --activate
    else
        echo "✅ WP Rest API Authentication Installed and Activated"
    fi

    
   
    # Activate StoreFront
    if ! $(wp theme is-active storefront); then
        wp theme activate storefront
    fi
    
    # Google Tag Manager Configuration
    echo -e "\e[96m================================================="
    echo -e "\e[96m========== Configure Google Tag Manager ========="
    echo -e "\e[96m================================================="
    
    wp option patch update gtm4wp-options gtm-code "${GTM4WP_ADMIN_GTMID}"
    
    # Woocommerce Configuration
    echo -e "\e[96m================================================="
    echo -e "\e[96m============= Configure Woocommerce ============="
    echo -e "\e[96m================================================="
   
    wp option set woocommerce_store_address "${WPCLI_WOOCOMMERCE_STORE_ADDRESS}"
    wp option set woocommerce_store_address_2 "${WPCLI_WOOCOMMERCE_STORE_ADDRESS_2}"
    wp option set woocommerce_store_city "${WPCLI_WOOCOMMERCE_STORE_CITY}"
    wp option set woocommerce_default_country "${WPCLI_WOOCOMMERCE_DEFAULT_COUNTRY}"
    wp option set woocommerce_store_postalcode "${WPCLI_WOOCOMMERCE_STORE_POSTALCODE}"
    wp option set woocommerce_currency "${WPCLI_WOOCOMMERCE_STORE_CURRENCY}"
    wp option set woocommerce_product_type "${WPCLI_WOOCOMMERCE_STORE_PRODUCT_TYPE}"
    wp option set woocommerce_allow_tracking "${WPCLI_WOOCOMMERCE_STORE_ALLOW_TRACKING}"
    wp wc --user=admin tool run install_pages

    # Remover informações em cache (Transientes)
    echo -e "\e[96mRemove Transients"
    wp transient delete --all

#ACCOUNT ID 6002667896
#937579336285-n5j4bhsafk9soh892slhplm2v4s1kq4i.apps.googleusercontent.com
#7uYhCK5yJA0scLYdMrop4aMC
