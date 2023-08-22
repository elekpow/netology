# Домашнее задание к занятию «Базы данных в облаке» <br/> Игорь Левин

---

Домашнее задание подразумевает, что вы уже делали предыдущие работы в Яндекс.Облаке, и у вас есть аккаунт и каталог.


Используйте следующие рекомендации во избежание лишних трат в Яндекс.Облаке:
1) Сразу после выполнения задания удалите кластер.
2) Если вы решили взять паузу на выполнение задания, то остановите кластер.

### Задание 1


#### Создание кластера
1. Перейдите на главную страницу сервиса Managed Service for PostgreSQL.
1. Создайте кластер PostgreSQL со следующими параметрами:
- класс хоста: s2.micro, диск network-ssd любого размера;
- хосты: нужно создать два хоста в двух разных зонах доступности и указать необходимость публичного доступа, то есть публичного IP адреса, для них;
- установите учётную запись для пользователя и базы.

Остальные параметры оставьте по умолчанию либо измените по своему усмотрению.

* Нажмите кнопку «Создать кластер» и дождитесь окончания процесса создания, статус кластера = RUNNING. Кластер создаётся от 5 до 10 минут.

#### Подключение к мастеру и реплике 

* Используйте инструкцию по подключению к кластеру, доступную на вкладке «Обзор»: cкачайте SSL-сертификат и подключитесь к кластеру с помощью утилиты psql, указав hostname всех узлов и атрибут ```target_session_attrs=read-write```.

* Проверьте, что подключение прошло к master-узлу.
```
select case when pg_is_in_recovery() then 'REPLICA' else 'MASTER' end;
```
* Посмотрите количество подключенных реплик:
```
select count(*) from pg_stat_replication;
```

### Проверьте работоспособность репликации в кластере

* Создайте таблицу и вставьте одну-две строки.
```
CREATE TABLE test_table(text varchar);
```
```
insert into test_table values('Строка 1');
```

* Выйдите из psql командой ```\q```.

* Теперь подключитесь к узлу-реплике. Для этого из команды подключения удалите атрибут ```target_session_attrs```  и в параметре атрибут ```host``` передайте только имя хоста-реплики. Роли хостов можно посмотреть на соответствующей вкладке UI консоли.

* Проверьте, что подключение прошло к узлу-реплике.
```
select case when pg_is_in_recovery() then 'REPLICA' else 'MASTER' end;
```
* Проверьте состояние репликации
```
select status from pg_stat_wal_receiver;
```

* Для проверки, что механизм репликации данных работает между зонами доступности облака, выполните запрос к таблице, созданной на предыдущем шаге:
```
select * from test_table;
```

*В качестве результата вашей работы пришлите скриншоты:*

*1) Созданной базы данных;*
*2) Результата вывода команды на реплике ```select * from test_table;```.*


---

**Выполнение задания 1.**


База данных

 ![db.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson9/images/db.JPG)


Результата вывода 


 ![select.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson9/images/select.JPG)



---

### Задание 2*

Создайте кластер, как в задании 1 с помощью Terraform.


*В качестве результата вашей работы пришлите скришоты:*

*1) Скриншот созданной базы данных.*
*2) Код Terraform, создающий базу данных.*


---

**Выполнение задания 2.**


- Создаем кластер через Terraform:


Переменные [variables.tf](https://github.com/elekpow/netology/blob/main/reldb/lesson9/files/variables.tf) 

Конфигурации ресурсов [cluster.tf](https://github.com/elekpow/netology/blob/main/reldb/lesson9/files/cluster.tf) 


Для подключения к PostgreSQL установим Пакет postgresql-client

```
sudo apt install postgresql-client
```

Из настроек  подключения в YandexCloud:

1) установка сертификата
```
mkdir -p ~/.postgresql 
wget "https://storage.yandexcloud.net/cloud-certs/CA.pem"  --output-document ~/.postgresql/root.crt 
chmod 0600 ~/.postgresql/root.crt
```

2) подключение к базе данных

```
psql "host=rc1a-o8u1jsbx3mjiukvh.mdb.yandexcloud.net,rc1a-yzvvhbo353wnabyi.mdb.yandexcloud.net \
    port=6432 \
    sslmode=verify-full \
    dbname=<dbname> \
    user=<username> \
    target_session_attrs=read-write"
```

**username** - имя пользователя заданое при конфигурировании terraform.

**dbname** - название базы данных

**port** - порт для подключения к базе данных 

**host** - Имя хоста присваемое виртуальной машине

Проверяем работоспособность 

 ![terminal.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson9/images/terminal.JPG)
 
Созданый кластер
 
 ![elvm.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson9/images/elvm.JPG)