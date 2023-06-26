 # Домашнее задание к занятию "Производительность системы. Часть 2."

------

### Задание 1.

Составьте задание через утилиту `cron` на проверку обьема кэша-обновлений еженедельно.

Кэш-обновлений - это обновления которые остаются после выполнения `apt update`, `apt upgrade`.

*Приведите ответ в виде команды.*


---

**Выполнение задания 1.**


Создаю в директории пользователя каталог **cache**, в него будет попадать файл **apt-cache_дата** содержащий информацию о размере кэша, создаю там же скрипт **cache.sh** с командой 
```
du -sch /var/cache/apt/ >/home/levin/cache/apt-cache_$(date +%Y%m%d) 
```

добавляю задание в cron:  `sudo crontab -e` 

```

* * * * 6 /home/levin/cache/cache.sh  

```
*  (выполнять каждую неделю  в субботу) 



----

### Задание 2.

- Запустите процесс копирования большого файла (1 Гб) на жесткий диск.
- Запустите команду `iostat`.
- Запустите `iotop`.

Какие процессы влияют на данные команды?

*Проведите развернутый ответ и приложите снимки экрана.*


---

**Выполнение задания 2.**


![img44.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img44.jpg)

* iostat позволяет проанализировать загруженность системы. Она выводит основные параметры ввода и вывода данных на диск, скорость записи и чтения данных, а также количество записанных или прочитанных данных.

![img45.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img45.jpg)

* например , если создать файл и произвести копирование, iostat выведет информацию, так после копирования данных на раздел диска sdh в  столбце KB_wrtn - отобразилось количество записанных данных с момента загрузки системы . также была попытка копированя на раздел диска sdi  (7 раз) , количество составило (7365160) 7,0Gb

![img46.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img46.jpg)

**iotop** отобразит процесс и отобразит статистику дискового ввода-вывода.

![img47.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img47.jpg)

* Запустим процесс

![img48.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img48.jpg)

* в другом сеансе запустим **iostat**

![img49.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img49.jpg)

система нагружена, это можно увидеть по %system- в этой колонке процент загрузки центрального процессора,%idle - показывает процент времени, когда процессор простаивал, и система не имела запрос к диску I/O (вход/выход)

![img50.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img50.jpg)

iotop, отобразит, что сейчас запущен процесс копирования. сортировка по записи на диск (DISK_WRITE)

![img51.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img51.jpg)


---

### Задание 3.

Настройте приоритет использования `swap` в пропорции:

- 30/70;
- 50/50;
- 70/30.

Запустите браузер и нагрузите память.

Проанализируйте результат.

*Проведите развернутый ответ и приложите снимки экрана.*


---

**Выполнение задания 3.**

* Запущен браузер, проигрывается видео с сайта **https://youtube.com, разрешением FullHd**. 

* Изменяем значение на `30`. , видно как увеличивается потребление памяти. Используется оперативной памяти всего **1гб**, из-за настроек приоритета, в данном случае используется память swap раздела. В браузере видео сильно тормозит и также возросла нагрузка на процессор. 

![img51.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img51.jpg)
![img52.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img52.jpg)
![img53.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img53.jpg)

* при значении `50`, использование swap немного меньше, прогрузка видео немного улучшилась.

![img54.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img54.jpg)
![img55.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img55.jpg)
![img56.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img56.jpg)

* изменяем значение на `70`, видео прогружается заметно быстрее

![img57.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img57.jpg)
![img58.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img58.jpg)
![img59.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img59.jpg)

* Можно сделать вывод, что при использовании доступной памяти для запущенных процессов становиться достаточно, но работает она медленнее оперативной памяти.


