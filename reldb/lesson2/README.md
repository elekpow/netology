
# Домашнее задание к занятию «Работа с данными (DDL/DML)» Игорь Левин


Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1
1.1. Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.

1.2. Создайте учётную запись sys_temp. 

1.3. Выполните запрос на получение списка пользователей в базе данных. (скриншот)

1.4. Дайте все права для пользователя sys_temp. 

1.5. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

1.6. Переподключитесь к базе данных от имени sys_temp.

Для смены типа аутентификации с sha2 используйте запрос: 
```sql
ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```
1.6. По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.

1.7. Восстановите дамп в базу данных.

1.8. При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных. (скриншот)


* Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.


---

### Выполнение задания 1.

**1.1 Устанавливаю MySQL в Docker , с несложным паролем для 'root' пользователя**

```

version: '3.8'
services:
  mysql-my:
    image: mysql:8.0
    environment:
      - MYSQL_DATABASE=mydb
      - MYSQL_ROOT_PASSWORD=mq!2saFw6
    ports:
      - "3306:3306"
    volumes:
      - db:/var/lib/mysql
	  - ./db:/var/db

volumes:
  db:
```

Найдем контейнер с MySQL:

`docker ps -a |grep mysql:8.0 | cut -d' ' -f 1`

подключимся к контейнеру:

`docker exec -it f1117f0187f5 /bin/bash`


и в терминале введем команду для подключения к MySQL
`mysql -u root -p`


 ![terminal.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson2/images/terminal.JPG)


**1.2 Создаю пользователя 'sys_temp'**

`CREATE USER 'sys_temp'@'localhost' IDENTIFIED BY 'password';`


Получение списка пользователей:

`SELECT User,Host FROM mysql.user;`

**1.3**

 ![users.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson2/images/users.JPG)
 
 **1.4  все права для пользователя sys_temp**
 
 ```
 GRANT ALL PRIVILEGES ON * . * TO 'sys_temp'@'localhost';
 
 FLUSH PRIVILEGES;
 ```
 
 **1.5  запрос на получение списка прав для пользователя sys_temp**
 
 `show grants for 'sys_temp'@'localhost';`
 
 ![grant-sys_temp.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson2/images/grant-sys_temp.JPG)



**1.6**  Переподключаюсь к базе данных от имени **sys_temp**
 
 
 `ALTER USER 'sys_temp'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';`

 
 `SYSTEM mysql -u sys_temp -p`
 
 `select user();`
 
 ![switch_user.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson2/images/switch_user.JPG)


**1.7** А теперь восстановим базу данных из дампа: 

Скачиваю и распаковываю архив с базой данных в каталог `./db` , который проброшен в конейнер 'mysql-my' `/var/db/`

```
curl -O https://downloads.mysql.com/docs/sakila-db.zip > ./db/sakila-db.zip

unzip ./db/sakila-db.zip -d ./db
```

Найдем контейнер с MySQL:

`docker ps -a |grep mysql:8.0 | cut -d' ' -f 1`

подключимся к контейнеру:

`docker exec -it f1117f0187f5 /bin/bash`


восстановим базу данных из дампа:

```
mysql -u sys_temp -p -e "create database sakila";`
mysql -u sys_temp -p ${sakila} < /var/db/sakila-db/sakila-schema.sql
mysql -u sys_temp -p ${sakila} < /var/db/sakila-db/sakila-data.sql
```

Команда для получения всех таблиц базы данных:

`mysql -u sys_temp -p -e "use sakila; show tables";`

 ![show_tables.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson2/images/show_tables.JPG)


### Задание 2
Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца: в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц. Пример: (скриншот/текст)
```
Название таблицы | Название первичного ключа
customer         | customer_id
```

---

### Выполнение задания 2.


команда для получения значений первичных ключей из  **INFORMATION_SCHEMA** будет выглядеть так:
```
mysql -u sys_temp -p -e "USE sakila; SELECT TABLE_NAME AS 'Название таблицы', COLUMN_NAME AS 'Название первичного ключа' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'sakila'  AND COLUMN_KEY = 'PRI'";
```
```
+---------------------------------+--------------------------------------------------+
| Название таблицы                | Название первичного ключа                        |
+---------------------------------+--------------------------------------------------+
| actor                           | actor_id                                         |
| address                         | address_id                                       |
| category                        | category_id                                      |
| city                            | city_id                                          |
| country                         | country_id                                       |
| customer                        | customer_id                                      |
| film                            | film_id                                          |
| film_actor                      | actor_id                                         |
| film_actor                      | film_id                                          |
| film_category                   | category_id                                      |
| film_category                   | film_id                                          |
| film_text                       | film_id                                          |
| inventory                       | inventory_id                                     |
| language                        | language_id                                      |
| payment                         | payment_id                                       |
| rental                          | rental_id                                        |
| staff                           | staff_id                                         |
| store                           | store_id                                         |
+---------------------------------+--------------------------------------------------+
```

Подключимся к MySQL `mysql -u sys_temp -p` и выполним `SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));`

теперь мы сможем выполнить группировку:

```
SELECT TABLE_NAME , GROUP_CONCAT(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'sakila' AND COLUMN_KEY = 'PRI' GROUP BY TABLE_NAME;
```


А теперь зададим для столбцов заголовки : 'Название таблицы' и 'Название первичного ключа', это можно передать через терминал.

```
mysql -u sys_temp -p -e "USE sakila; SELECT TABLE_NAME AS 'Название таблицы' , GROUP_CONCAT(COLUMN_NAME) AS 'Название первичного ключа' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'sakila' AND COLUMN_KEY = 'PRI' GROUP BY TABLE_NAME; ";
```
```
+---------------------------------+--------------------------------------------------+
| Название таблицы 		  | Название первичного ключа			|
+---------------------------------+--------------------------------------------------+
| actor                           | actor_id                                         |
| address                         | address_id                                       |
| category                        | category_id                                      |
| city                            | city_id                                          |
| country                         | country_id                                       |
| customer                        | customer_id                                      |
| film                            | film_id                                          |
| film_actor                      | actor_id,film_id                                 |
| film_category                   | category_id,film_id                              |
| film_text                       | film_id                                          |
| inventory                       | inventory_id                                     |
| language                        | language_id                                      |
| payment                         | payment_id                                       |
| rental                          | rental_id                                        |
| staff                           | staff_id                                         |
| store                           | store_id                                         |
+---------------------------------+--------------------------------------------------+
```
 ![COLUMN_KEY_group.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson2/images/COLUMN_KEY_group.JPG)

### Задание 3*
3.1. Уберите у пользователя sys_temp права на внесение, изменение и удаление данных из базы sakila.

3.2. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

*Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.*

---

### Выполнение задания 3*.

Чтобы убрать у пользователя **sys_temp** права на внесение, изменение и удаление данных из базы **sakil** выполним:

```
USE sakila;
REVOKE INSERT, ALTER, UPDATE, DELETE ON * FROM 'sys_temp'@'localhost';
FLUSH PRIVILEGES;
```

Результат выполнения:

 ![grant-sys_temp_revoke.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson2/images/grant-sys_temp_revoke.JPG)


