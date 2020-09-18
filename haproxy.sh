#!/bin/bash

echo "Creando el contenedor"
lxc launch ubuntu:20.04 haproxy --target mvirtual1
sleep 20s

echo "Configurando servidor Haproxy"
lxc exec haproxy -- apt-get update && apt-get upgrade
lxc exec haproxy -- apt-get install -y haproxy 
lxc exec haproxy -- systemctl enable haproxy

echo "Modificando archivo haproxy.cfg"
#lxc exec haproxy -- cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy2.cfg
lxc file pull -- haproxy/etc/haproxy/haproxy2.cfg .
echo -e "\n" >> haproxy2.cfg
echo "backend web-backend" >> haproxy2.cfg
echo "   balance roundrobin" >> haproxy2.cfg
echo "   stats enable" >> haproxy2.cfg
echo "   stats auth admin:admin" >> haproxy2.cfg
echo "   stats uri /haproxy?stats" >> haproxy2.cfg
echo -e "\n" >> haproxy2.cfg
echo "       option allbackups" >> haproxy2.cfg
echo "   server web1 240.4.0.24:80 check" >> haproxy2.cfg
echo "   server web1bkp 240.4.0.204:80 check backup" >> haproxy2.cfg
echo "   server web2 240.4.0.122:80 check" >> haproxy2.cfg
echo "   server web2bkp 240.4.0.83:80 check backup" >> haproxy2.cfg
echo -e "\n" >> haproxy2.cfg
echo "frontend http" >> haproxy2.cfg
echo "   bind *:80" >> haproxy2.cfg
echo "   default_backend web-backend" >> haproxy2.cfg
mv haproxy2.cfg haproxy.cfg
lxc file push haproxy.cfg haproxy/etc/haproxy/haproxy.cfg
rm -rf haproxy.cfg

cat > 503.http
echo "HTTP/1.0 503 Service Unavailable" >> 503.http
echo "Cache-Control: no-cache" >> 503.http
echo "Connection: close" >> 503.http
echo "Content-Type: text/html" >> 503.http
echo -e "\n" >> 503.http
echo "<html>" >> 503.http
echo "<body>" >> 503.http
echo "<h1>&#161Lo sentimos!</h1>" >> 503.http
echo "<p>El servidor no se encuentra disponible pero trabajamos para solucionarlo</p>" >> 503.http
echo "<p>Por favor reintenta mas tarde</p>" >> 503.http
echo "</body>" >> 503.http
echo "</html>" >> 503.http
lxc file push 503.http haproxy/etc/haproxy/errors/503.http
rm -rf 503.http
lxc exec haproxy -- service haproxy restart
#lxc config device add haproxy http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80



