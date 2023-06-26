 # Домашнее задание к занятию "Производительность системы"

------

### Задание 1.

Выполните проверку системы при помощи команды `top`.

**Выведите сортировку процессов по:**

- памяти;
- времени работы;
- номеру;
- уровню потребления ресурсов.

* Приведите ответ в виде снимков экрана.


---

**Выполнение задания 1.**

* Сортировка по памяти
![img32.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img32.jpg)


* Сортировка по времени работы

![img33.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img33.jpg)



* Сортировка по номеру
![img34.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img34.jpg)


* Сортировка по уровню потребления ресурсов


![img35.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img35.jpg)


---

### Задание 2.

Выполните проверку системы при помощи команды `atop` и `atopsar`.

**Выведите сортировку процессов по:**

- общей нагрузке (минимум по трем параметрам);
- загруженности HDD or SSD за указанный временной отрезок (10 минут);
- загруженности RAM за указанный временной отрезок (10 минут).

**Сконфигурировать файл настроек atop - делать снимок памяти каждые пол часа**

* Приведите ответ в виде снимков экрана.


---

**Выполнение задания 2.**


* Сортировка по используемой памяти (M)

![img36.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img36.jpg)

* Сортировка сортировка по нагрузке на процессор (P)


![img37.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img37.jpg)

`atopsar -r /var/log/atop/atop_20221127 -b22:45 -e23:00 -cdm`


![img38.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img38.jpg)

 
`atopsar -r /var/log/atop/atop_20221127 -b23:25 -e00:00 -cdm`


![img39.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img39.jpg)



---


### Задание 3.

При помощи команды `mpstat` и ключа `P` выведите информацию по:

- определённому процессору;
- всем процессорам.

* Приведите ответ в виде снимков экрана.


---

**Выполнение задания 3.**


![img40.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img40.jpg)


`mpstat -P ALL` - **по всем процессорам**


![img41.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img41.jpg)


---

### Задание 4.

Выполните проверку системы при помощи команды `pidstat`.

1. Выведите статистику по эффективности на основе имени процесса.
2. Выведите полный путь процесса.

* Приведите ответ в виде снимков экрана.


---

**Выполнение задания 4.**


![img42.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img42.jpg)

![img43.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img43.jpg)


