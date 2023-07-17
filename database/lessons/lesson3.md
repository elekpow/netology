# Домашнее задание к занятию <br/> ***«ELK» <br/>  Левин Игорь***

---

## Дополнительные ресурсы

При выполнении задания используйте дополнительные ресурсы:
- [docker-compose elasticsearch + kibana](https://github.com/netology-code/sdb-homeworks/blob/main/11-03/docker-compose.yaml);
- [поднимаем elk в docker](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/docker.html);
- [поднимаем elk в docker с filebeat и docker-логами](https://www.sarulabs.com/post/5/2019-08-12/sending-docker-logs-to-elasticsearch-and-kibana-with-filebeat.html);
- [конфигурируем logstash](https://www.elastic.co/guide/en/logstash/7.17/configuration.html);
- [плагины filter для logstash](https://www.elastic.co/guide/en/logstash/current/filter-plugins.html);
- [конфигурируем filebeat](https://www.elastic.co/guide/en/beats/libbeat/5.3/config-file-format.html);
- [привязываем индексы из elastic в kibana](https://www.elastic.co/guide/en/kibana/7.17/index-patterns.html);
- [как просматривать логи в kibana](https://www.elastic.co/guide/en/kibana/current/discover.html);
- [решение ошибки increase vm.max_map_count elasticsearch](https://stackoverflow.com/questions/42889241/how-to-increase-vm-max-map-count).

### Задание 1. Elasticsearch 

Установите и запустите Elasticsearch, после чего поменяйте параметр cluster_name на случайный. 

*Приведите скриншот команды 'curl -X GET 'localhost:9200/_cluster/health?pretty'', сделанной на сервере с установленным Elasticsearch. Где будет виден нестандартный cluster_name*.

---

**Выполнение задания 1.**

Для выполнеия создаю конфигурацю в docker-compose

```
version: '3.7'

services:
  # Elasticsearch Docker Images: https://www.docker.elastic.co/
  elasticsearch:
    image: elasticsearch:7.17.9
    container_name: elasticsearch
    environment:
      - xpack.security.enabled=false
      - discovery.type=single-node
    ulimits:
      memlock:
        soft: -1
        hard: -1
      nofile:
        soft: 65536
        hard: 65536
    cap_add:
      - IPC_LOCK
    volumes:
      - elasticsearch-data:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
      - 9300:9300


  kibana:
    container_name: kibana
    image: kibana:7.17.9
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    ports:
      - 5601:5601
    depends_on:
      - elasticsearch

  filebeat:
    image: docker.elastic.co/beats/filebeat:7.17.9
    command: --strict.perms=false
    user: root
    volumes:
      - ./filebeat.yml:/usr/share/filebeat/filebeat.yml:ro
      - /var/lib/docker:/var/lib/docker:ro
      - /var/run/docker.sock:/var/run/docker.sock
  

volumes:
  elasticsearch-data:
    driver: local

```

скриншот Elasticsearch

![image-Elasticsearch.JPG](https://github.com/elekpow/netology/blob/main/database/images/image-Elasticsearch.JPG)

---

### Задание 2. Kibana

Установите и запустите Kibana.

*Приведите скриншот интерфейса Kibana на странице http://<ip вашего сервера>:5601/app/dev_tools#/console, где будет выполнен запрос GET /_cluster/health?pretty*.

---

**Выполнение задания 2.**

 Выполнение /app/dev_tools#/console


![Kibana.JPG](https://github.com/elekpow/netology/blob/main/database/images/Kibana.JPG)

---

### Задание 3. Logstash

Установите и запустите Logstash и Nginx. С помощью Logstash отправьте access-лог Nginx в Elasticsearch. 

*Приведите скриншот интерфейса Kibana, на котором видны логи Nginx.*

---

**Выполнение задания 3.**

Для получения логов необходимо настроить  Logstash и Nginx и внести изменеия в docker-compose.yml

1)  добавим logstach в docker-compose.yml

файл [docker-compose.yaml](https://github.com/elekpow/netology/blob/main/database/files/docker-compose.yaml)

```
  logstash:
    image: docker.elastic.co/logstash/logstash:7.17.9
    container_name: logstash-7.17.9
    user: root
    volumes:
      - ./logstash/config/logstash.yml:/usr/share/logstash/config/logstash.yml:ro
      - ./logstash/config/logstash.conf:/usr/share/logstash/config/logstash.conf:ro
      - ./logstash/config/pipelines.yml:/usr/share/logstash/config/pipelines.yml:ro
      - ./log:/usr/share/logstash/nginx
    command: logstash -f /usr/share/logstash/config/logstash.conf
    networks:
      - elk-network
    ports:
      - "5044:5044"
      - "9600:9600"
    depends_on:
      - elasticsearch
    restart: always
	
```

добавим nginx в docker-compose.yml




```
 nginx:
    image: nginx:alpine
    container_name: nginx
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/public:/usr/share/nginx/html:ro
      - ./log:/var/log/nginx
    links:
      - elasticsearch
      - kibana
    depends_on:
      - elasticsearch
      - kibana
    ports:
      - '80:80'
    networks:
      - elk-network
    restart: always

```
через **volumes**, проброшен каталог логов nginx ` - ./log:/var/log/nginx`

```
├── log
│   ├── access.log
│   └── error.log
```

2) настройка nginx

`- ./nginx/public` каталог с тестовой страницей index.html 


`- ./nginx/etc/nginx.conf:/etc/nginx/nginx.conf:ro` конфигурация Nginx


**nginx.conf**

файл [nginx.conf](https://github.com/elekpow/netology/blob/main/database/files/nginx.conf)

```
user  nobody;
worker_processes  1;

error_log  /var/log/nginx/error.log;


events {
    worker_connections  10;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    keepalive_timeout  65;

    server {
        listen       80;
        server_name  _;

        access_log  /var/log/nginx/access.log main;

        location / {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
        }
    }
}
```

**log_format  main**  - в этом параметре задается формат логов


3) настройка Logstach  

файл [Logstach.conf](https://github.com/elekpow/netology/blob/main/database/files/logstach.conf)

```
input {
        file {
        path => "/usr/share/logstash/nginx/access.log"
        start_position => "beginning"
        }
}

filter {
    grok {
        match => { "message" => "%{IPORHOST:remote_ip} - %{DATA:user_name}
\[%{HTTPDATE:access_time}\] \"%{WORD:http_method} %{DATA:url}
HTTP/%{NUMBER:http_version}\" %{NUMBER:response_code} %{NUMBER:body_sent_bytes}
\"%{DATA:referrer}\" \"%{DATA:agent}\"" }
    }
    mutate {
        remove_field => [ "host" ]
    }
}

output {
    stdout {}
    elasticsearch {
        hosts => ["http://elasticsearch:9200"]
        data_stream => "true"
   }
}
```

**path =>** задает место откуда Logstach будет брать логи

в **docker-compose.yaml**  для  logstach установлено `- ./log:/usr/share/logstash/nginx`


задаем filter с помощью grok-шаблона, который анализирует лог-сообщения и при помощи регулярных выражений создает необходимую структуру.

для теста запросов nginx использовались несколькоов браузеров: Opera/9Portable , и Yandex Chrome

пример сообщения переданого в лог nginx:

```
192.168.56.1 - - [17/Jul/2023:13:32:17 +0000] "GET /favicon.ico HTTP/1.1" 404 153 "http://192.168.56.102/" "Opera/9.80 (Windows NT 6.2; U; ru) Presto/2.10.229 Version/11.60" "-"

192.168.56.1 - - [17/Jul/2023:13:32:43 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 YaBrowser/23.5.4.674 Yowser/2.5 Safari/537.36" "-"

```

Структура соответсвует шаблону. В примере ошибка 404 , говорит о том что не найден /favicon.ico 

```
%{IPORHOST:remote_ip}			192.168.56.1
%{DATA:user_name}				-
[%{HTTPDATE:access_time}\]		[17/Jul/2023:13:32:17 +0000]]
%{WORD:http_method} 			GET
%{DATA:url}						/favicon.ico
HTTP/%{NUMBER:http_version}		HTTP/1.1
%{NUMBER:response_code}			404
%{NUMBER:body_sent_bytes}		153
%{DATA:referrer}			"http://192.168.56.102/"
%{DATA:agent}				"Opera/9.80 (Windows NT 6.2; U; ru) Presto/2.10.229 Version/11.60"
```



Cкриншот интерфейса Kibana

![Nginx_log_logstash.JPG](https://github.com/elekpow/netology/blob/main/database/images/Nginx_log_logstash.JPG)



---

### Задание 4. Filebeat. 

Установите и запустите Filebeat. Переключите поставку логов Nginx с Logstash на Filebeat. 

*Приведите скриншот интерфейса Kibana, на котором видны логи Nginx, которые были отправлены через Filebeat.*

---

**Выполнение задания 4.**

---



---

### Задание 5*. Доставка данных 

Настройте поставку лога в Elasticsearch через Logstash и Filebeat любого другого сервиса , но не Nginx. 
Для этого лог должен писаться на файловую систему, Logstash должен корректно его распарсить и разложить на поля. 

*Приведите скриншот интерфейса Kibana, на котором будет виден этот лог и напишите лог какого приложения отправляется.*

---

**Выполнение задания 5*.**

---