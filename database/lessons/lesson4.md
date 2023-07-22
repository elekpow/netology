# Домашнее задание к занятию </br>  «Очереди RabbitMQ» </br>  Игорь Левин

---

### Задание 1. Установка RabbitMQ

Используя Vagrant или VirtualBox, создайте виртуальную машину и установите RabbitMQ.
Добавьте management plug-in и зайдите в веб-интерфейс.

*Итогом выполнения домашнего задания будет приложенный скриншот веб-интерфейса RabbitMQ.*

---

**Выполнение задания 1.**

Установка RabbitMQ

можно установить в докере :

`docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.9-management`

или установить в систему:

- Добавление ключей в систему:
```
sudo apt install curl gnupg -y
curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
curl -1sLf https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/gpg.E495BB49CC4BBE5B.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/io.cloudsmith.rabbitmq.E495BB49CC4BBE5B.gpg > /dev/null
curl -1sLf https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/gpg.9F4587F226208342.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/io.cloudsmith.rabbitmq.9F4587F226208342.gpg > /dev/null
```

- Добавление репозиториев

`sudo apt install apt-transport-https`

создаем rabbitmq.list

`sudo nano /etc/apt/sources.list.d/rabbitmq.list`

и добавляем репозитории Erlang:

```
deb [signed-by=/usr/share/keyrings/io.cloudsmith.rabbitmq.E495BB49CC4BBE5B.gpg] https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/deb/ubuntu bionic main
deb-src [signed-by=/usr/share/keyrings/io.cloudsmith.rabbitmq.E495BB49CC4BBE5B.gpg] https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/deb/ubuntu bionic main
```
Затем репозитории RabbitMQ:

```
deb [signed-by=/usr/share/keyrings/io.cloudsmith.rabbitmq.9F4587F226208342.gpg] https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/deb/ubuntu bionic main
deb-src [signed-by=/usr/share/keyrings/io.cloudsmith.rabbitmq.9F4587F226208342.gpg] https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/deb/ubuntu bionic main
```

`sudo apt update -y`

- Установка всех необходимых пакетов erlang:

```
sudo apt install -y erlang-base \
erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
erlang-runtime-tools erlang-snmp erlang-ssl \
erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
```

проверка установки: 

```
erl
```

![erl.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/erl.JPG)

Установка RabbitMQ :

`sudo apt-get install rabbitmq-server -y --fix-missing`

Включить сервис

`sudo systemctl enable rabbitmq-server`

Проверяем работу `sudo systemctl status rabbitmq-server`,


Запустить серевер и получить доступ через web интерфес: 

`sudo rabbitmq-plugins enable rabbitmq_management` он доступен  на **15672** порту, по умолчанию логин и пароль для доступа - **guest** . 

![rabbitmq-server.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/rabbitmq-server.JPG)

Настрока доступа:

Создать пользователя: `sudo rabbitmqctl add_user <user> <password>`

Установка прав пользователя (администратор):

`sudo rabbitmqctl set_user_tags <user> administrator`

`sudo rabbitmqctl set_permissions -p / <user> ".*" ".*" ".*"`


![rabbitmq-web.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/rabbitmq-web.JPG)


---

### Задание 2. Отправка и получение сообщений

Используя приложенные скрипты, проведите тестовую отправку и получение сообщения.
Для отправки сообщений необходимо запустить скрипт producer.py.

Для работы скриптов вам необходимо установить Python версии 3 и библиотеку Pika.
Также в скриптах нужно указать IP-адрес машины, на которой запущен RabbitMQ, заменив localhost на нужный IP.

```shell script
$ pip install pika
```

Зайдите в веб-интерфейс, найдите очередь под названием hello и сделайте скриншот.
После чего запустите второй скрипт consumer.py и сделайте скриншот результата выполнения скрипта

*В качестве решения домашнего задания приложите оба скриншота, сделанных на этапе выполнения.*

Для закрепления материала можете попробовать модифицировать скрипты, чтобы поменять название очереди и отправляемое сообщение.

---

**Выполнение задания 2.**

[скрипты из задания](https://github.com/netology-code/sdb-homeworks/tree/main/11-04)


![screen1.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/screen1.JPG)




запуск скрипта приводит к ошибке  

```
  File "consumer.py", line 14
    channel.basic_consume(callback, queue='hello', no_ack=True)
                                                              ^
IndentationError: unindent does not match any outer indentation level
```

Установлен Python 3.7.3, pip 18.1

для исправления, модифицирую скрипт, заменяю строку 

`channel.basic_consume(callback, queue='hello', no_ack=True)` 
на 

`channel.basic_consume('hello', callback, auto_ack=True)`


![screen2.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/screen2.JPG)



---

### Задание 3. Подготовка HA кластера

Используя Vagrant или VirtualBox, создайте вторую виртуальную машину и установите RabbitMQ.
Добавьте в файл hosts название и IP-адрес каждой машины, чтобы машины могли видеть друг друга по имени.

Пример содержимого hosts файла:
```shell script
$ cat /etc/hosts
192.168.0.10 rmq01
192.168.0.11 rmq02
```
После этого ваши машины могут пинговаться по имени.

Затем объедините две машины в кластер и создайте политику ha-all на все очереди.

*В качестве решения домашнего задания приложите скриншоты из веб-интерфейса с информацией о доступных нодах в кластере и включённой политикой.*

Также приложите вывод команды с двух нод:

```shell script
$ rabbitmqctl cluster_status
```

Для закрепления материала снова запустите скрипт producer.py и приложите скриншот выполнения команды на каждой из нод:

```shell script
$ rabbitmqadmin get queue='hello'
```

После чего попробуйте отключить одну из нод, желательно ту, к которой подключались из скрипта, затем поправьте параметры подключения в скрипте consumer.py на вторую ноду и запустите его.

*Приложите скриншот результата работы второго скрипта.*



---

**Выполнение задания 3.**


откроем TCP порты для кластера 

sudo ufw allow 15672/tcp
sudo ufw allow 5672/tcp
sudo ufw allow 4369/tcp
sudo ufw allow 25672/tcp
sudo ufw reload


Каждый сервер имеет файл `/var/lib/rabbitmq/.erlang.cooke` что бы настроить кластер
нужно что бы на всех узлах имелся одинаковый файл .erlang.cookie

выполним копирование на второй сервер

`sudo scp /var/lib/rabbitmq/.erlang.cookie root@192.168.56.103:/var/lib/rabbitmq/`


перезапустим службу RabbitMQ на втором сервере

`sudo systemctl restart rabbitmq-server`

и остановим приложение rabbitmqctl

`sudo rabbitmqctl stop_app`


После этого добавим в кластер RabbitMQ 

`sudo rabbitmqctl join_cluster rabbit@deb1`

Затем запустите приложение RabbitMQ.

`sudo rabbitmqctl start_app`

**Проверим состояния кластера RabbitMQ:** 

на первом сервере выполним: `sudo rabbitmqctl cluster_status`

![cluster1.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/cluster1.JPG)

 
-  Зеркалирование очередей через политику RabbitMQ

Политика **ha-all** позволяет всем очередям быть зеркалированными на всех узлах кластера RabbitMQ.

`sudo rabbitmqctl set_policy ha-all ".*" '{"ha-mode": "all"}'`


![cluster2.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/cluster2.JPG)


**Установим  rabbitmqadmin**

```
wget https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/v3.7.3/bin/rabbitmqadmin
chmod 777 rabbitmqadmin
```
выполним команду ` ./rabbitmqadmin get queue='hello'`

Результат выполнения:

![rabbitmqadmin.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/rabbitmqadmin.JPG)


![rabbitmqadmin-web.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/rabbitmqadmin-web.JPG)


выполнения скрипта `consumer.py` на удаленной машине

**скрипт  consumer.py**

```
#!/usr/bin/env python
# coding=utf-8
import pika

# remote connection
credentials = pika.PlainCredentials('admin', '123456')  # авторизация
parameters = pika.ConnectionParameters('192.168.56.103', credentials=credentials)
connection = pika.BlockingConnection(parameters)

channel = connection.channel()
channel.queue_declare(queue='hello')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)

channel.basic_consume(queue='hello',
                     # auto_ack=True,
                      on_message_callback=callback,
                      auto_ack=False,)


channel.start_consuming()
```


![rabbitmq-web2.JPG](https://github.com/elekpow/netology/blob/main/database/images/rabbitmq/rabbitmq-web2.JPG)



