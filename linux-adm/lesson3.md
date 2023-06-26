 # Домашнее задание к занятию "Инициализация системы, Init, systemd"

---

### Задание 1.

Выполните systemd-analyze blame.

*Укажите, какие модули загружаются дольше всего.*

---

**Выполнение задания 1.**

* После выполнения команды

![img12.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img12.jpg)

Дольше всех загружаются следующие модули:

|сервис|время загрузки|
|-------------|-------------|
|udisks2.service|8.697s|
|dev-sda1.device|4.665s|
|accounts-daemon.service|4.549s|
|NetworkManager.service|4.490s |
|polkit.service|4.396s |

---

### Задание 2.

Какой командой вы посмотрите ошибки ядра, произошедшие начиная со вчерашнего дня?

*Напишите ответ в свободной форме.*


---

**Выполнение задания 2.**

`sudo journalctl --since yesterday -ek` , с параметром **k** журнал выведет сообщения ядра
  *(k - Show kernel message log from the current boot)*


---

### Задание 3.

Запустите команду loginctl user-status.

*Что выполняет, для чего предназначена эта утилита?*

---

**Выполнение задания 3.**

`loginctl` - Управление системным менеджером входа в систему.

`loginctl user-status`   - Выводит информацию о состоянии сеанса, об одном или нескольких вошедших в систему пользователях, включая список дочерних процессов

Вывод данных команды представлен  в древовидной форме для удобного восприятия.


---

### Задание 4.

Есть ли у вас на машине службы, которые не смогли запуститься? Как вы это определили?

*Приведите ответ в свободной форме.*


---

**Выполнение задания 4.**

---
`systemctl list-units --all --state=inactive`



Можно вывести информацию о  модулях которые загрузила система **systemd**  независимо от их активности в данный момент,  **--all** , а также указать состояние **--state=inactive**, тем самым чтобы отобразить неактивные в данный момент.


![img13.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img13.jpg)



### Задание 5.*

Можно ли с помощью systemd отмонтировать раздел/устройство?

*Приведите ответ в свободной форме.*

---

**Выполнение задания 5.***

---

* Да можно. Команда   `systemctl -l --type mount` , покажет все созданные в systemd точки монтирования.



![img14.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img14.jpg)


`lsblk -f`


![img15.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img15.jpg)


* например берем имеющийся диск **sdj1**   и смонтируем его например в `/mnt/testdir`

    1) нужно создать unit , создаем в /etc/systemd/system  файл например mnt-testdir.mount
    2) содержимое файла будет такое :

```
[Unit]
Description=Mount testdir

[Mount]
What=/dev/sdj1
Where=/mnt/testdir

[Install]
WantedBy=multi-user.target
```

- Секция [Unit] -  описание сервиса
- Секция [Mount], в которой опция **What** содержит абсолютный путь к монтируемому устройству, а опция **Where** указывает точку монтирования.
- Секция [Install] задает уровень запуска сервиса, **multi-user.target** - многопользовательский режим без графики.

* Команда  `systemctl daemon-reload`  - перечитает конфигурацию systemd, 
`systemctl start mnt-test dir.mount` - запустит службу , и в данном случае смонтирует устройство.



![img16.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img16.jpg)

устройство смонтировано успешно, на него можно записать файлы.


![img17.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img17.jpg)

`systemctl -l --type mount`


![img18.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img18.jpg)


**mnt-testdir.mount             loaded active mounted Mount testdir**


команда  `systemd-mount --umount   /mnt/testdir`  отмонтирует созданный раздел. 



