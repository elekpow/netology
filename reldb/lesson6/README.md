# Домашнее задание к занятию «Репликация и масштабирование. Часть 1» <br/> Игорь Левин
---

### Задание 1

На лекции рассматривались режимы репликации master-slave, master-master, опишите их различия.

*Ответить в свободной форме.*

---

**Выполнение задания 1.**

Из определяния понятия репликации следует понимать процесс копирования и распространения баз данных, а также синхронизации баз данных для поддержания согласованности. Сам процесс репликации базы данных представляет собой копирование данных из одного сервера на другой.

Режим репликации master-slave, в котором один основной (мастер) сервер, который является источником данных и может выполнять операции чтения и записи. Другие серверы , назваесые реполиками получают данные от мастер-сервера в режиме чтения. Обновление данных происходит асинхронно.

В режиме репликации master-master, каждый сервер объединияет обе функции работы с данными (чтение, запись), серверы взаимодействуют между собой, чтобы синхронизировать изменения данных. В таком режиме обеспечивается более высокая отказоустойчивость. Каждый из серверов может работать не зависимо от состояния других. 



---

### Задание 2

Выполните конфигурацию master-slave репликации, примером можно пользоваться из лекции.

*Приложите скриншоты конфигурации, выполнения работы: состояния и режимы работы серверов.*

---

**Выполнение задания 2.**

---

Для развертывания двух серверов с СУБД MySQL используем облачную плтаформу Yandex Cloud.
Создадим  структуру из двух серверов. Настроим MySQL.

Развертываение будет осуществляться через terraform, настройка MySQL через Ansible.

```
igor@deb1:~/project3/project2$ tree
.
|-- ansible
|   |-- ansible.cfg
|   |-- config
|   |   |-- conf-server_id.cnf
|   |   |-- conf-server_id_2.cnf
|   |   |-- docker-compose.yml
|   |   |-- docker-compose_2.yml
|   |   `-- set-permission.sql
|   |-- install.yml
|   |-- inventory
|   |-- logs
|   |   `-- ansible.log
|   |-- master.yml
|   `-- slave.yml
|-- infrastructure1.tf
|-- main.tf
|-- metadata.yml
|-- outputs.tf
|-- ssh-agent.sh
`-- variables.tf


```

На два сервера будут установлены СУБД MySQL в **docker** с конфигурациями для Master-сервера и slave-сервера

Установка MySQL через ansible, который задаст необхоимые настройки

Для автоматизации установки в **terraform** в параметре **provisioner "local-exec"** зададим конфигурацию Ansible , для первоначальной подговтовке серверов.



```
## ANSIBLE first install
 provisioner "local-exec" {
   command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.network_interface.0.nat_ip_address},' ./ansible/install.yml"
 }
}
```


выполним генерацию ключей `$ ssh-keygen` и выполним `eval "$(ssh-agent -s)"` и `ssh-add ~/.ssh/id_rsa` для того что бы менеджер ключей запомнил ключ.

публичный ключ добавим в `metadata.yml`, для того что бы иметь доступ к серверам


в секции  **provisioner "local-exec"** укажем `agent = true`
```
    connection {
     ....
     agent = true
	 ....
   }
```




На каждой виртуальное машине через docker compose создадим контейнер с MySQL сервером, сразу же укажем пароль для root

```
    image: mysql:8.0
    container_name: replication-slave
    restart: unless-stopped
    environment:
      - MYSQL_USER=replication  
      - MYSQL_ROOT_PASSWORD=mq!2saFw6
      - MYSQL_ALLOW_EMPTY_PASSWORD=true
    ports:
      - "3306:3306"
    volumes:
      # Files      
      - /tmp/docker/config:/etc/mysql/conf.d/
      # Dir      
      - /tmp/docker/init:/docker-entrypoint-initdb.d
      - /tmp/docker/dump:/dump
      # volumes
      - mysql-data:/var/lib/mysql
      - mysql-logs:/var/log/mysql
```

**в директории `/tmp/docker/config` файл конфигурации сервера `my.cnf`** 


**конфигурация MySQL для Master-сервера (conf-server_id.cnf)**
```
[mysqld]
bind-address=0.0.0.0
server_id = 1
log_bin=mysql-bin
```
**конфигурация MySQL для slave-сервера  (conf-server_id_2.cnf)**
```
[mysqld]
bind-address=0.0.0.0
server_id = 2
log_bin         = mysql-bin
relay_log       = mysql-relay
relay-log-index = mysql-relay-bin.index
read_only = 1
```

**Диретория `/tmp/docker/init` содержит файл **set-permission.sql**, в котором создаем пользователя с правами на репликацию данных, а также пропишем необхоимые привилегии.

```
USE mysql;
CREATE USER 'replication'@'%';
CREATE USER 'replication'@'localhost';

ALTER USER 'replication' IDENTIFIED WITH mysql_native_password BY 'Pass12345';

GRANT ALL PRIVILEGES ON *.* TO 'replication'@'%';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'replication'@'localhost';
FLUSH PRIVILEGES;
```

Получаем ip адреса серверов

 ![img1.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/img1.JPG)


**Настроим master сервер**

с помощью Ansible настроим конфигурацию

```
ansible-playbook ./ansible/master.yml -i "158.160.59.151,"
```

 ![img2.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/img2.JPG)

подключаемся  к первому серверу: `ssh igor@158.160.59.151`

заходим в MySQL
```
sudo docker exec -it replication-master mysql -uroot -p

Enter password:
```

проверим id сервера и статус

```
show variables like 'server_id'; SHOW MASTER STATUS\G;
```

Убедимся, что пользователь созданый для репоикации данных существует:

```
SELECT user,host FROM mysql.user;
````

Проверим существующие базы данных:

```
SHOW DATABASES;
```

 ![master.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/master.JPG)




Открываем новую консоль:

**Настроим slave сервер**

также с помощью Ansible настроим конфигурацию

```
ansible-playbook ./ansible/slave.yml -i "158.160.97.240,"
```

Теперь подключаемся ко второму серверу : `ssh igor@58.160.97.240`

заходим в MySQL
```
sudo docker exec -it replication-slave mysql -uroot -p

Enter password:
```

проверим id сервера 
```
show variables like 'server_id';

````

 ![slave.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/slave.JPG)


Пропишем в базе данных на сервер slave, информацию о master сервере, а также данные полученные в **File** и **Position**

```
CHANGE MASTER TO MASTER_HOST='192.168.10.34', MASTER_USER='replication', MASTER_PASSWORD='Pass12345', MASTER_LOG_FILE='mysql-bin.000003', MASTER_LOG_POS = 157;
```
Запустим  сервер `START SLAVE; ` и проверим статус: `SHOW SLAVE STATUS\G;`

 ![slave-status.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/slave-status.JPG)

------
Что бы убедиться что репликация осуществляется на мастер-сервер создадим базу данных  ` CREATE DATABASE  testDb1;`


сравним выводы двух серверов:

 ![createDb1.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/createDb1.JPG)
 
 
 ![log-status.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/log-status.JPG)



*Дамп базы данных и копирование на другой сервер**

на master сервере: в консоли **mysql** выполняем:`FLUSH TABLES WITH READ LOCK;`, затем выходим `\q` и выполняем Дамп:
```
mysqldump -v  -uroot -p  --all-databases --master-data > /tmp/dump/dump.sql

```
подключаемся к севреру  ` mysql -u root -p` и разблокируем таблицы `UNLOCK TABLES;`

** копируем дамп на другой сервер**
```
 scp /tmp/docker/dump/dump.sql igor@192.168.10.23:/tmp/dump
 
```
подключаемся ко второму севреру, и выполняем воссатновление базы данных
 
```
mysql -u root -p < /tmp/dump/dump.db
``` 

---

### Задание 3* 

Выполните конфигурацию master-master репликации. Произведите проверку.

*Приложите скриншоты конфигурации, выполнения работы: состояния и режимы работы серверов.*

---

**Выполнение задания 3.**

Проверим статуc:

`SHOW MASTER STATUS\G;` **File** и **Position**

 ![slave_m2.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/slave_m2.JPG)
 
 
выполним на первом сервере команду: 
 
 ```
CHANGE MASTER TO MASTER_HOST='192.168.10.23', MASTER_USER='replication', MASTER_PASSWORD='Pass12345', MASTER_LOG_FILE='mysql-bin.000003', MASTER_LOG_POS = 554;
```
  
  В этом случае второй сервер для первого стал мастером.  
  
 Запустим  сервер `START SLAVE; ` и проверим статус: `SHOW SLAVE STATUS\G;`
 
 ![master-master_.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/master-master_.JPG)


---




