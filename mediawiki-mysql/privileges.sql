mysql -u root -p$MYSQLPASS -e "CREATE USER 'wiki1'@'localhost' IDENTIFIED BY 'ENCODEDPASS';"
mysql -u root -p$MYSQLPASS -e "GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki1'@'localhost';FLUSH PRIVILEGES;"
