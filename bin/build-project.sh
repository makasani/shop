#!/usr/bin/env bash

# Definitions
absolute_filename=`readlink -e "$0"`
path="$(echo `dirname "$absolute_filename"` | sed "s!/bin!!")/"
virtualhost=$(basename $path)
nginx_path="config/nginx/"
nginx_conf="${virtualhost}.nginx"
sys_nginx_path="/etc/nginx/"
available_path="sites-available/"
available_file="${sys_nginx_path}${available_path}${nginx_conf}"
enabled_path="sites-enabled/"
enabled_file="${sys_nginx_path}${enabled_path}${nginx_conf}"
proj_nginx_conf="${path}${nginx_path}shop.nginx"

sudo cp -f "${proj_nginx_conf}" "${available_file}"
sudo sed -i "s!/www/shop/!$path!" ${available_file} 
sudo sed -i "/server_name/ s/shop/$virtualhost/" ${available_file} 
sudo sed -i "/^[ a-z]*_log/ s/shop/$virtualhost/" ${available_file} 
sudo ln -sf ${available_file} ${enabled_file}

grep ${virtualhost} /etc/hosts 1>/dev/null
if [ $? -ne 0 ]
then
    echo -e "127.0.0.1\t${virtualhost}" | sudo tee -a /etc/hosts 1>/dev/null
fi

sudo service nginx restart

# Install symfony bundles
composer install

# Install webpack modules
npm install

# Build webpack
npm run build