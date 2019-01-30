#!/bin/bash
p1='/var/www/html'
p2='/var/www/html/code'
p3='/var/www/html/log'
p4='/var/www/html/nginx'

for p in $p1 $p2 $p3 $p4
do
    if [ ! -d "$p" ]
    then
        mkdir "$p"
    fi
done

exec `chown -R www-data:www-data /nas/opt/code /nas/opt/log`

