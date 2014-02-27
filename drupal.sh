#!/bin/bash
#############################################################################
# Drupal Script by Aaron Krieshok ~ projectlumen.com & holydrupal.org       #
#############################################################################

# Variables #################################################################
web_root=/var/www;
mysql_admin_name="root";
mysql_admin_pass=${1};
db_name="drupal_db";
db_user="root";
db_pass=${1};
drupal_pass=${2};
domain="drampal.dev";

#############################################################################
echo "<========== Building Drupal ==========>";

# Get Drupal
cd ${web_root};
drush dl && mv drupal* drupal && mv drupal/* drupal/.htaccess drupal/.gitignore . && rm -rf drupal;

# Setup the Site Folder
cp ${web_root}/sites/default/default.settings.php ${web_root}/sites/default/settings.php
mkdir -p ${web_root}/sites/default/files;
chown www-data:www-data ${web_root}/sites/default/files;
chown www-data:www-data ${web_root}/sites/default/settings.php;

# Settings File
settings_file="${web_root}/sites/default/settings.php";
sed -i -e 's/$databases = array.*/$databases = array (/g' ${settings_file}; sed -i -ne '/$databases = array/a\'$'\n''  '\''default'\'' => \'$'\n''  array (\'$'\n''    '\''default'\'' =>\'$'\n''    array (\'$'\n''      '\''database'\'' => '\'"${db_name}"\'',\'$'\n''      '\''username'\'' => '\'"${db_user}"\'',\'$'\n''      '\''password'\'' => '\'"${db_pass}"\'',\'$'\n''      '\''host'\'' => '\''localhost'\'',\'$'\n''      '\''port'\'' => '\'\'',\'$'\n''      '\''driver'\'' => '\''mysql'\'',\'$'\n''      '\''prefix'\'' => '\'\'',\'$'\n''    ),\'$'\n''  ),\'$'\n'');'$'\n'';p' ${settings_file};

# Create Database
mysql -u${mysql_admin_name} -p${mysql_admin_pass} -e "CREATE DATABASE ${db_name};";
mysql -u${mysql_admin_name} -p${mysql_admin_pass} -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO ${db_user}@localhost IDENTIFIED BY '${db_pass}';";
mysql -u${mysql_admin_name} -p${mysql_admin_pass} -e "FLUSH PRIVILEGES;";

# Install Site
cd ${web_root}/sites/default;
drush si -y minimal --site-name="Drampal" --account-name=admin --account-pass=${drupal_pass} --account-mail=name@mail.com;

# Hosts File (until Docker figures out how to let us edit the hosts file ~ )
cp /etc/hosts /hostsbak;
umount /etc/hosts;
while read line
do
  echo -e "$line" >> /etc/hosts;
done < /hostsbak;
echo "127.0.0.1  ${domain}" >> /etc/hosts;
rm -f /hostsbak;

# HTTPD
echo "<Directory /var/www>
   RewriteEngine on
   RewriteBase /
   RewriteCond %{REQUEST_FILENAME} !-f
   RewriteCond %{REQUEST_FILENAME} !-d
   RewriteRule ^(.*)$ index.php?q=\$1 [L,QSA]
</Directory>" >> /etc/apache2/httpd.conf


echo "<========== Built Drupal ==========>";
