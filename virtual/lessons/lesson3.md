# Домашнее задание к занятию «Docker. Часть 1»

---

### Задание 1

**Ответьте на вопрос в свободной форме.** 

Чем контейнеризация отличается от виртуализации?
---

**Выполнение  задания 1**

* Контейнеризация позволяет запускать на одной хостовой операционной системе несколько изолированных контейнеров, содержащие все необходимые библиотеки и зависимости необходимые для запуска приложения. Эта технология  позволяет упаковывать приложения и их зависимости вместе, и  упрощает их развертывание и масштабирование. Размер создаваемого контейнера намного меньше в сравнении с размером отдельной виртуальной машины. 

* При виртуализации создается полностью отдельная операционная система, а распределением ресурсов и изоляцию друг от друга обеспечивает гипервизор. Несколько виртуальных машин могут работать на одном базовом устройстве отдельно друг от друга. Количество виртуальных машин, которые можно иметь одновременно, ограничено только ресурсами хост-компьютера.



---

### Задание 2 

**Выполните действия:**

1. Установите Docker.
1. Приложите скриншот.
---

**Выполнение  задания 2**

* Этапы установки (из инструкции docs.docker.com )

```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

**устанавливаем репозиторий**

```
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

![img19.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img19.jpg)

```
sudo apt-get update
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update
```

![img20.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img20.jpg)

* **Устанавливаем docker**

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

* **Docker установлен**

![img21.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img21.jpg)




---

### Задание 3

**Выполните действия:**

1. Запустите образ hello-world.
1. Приложите скриншот.

---

**Выполнение  задания 3**

`sudo docker run hello-world`


![img22.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img22.jpg)




---

### Задание 4 

**Выполните действия:**

1. Удалите образ hello-world.
1. Приложите скриншот.

---

**Выполнение  задания 4**

* Последовательность действий для удаления образа: 

```
sudo docker container ls -a
sudo docker rm  “CONTAINER ID”
sudo docker image ls
sudo docker rmi “IMAGE ID”
```
![img23.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img23.jpg)

---

### Задание 5*

1. Найдите в Docker Hub образ apache и установите его.
1. Приложите:
 * скриншоты сетевых настроек вашей виртуальной машины;
 * скриншоты работающих контейнеров;
 * скриншот браузера, где вы открыли дефолтную страницу вашего apache внутри контейнера.

---

**Выполнение  задания 5**


* Сетевые настройки тестовой виртуальной машины `2:eth0  10.100.101.11 `

* Видно что после установки docker появился еще` 3:docker0`



![img24.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img24.jpg)



* Работающие контейнеры

```
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                               NAMES
0df7119bbc6e   f65670fcc09a   "/bin/sh -c 'apachec…"   8 minutes ago    Up 8 minutes    0.0.0.0:86->80/tcp, :::86->80/tcp   upbeat_ptolemy
4f7fa636cd9f   8c3a4cd19a55   "/bin/sh -c 'apachec…"   32 minutes ago   Up 31 minutes   0.0.0.0:84->80/tcp, :::84->80/tcp   thirsty_mirzakhani
97d60eed2aef   405d379385a9   "/bin/sh -c 'apachec…"   36 minutes ago   Up 36 minutes   0.0.0.0:82->80/tcp, :::82->80/tcp   fervent_panini
```

![img25.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img25.jpg)


* Скриншоты страниц браузера


![img26.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img26.jpg)


---

### Задание 6*

1. Создайте свой Docker образ с Apache2 и подмените стандартную страницу index.html на страницу, содержащую ваши ФИО.
1. Приложите:
 * скриншот содержимого Dockerfile;
 * скриншот браузера, где apache2 из вашего контейнера выводит ваши ФИО.

---

**Выполнение  задания 6**

* Устанавливаю docker на виртуальную машину, в Yandex Cloud, создаю файл **my_name** , при выполнении копирования он заменит файл **index.html**
содержимое файла (структура html)

![img27.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img27.jpg)

![img28.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img28.jpg)


* Вывод на внешний ip , заголовок страницы My Name

![img29.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img29.jpg)


---
