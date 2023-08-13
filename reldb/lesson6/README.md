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


```
├── ansible
│   ├── ansible.cfg
│   ├── install.yml
│   ├── inventory
│   ├── logs
│   │   └── ansible.log
│   ├── master.yml
│   ├── slave.yml
├── files
│   ├── docker-compose.yml
├── get-docker.sh
├── infrastructure1.tf
├── main.tf
├── metadata.yml
├── outputs.tf
├── ssh-agent.sh
└── variables.tf
```

На два сервера будут установлены СУБД MySQL  с конфигурациями для Master-сервера и slave-сервера

Установка MySQL через ansible, который задаст необхоиме настройки



конфигурация для Master-сервера 
```
---
- name: master module
  hosts: all
  become: yes
  tasks:
  - name:  "create master my.cnf"
   # become: true
    copy:
      dest: "/tmp/docker/my.cnf"
      content: |
        [mysqld]
        bind-address=0.0.0.0
        server_id = 1
        log_bin=/var/log/mysql/mybin.log
		log_bin = mysql-bin

```
конфигурация для slave-сервера
```
---
- name: slave module
  hosts: all
  become: yes
  tasks:
  - name:  "create slave my.cnf"
   # become: true
    copy:
      dest: "/tmp/docker/my.cnf"
      content: |
        [mysqld]
        bind-address=0.0.0.0
		log_bin = mysql-bin
		server_id = 2
		relay-log = /var/lib/mysql/mysql-relay-bin
		relay-log-index = /var/lib/mysql/mysql-relay-bin.index
		read_only = 1
```


 ![img1.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/img1.JPG)
 
 ![img2.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/img2.JPG)


состояние Мастер сервера


 ![master.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/master.JPG)


Создаем пользователь с правами репликации

```
CREATE USER 'replication'@'%' IDENTIFIED WITH mysql_native_password BY 'Pass12345';
GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';

ALTER USER 'replication' IDENTIFIED WITH mysql_native_password BY 'Pass12345';
```

Конфигурция slave-сервера
```
CHANGE MASTER TO MASTER_HOST='192.168.10.17', MASTER_USER='replication', MASTER_PASSWORD='Pass1234', MASTER_LOG_FILE='mysql-bin.000003', MASTER_LOG_POS = 1735;
```


 ![slave.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson6/images/slave.JPG)


На этом этапе возникла ошибка (Error connecting to source), пока в процессе устранения



