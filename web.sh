#!/bin/bash

echo "Creando el contenedor"
lxc launch ubuntu:20.04 web1 --target mvirtual2
sleep 20s

echo "Instalando servidor Apache en Web1"
lxc exec web1 -- apt-get update && apt-get upgrade
lxc exec web1 -- apt-get install -y apache2
rm -rf index.html
lxc file pull -- web1/var/www/index.html .
echo "<!DOCTYPE html>" >> index.html
echo "<html>" >> index.html
echo "<body>" >> index.html
echo "<h1>Pagina de prueba WEB1</h1>" >> index.html
echo "<p>Bienvenidos a mi contenedor Web1</p>" >> index.html
echo "<p>Presentado por Andres Diaz 2130104</p>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
lxc file push index.html web1/var/www/html/index.html
rm -rf index.html
lxc exec web1 -- systemctl restart apache2

echo "Creando el contenedor"
lxc launch ubuntu:20.04 web1bkp --target mvirtual2
sleep 20s

echo "Instalando servidor Apache en Web1_Backup"
lxc exec web1bkp -- apt-get update && apt-get upgrade
lxc exec web1bkp -- apt-get install -y apache2
rm -rf index.html
lxc file pull -- web1bkp/var/www/index.html .
echo "<!DOCTYPE html>" >> index.html
echo "<html>" >> index.html
echo "<body>" >> index.html
echo "<h1>Pagina de prueba WEB1-BACKUP</h1>" >> index.html
echo "<p>Bienvenidos a mi contenedor Web1 (Backup)</p>" >> index.html
echo "<p>Presentado por Andres Diaz 2130104</p>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
lxc file push index.html web1bkp/var/www/html/index.html
lxc exec web1bkp -- systemctl restart apache2

echo "Creando el contenedor"
lxc launch ubuntu:20.04 web2 --target mvirtual2
sleep 20s

echo "Instalando servidor Apache en Web2"
lxc exec web2 -- apt-get update && apt-get upgrade
lxc exec web2 -- apt-get install -y apache2
rm -rf index.html
lxc file pull -- web2/var/www/index.html .
echo "<!DOCTYPE html>" >> index.html
echo "<html>" >> index.html
echo "<body>" >> index.html
echo "<h1>Pagina de prueba WEB2</h1>" >> index.html
echo "<p>Bienvenidos a mi contenedor Web2</p>" >> index.html
echo "<p>Presentado por Andres Diaz 2130104</p>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
lxc file push index.html web2/var/www/html/index.html
rm -rf index.html
lxc exec web2 -- systemctl restart apache2

echo "Creando el contenedor"
lxc launch ubuntu:20.04 web2bkp --target mvirtual2
sleep 20s

echo "Instalando servidor Apache en Web2_Backup"
lxc exec web2bkp -- apt-get update && apt-get upgrade
lxc exec web2bkp -- apt-get install -y apache2
rm -rf index.html
lxc file pull -- web2bkp/var/www/index.html .
echo "<!DOCTYPE html>" >> index.html
echo "<html>" >> index.html
echo "<body>" >> index.html
echo "<h1>Pagina de prueba WEB2-BACKUP</h1>" >> index.html
echo "<p>Bienvenidos a mi contenedor Web2 (Backup)</p>" >> index.html
echo "<p>Presentado por Andres Diaz 2130104</p>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
lxc file push index.html web2bkp/var/www/html/index.html
lxc exec web2bkp -- systemctl restart apache2



