Сначала гененриреуем ssh ключ для подключения к серверу

```
$ ssh-keygen -t rsa
```
читаем публичный ключ и записываем его в файл **metadata**

$ cat ~/.ssh/id_rsa.pub

```
#cloud-config Пример ключа
users:
  - name: <UserName> # Имя пользователя
    groups: sudo 	
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABA4HNvTKAQzyb84OwV8O+Rgk6Xx0KaawV462m9EibG3msuHeGezHqNEa9SpAvfZOCqU2znhZ9fn8eVIuF+9FGtHA7I4y1/X8yvt511dZ1XpCjra1B8eZgZAOMtmXyNy6ZA2I4gQ/AjfB0L9tmgIyx6nuGeF8v/RWIBqCFTEpnHFN1g57KRjsU5mekBZwN7enlnsHRrUl36zcxRlo+MKC+EVy9/uAQ4dnwkkvHdCcNHCcMwhwzAuIsEim8NJWhAOJhAONNxKbUMt6M7t/liuXPi8VH1uK2cjoHrrm2wLeFRVQ5r0kXpUn7eNJd/if0zspJMXMUfo9fBHQATf or@deb1

```


Запускаем менеджер ключей для SSH для того что бы авторизовываться не вводя парольную фразу. Кроме того это нужно что бы Ansible подключился к серверам (в настройках у него указан agent)
```
eval "$(ssh-agent -s)" 
ssh-add ~/.ssh/id_rsa

```
---

После запуска `terraform init` создаются сервера с нужной конфигурацией

terraform output выведет ip адреса серверов

подключение к ним выполняем просто `ssh <UserName>@<ip>`

сразу же захоим в докер контейнер , **replication-master**  это  имя контейнера

```
sudo docker exec -it replication-master sh 
sudo docker exec -it replication-slave sh 
```

или же подключаемся к mysql , пароль для root задем в конфиге docker-compose.yml   

```
sudo docker exec -it replication-slave mysql -uroot -p
sudo docker exec -it replication-master mysql -u root -p
```
---
