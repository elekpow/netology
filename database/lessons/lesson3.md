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

  logstash:
     container_name: logstash
     image: logstash:7.17.9
     ports:
      - "9600:9600"
    volumes:
      - ./logstash.conf:/logstach.conf:ro
    command: logstash -f /logstash.conf

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
  
 nginx: nginx:1.25
   ports:
     - 80:80
   volumes:
     - ./nginxlog:/var/log/nginx
   restart: always


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

---

в процессе выполнения возникли сложности при сборке в Docker, данные не приходят в Logstash

- [варианты сборок в docker] (https://github.com/elekpow/netology/tree/main/database/files);


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