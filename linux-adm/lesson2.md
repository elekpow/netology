# Домашнее задание к занятию "Управление пакетами"
---

### Кейс 1.

Опишите плюсы работы с пакетным менеджером и репозиторием.

* Как вы считаете, в чем основные достоинства такой организации ПО?
* Есть ли минусы?

* Напишите ответ в свободной форме.
---

**Выполнение кейса 1.**


* Применение пакетного менеджера и репозитория имеет преимущество в сравнении например установкой из deb пакета. При загрузке проверяются зависимости и загружаются более новые версии. Кроме того если программы, нет в официальном репозитории, то можете подключить дополнительный. Дополнительные репозитории в Ubuntu и основанных на нем дистрибутивах называются PPA-репозитории. Для работы с репозиториями можно использовать удобный графический интерфейс или пользоваться специальными командами в терминале Linux.  Из минусов репозиториев можно выделить то что там находится программное обеспечение с открытым исходным кодом, а не на проприетарное


---

### Кейс 2.

При подключении стороннего репозитория надо выполнить ряд определенных действий.

* Каких?
* В чем опасность такого способа распространения ПО?
* Как это решается?

* Напишите ответ в свободной форме.

---

**Выполнение кейса 2.**

* Вся работа с репозиториями в Linux заключается в добавлении и удалении адресов репозиториев, расположенных в директории /etc/apt. Файл sources.list содержит основные репозитории, для дополнительных можно добавить файлы ***.list** в каталог.

* Добавить репозиторий можно открыв на редактирование файл sources.list

`sudo nano /etc/apt/sources.list` 

и добавив например так:

```
deb http://deb.debian.org/debian/ stretch main
deb-src  http://deb.debian.org/debian/ stretch main
```
можно также подключить репозиторий с несвободными компонентами системы, добавив contrib non-free после main:
```
deb http://deb.debian.org/debian/ stretch main contrib non-free
deb-src http://deb.debian.org/debian/ stretch main contrib non-free
```
Сторонний репозиторий, например chrome
```
sudo nano /etc/apt/sources.list.d/google-chrome.list
deb http://dl.google.com/linux/chrome/deb/ stable main
```

* Существует опасность добавления сторонних репозиториев, ведь на нем могут находиться любые файлы и  проверить что содержащихся в них не просто. По умолчанию система не может доверять сторонним ресурсам, и для того чтобы это исправить нужно импортировать ключ репозитория вида **“*.pub”**. Сами ключи можно найти на сайте, где выложен сам репозиторий и инструкции по подключению.


---

### Кейс 3.

#### Перейдем к практике.

1. Запустите свою виртуальную машину.
2. Найдите в репозиториях и установите одной командой пакет `htop`.

Какие зависимости требует `htop`?

* Ответ приведите в виде текста команды, которой вы это выполнили, а также приложите скриншот места расположения исполняемых файлов установленного ПО.*

---

**Выполнение кейса 3.**

---

`sudo apt install htop` 

![img6.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img6.jpg)

`sudo apt-cache depends htop`

![img7.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img7.jpg)


---

### Кейс 4.

1. Подключите репозиторий PHP и установите PHP 8.0.

*Приложите скриншот содержимого файла, в котором записан адрес репозитория.

2. При помощи команды `php -v` убедитесь, что бы поставлена корректная версия PHP.

* Приложите к ответу скриншот версии.

---

**Выполнение кейса 4.**

![img8.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img8.jpg)

**php -v**

![img9.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img9.jpg)



---

### Кейс 5.

Ваш коллега-программист просит вас установить модуль `google-api-python-client` на сервер, который необходим для программы, работающей с Google API.

Установите данный пакет при помощи менеджера пакетов `pip`.

**Примечение №1:** для установки может быть необходим пакет `python-distutils`, проверьте его наличие в системе.

**Примечение №2:** не забудьте выдать права на исполение скачанному файлу. Возможно, будет ошибка при установки при помощи Python версии 2, в таком случае воспользйтесь командой `python3`.

* Приложите скриншоты  с установленным пакетом `python-distutils`, с версией `Pip` и установленными модулями (должны быть видимы)

---

**Выполнение кейса 5.**


![img10.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img10.jpg)


![img11.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img11.jpg)


