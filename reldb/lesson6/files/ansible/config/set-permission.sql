USE mysql;
CREATE USER 'replication'@'%';
CREATE USER 'replication'@'localhost';
ALTER USER 'replication' IDENTIFIED WITH mysql_native_password BY 'Pass12345';

GRANT ALL PRIVILEGES ON *.* TO 'replication'@'%';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'replication'@'localhost';
FLUSH PRIVILEGES;