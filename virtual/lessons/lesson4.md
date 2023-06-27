# Домашнее задание к занятию «Docker. Часть 2»

---

### Задание 1

**Напишите ответ в свободной форме, не больше одного абзаца текста.**

Установите Docker Compose и опишите, для чего он нужен и как может улучшить вашу жизнь.

---

**Выполнение  задания 1**

* Docker Compose — инструмент, позволяющий запускать среды приложений с несколькими контейнерами на основе определений, задаваемых в файле YAML. Использование файла с конфигурацией значительно ускоряет процесс установки, и развертывание сервисов. Все необходимые параметры описываются в конфигурационном  файле. Такой подход позволяет быстро и легко создавать и запускать различные среды для тестирования приложений, запуск баз данных. Он также обеспечивает удобный способ масштабирования приложений, позволяя добавлять или удалять контейнеры с минимальными усилиями.

---

### Задание 2 

**Выполните действия и приложите текст конфига на этом этапе.** 

Создайте файл docker-compose.yml и внесите туда первичные настройки: 

 * version;
 * services;
 * networks.

При выполнении задания используйте подсеть 172.22.0.0.
Ваша подсеть должна называться: <ваши фамилия и инициалы>-my-netology-hw.


---

**Выполнение  задания 2**

```
version: "3"
services:
networks:
  levinis-my-netology-hw:
    driver: bridge
    ipam:
      config:
      - subnet: 172.22.0.0/24
```

![img30.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img30.jpg)



---

### Задание 3 

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите PostgreSQL с именем контейнера <ваши фамилия и инициалы>-netology-db. 
2. Предсоздайте БД <ваши фамилия и инициалы>-db.
3. Задайте пароль пользователя postgres, как <ваши фамилия и инициалы>12!3!!
4. Пример названия контейнера: ivanovii-netology-db.
5. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.


---

**Выполнение  задания 3**

```
levinis-db:
    image: postgres:latest 
    container_name: levinis-netology-db  
    ports: 
      - 5432:5432
    volumes: 
      - ./pg_data:/var/lib/postgresql/data/pgdata
    environment: 
      POSTGRES_PASSWORD: levinis12!3!!
      POSTGRES_DB: levinis_db 
      PGDATA: /var/lib/postgresql/data/pgdata 
    networks:
      levinis-my-netology-hw:
        ipv4_address: 172.22.0.2
    restart: always 
```

![img31.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img31.jpg)


---

### Задание 4 

**Выполните действия:**

1. Установите pgAdmin с именем контейнера <ваши фамилия и инициалы>-pgadmin. 
2. Задайте логин администратора pgAdmin <ваши фамилия и инициалы>@ilove-netology.com и пароль на выбор.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.
4. Прокиньте на 80 порт контейнера порт 61231.

В качестве решения приложите:

* текст конфига текущего сервиса;
* скриншот админки pgAdmin.


---

**Выполнение  задания 4**

```
pgadmin:
    image: dpage/pgadmin4
    container_name: levinis-pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: levinis@ilove-netology.com
      PGADMIN_DEFAULT_PASSWORD: admin123
    ports:
      - "61231:80"
    networks:
      netology-lesson:
         ipv4_address: 172.22.0.3
    restart: always

```

![img32.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img32.jpg)

![img33.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img33.jpg)


---

### Задание 5 

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите Zabbix Server с именем контейнера <ваши фамилия и инициалы>-zabbix-netology. 
2. Настройте его подключение к вашему СУБД.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.


---

**Выполнение  задания 5**

```
 zabbix-server:
    image: zabbix/zabbix-server-pgsql
    links:
      - levinis-db
    container_name: levinis-zabbix-netology
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: levinis12!3!!
    ports:
      - "10051:10051"
    networks:
      levinis-my-netology-hw:
        ipv4_address: 172.22.0.4
    restart: always

```
![img34.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img34.jpg)




---

### Задание 6

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите Zabbix Frontend с именем контейнера <ваши фамилия и инициалы>-netology-zabbix-frontend. 
2. Настройте его подключение к вашему СУБД.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.


---

**Выполнение  задания 6**

```
zabbix_wgui:
    image: zabbix/zabbix-web-apache-pgsql
    links:
      - levinis-db
      - zabbix-server
    container_name: levinis-netology-zabbix-frontend
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: levinis12!3!!
      ZBX_SERVER_HOST: "zabbix_wgui"
      PHP_TZ: "Europe/Moscow"
    ports:
      - "80:8080"
      - "443:8443"
    networks:
      levinis-my-netology-hw:
        ipv4_addr

```

![img35.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img35.jpg)

**PgAdmin и подключенные базы данных**

![img36.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img36.jpg)




---

### Задание 7 

**Выполните действия.**

Настройте линки, чтобы контейнеры запускались только в момент, когда запущены контейнеры, от которых они зависят.

В качестве решения приложите:

* текст конфига **целиком**;
* скриншот команды docker ps;
* скриншот авторизации в админке Zabbix.


---

**Выполнение  задания 7**


```
version: "3"
services:
  levinis-db:
    image: postgres:latest
    container_name: levinis-netology-db
    ports:
      - 5432:5432
    volumes:
      - ./pg_data:/var/lib/postgresql/data/pgdata
    environment:
      POSTGRES_PASSWORD: levinis12!3!!
      POSTGRES_DB: levinis_db
      PGDATA: /var/lib/postgresql/data/pgdata
    networks:
      levinis-my-netology-hw:
        ipv4_address: 172.22.0.2
    restart: always

  pgadmin:
    image: dpage/pgadmin4
    container_name: levinis-pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: levinis@ilove-netology.com
      PGADMIN_DEFAULT_PASSWORD: admin123
    ports:
      - "61231:80"
    networks:
      levinis-my-netology-hw:
         ipv4_address: 172.22.0.3
    restart: always

  zabbix-server:
    image: zabbix/zabbix-server-pgsql
    links:
      - levinis-db
      - pgadmin
    container_name: levinis-zabbix-netology
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: levinis12!3!!
    ports:
      - "10051:10051"
    networks:
      levinis-my-netology-hw:
        ipv4_address: 172.22.0.4
    restart: always
    
   zabbix_wgui:
    image: zabbix/zabbix-web-apache-pgsql
    links:
      - levinis-db
      - pgadmin
      - zabbix-server
    container_name: levinis-netology-zabbix-frontend
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: levinis12!3!!
      ZBX_SERVER_HOST: "zabbix_wgui"
      PHP_TZ: "Europe/Moscow"
    ports:
      - "80:8080"
      - "443:8443"
    networks:
      levinis-my-netology-hw:
        ipv4_address: 172.22.0.5
    restart: always
networks:
  levinis-my-netology-hw:
    driver: bridge
    ipam:
      config:
      - subnet: 172.22.0.0/24
```


![img37.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img37.jpg)


![img38.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img38.jpg)




---

### Задание 8 

**Выполните действия:** 

1. Убейте все контейнеры и потом удалите их.
1. Приложите скриншот консоли с проделанными действиями.


---

**Выполнение  задания 8**

```
docker stop $(docker ps -a -q)  
docker rm $(docker ps -a -q)  

```

![img39.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img39.jpg)




---

### Задание 9* 

Запустите свой сценарий на чистом железе без предзагруженных образов.

**Ответьте на вопросы в свободной форме:**

1. Сколько ушло времени на то, чтобы развернуть на чистом железе написанный вами сценарий?
2. Чем вы занимались в процессе создания сценария так, как это видите вы?
3. Что бы вы улучшили в сценарии развёртывания?


---

**Выполнение  задания 9**


![img40.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img40.jpg)


* Попытался запустить созданную конфигурацию на виртуальной машине Yandex Cloud 

* все запустилось через 2 минуты, Zabbix и pgAdmin. 

![img41.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img41.jpg)

![img42.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img42.jpg)

* в процессе написания сценария, изучал особенности Yaml, структуру и синтаксис. Проверял какие параметры принимает сервис  postgreSQL. Удачная конфигурация заработала без ошибок.

* Сценарий можно было бы улучшить если бы изучить все возможности контейнеризации.
---

