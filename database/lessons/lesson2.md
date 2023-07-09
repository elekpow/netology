# Домашнее задание к занятию  <br/> ***«Кеширование Redis/memcached» <br/>  Левин Игорь***

---

### Задание 1. Кеширование 

Приведите примеры проблем, которые может решить кеширование. 

*Приведите ответ в свободной форме.*

---

**Выполнение задания 1.**

Кеширование это механизм  временного хранения данных, сохраняющий данные в специальном буфере обмена (кэше), позволяющий ускорить получение данных, и снизить нагрузку на источник данных. Если запрошенные данные находятся в кэше, то они будут получены намного быстрее.
- Кеширование увеличивает производительность, сохраняя результаты предыдущих запросов в памяти и обращаться непосредственно к ним при последующих запросах.
- Кеширование позволяет снизить нагрузку на ресурсы, такие как базы данных или удаленные серверы, путем минимизации количества запросов.

---

### Задание 2. Memcached

Установите и запустите memcached.

*Приведите скриншот systemctl status memcached, где будет видно, что memcached запущен.*

---

**Выполнение задания 2.**


![memcached.JPG](https://github.com/elekpow/netology/blob/main/database/images/memcached.JPG)



---

### Задание 3. Удаление по TTL в Memcached

Запишите в memcached несколько ключей с любыми именами и значениями, для которых выставлен TTL 5. 

*Приведите скриншот, на котором видно, что спустя 5 секунд ключи удалились из базы.*

---

**Выполнение задания 3.**


после установки memcached 

```
sudo apt update && apt install memcached
```

Определяем порт на котором запущен **memcached**

![memcached.JPG](https://github.com/elekpow/netology/blob/main/database/images/ports.JPG)

```
memcached 1670 memcache   26u  IPv4  20308      0t0  TCP 127.0.0.1:11211 (LISTEN)
```

**порт: 11211**


Для проверки Memcached можно передать команды через telnet 


**подключение**

```
 telnet localhost 11211
```

**ввод данных:**

```
set key flags exptime bytes <value>

```
**key**:  ключ к сохраненным данным.

**flags**: 32-разрядное целое число без знака, которое сервер сохраняет вместе с данными (предоставленными пользователем) и возвращает вместе с данными при извлечении элемента.

**exptime**: время истечения в секундах, 0 означает отсутствие задержки, если *exptime* превышает 30 дней, Memcached будет использовать его в качестве временных меток UNIX для истечения срока действия.

**bytes**:  количество байт в блоке данных


**<value>** данные


----
**получить данные:**

```
get KEY
```

**очистить данные кэша:**

```
flush_all

```

---

 установим время 5 секунд


![memcached_key.JPG](https://github.com/elekpow/netology/blob/main/database/images/memcached_key.JPG)

---

очистка данных кэша

![flush.JPG](https://github.com/elekpow/netology/blob/main/database/images/flush.JPG)

---

протестируем redis и установим время 120 секунд

![image1.JPG](https://github.com/elekpow/netology/blob/main/database/images/image1.JPG)

по истечении 120 секунд 

![image2.JPG](https://github.com/elekpow/netology/blob/main/database/images/image2.JPG)






---

### Задание 4. Запись данных в Redis

Запишите в Redis несколько ключей с любыми именами и значениями. 

*Через redis-cli достаньте все записанные ключи и значения из базы, приведите скриншот этой операции.*

---

**Выполнение задания 4.**

Установим Redis

```
sudo apt install -y redis
sudo systemctl status redis
```


 перебор ключей в Redis `redis-cli SCAN 0`  
 - "0" - начальный курсор для перебора
 
 записать данные в Redis с помощью CLI `redis-cli SET key value`

- установить время жизни (TTL) для ключа -  параметр `EX`,  `SET key value EX <time>`

- Удалить ключи из базы данных `redis-cli flushall`

---

Ввод строки с ключём `redis-cli set test:1:string "value"`

Получить значение по ключу `redis-cli get test:1:string` 

---

![redis.JPG](https://github.com/elekpow/netology/blob/main/database/images/redis.JPG)


![redis-cli.JPG](https://github.com/elekpow/netology/blob/main/database/images/redis-cli.JPG)



---

### Задание 5*. Работа с числами 

Запишите в Redis ключ key5 со значением типа "int" равным числу 5. Увеличьте его на 5, чтобы в итоге в значении лежало число 10.  

*Приведите скриншот, где будут проделаны все операции и будет видно, что значение key5 стало равно 10.*

---

**Выполнение задания 5.**

 
По умолчанию Redis интерпретирует значение как целое число (тип "int").

`redis-cli set key5 5`

Команда установит значение 5 для ключа "key5". 


`redis-cli incrby key5 5`

Увеличим значение на 5


![image_redis-cli.JPG](https://github.com/elekpow/netology/blob/main/database/images/image_redis-cli.JPG)

