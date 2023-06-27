 # Домашнее задание к занятию "4.12 HTTP/HTTPS"

------
### Задание 1.

Какие коды ответов HTTP лучше соответствуют описанным ситуациям?

- Данная страница не найдена;
- Страница была перенесена на новый сайт;
- Ресурс удален;
- Пользователь не авторизован для просмотра страницы;
- Превышен лимит запросов от пользователя.

* Приведите ответ в свободной форме.

--- 

**Выполнение задания: Задание 1.**

* Данная страница не найдена;
**код - 404 Not Found («не найдено»)**

*Страница была перенесена на новый сайт;
**код - 301 Moved Permanently («перемещено навсегда»)**

*Ресурс удален;
**код - 410 Gone («удалён»)**

*Пользователь не авторизован для просмотра страницы;
**код - 401 Unauthorized («не авторизован (не представился)»)**

*Превышен лимит запросов от пользователя.
**код - 429 Too Many Requests («слишком много запросов»)**


### Задание 2.

1. Установите Nginx.

`sudo apt-get install nginx`

2. Сгенерируйте сертификат для него указав `localhost` в качестве `CN`.

`sudo openssl req -x509 -nodes -newkey rsa:4096 -keyout /etc/nginx/cert.key -out /etc/nginx/cert.pem -days 365`

3. Отредактируйте модуль `http` в файле `/etc/nginx/nginx.conf`.

```
http {
    gzip on;
    server {
        listen 80 default_server;
        root   /var/www/public;
        listen  443 ssl http2 default_server;
        server_name  localhost;
        ssl_certificate  /etc/nginx/cert.pem;
        ssl_certificate_key /etc/nginx/cert.key;
        ssl_protocols   TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers   HIGH:!aNULL:!MD5;
        location / {
            index index.html;
        }
    }
}
```

4. Создайте файл `/var/www/public/index.html` c содержимым.

```
<h1>It works</h1>
```

5. Зайдите на страницу в браузере, пропустив сообщение о неработающем сертификате.

* Пришлите скриншот работающей страницы https://localhost.
--- 

**Выполнение задания: Задание 2.**


![img5.jpg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/img5.jpg)



------

### Задание 3.

Измените конфигурацию сервера добавив переадресацию c Вашего сервера на сайт `netology.ru`.
```
location / {
  return 301 https://netology.ru;
}
```

* Используя curl сделайте запрос к своему серверу и в качестве ответа пришлите скриншот с 301 ответом.
--- 

**Выполнение задания: Задание 3.**

![img6.jpg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/img6.jpg)


---

### Задание 4*.

Используя документацию https://httpd.apache.org/docs/current/ установите `apache2` веб-сервер.

Сделайте задание 2, добившись аналогичной работы сервера.

* Пришлите получившуюся конфигурацию в качестве ответа.
--- 

**Выполнение задания: Задание 4.**


настроив apache, 
создаем виртуальный хост на 443 порту, и прописываем пути к имеющимся сертификатам

```
<VirtualHost *:443>
    ServerName localhost
    DocumentRoot /var/www/public
    SSLEngine on
    SSLCertificateFile /etc/nginx/cert.pem
    SSLCertificateKeyFile /etc/nginx/cert.key   
</VirtualHost>

```

***Веб сервер Apache работает по ssl**


![img_7.jpg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/img_7.jpg)
