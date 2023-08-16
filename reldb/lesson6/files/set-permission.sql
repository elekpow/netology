 USE mysql;
 CREATE USER 'replication'@'%';
 ALTER USER 'replication' IDENTIFIED WITH mysql_native_password BY 'Pass12345';
 GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';
 FLUSH PRIVILEGES;