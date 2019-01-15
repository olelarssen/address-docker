FROM mysql:5.7

ENTRYPOINT service mysql start \
    && bash ./entrypoint.sh \
    && echo "Create databases..." \
    && echo "CREATE DATABASE IF NOT EXISTS test;" | mysql -uroot -ptest \
    && echo "CREATE USER IF NOT EXISTS 'test'@'%' IDENTIFIED BY 'test';" | mysql -uroot -ptest \
    && echo "GRANT ALL ON test.* TO 'test'@'%';" | mysql -uroot -ptest \
    && echo "FLUSH PRIVILEGES;" | mysql -uroot -ptest \
    && service mysql stop \
    && mysqld --user=root
