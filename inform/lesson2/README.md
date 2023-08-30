# Домашнее задание к занятию  «Защита хоста»

------

### Задание 1

1. Установите **eCryptfs**.
2. Добавьте пользователя cryptouser.
3. Зашифруйте домашний каталог пользователя с помощью eCryptfs.


*В качестве ответа  пришлите снимки экрана домашнего каталога пользователя с исходными и зашифрованными данными.*  

---

**Выполнение задания 1.**

Установка **eCryptfs**.
```bash
sudo apt install ecryptfs-utils
```

Добавим пользователя cryptouser

```
sudo adduser cryptouser
```

![user.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/user.JPG)


useradd -m -G root user


---
*можно создать пользователя и сразу же зашифровать домашнюю директорию*
 
```bash
sudo adduser --encrypt-home cryptouser
```
---

Шифрование домашнего каталога пользователя

```bash
igor@elvm:~$ sudo ecryptfs-migrate-home -u cryptouser

INFO:  Checking disk space, this may take a few moments.  Please be patient.
INFO:  Checking for open files in /home/cryptouser
Enter your login passphrase [cryptouser]:
```
![user-crypto.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/user-crypto.JPG)


![user-crypto_home.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/user-crypto_home.JPG)






### Задание 2

1. Установите поддержку **LUKS**.
2. Создайте небольшой раздел, например, 100 Мб.
3. Зашифруйте созданный раздел с помощью LUKS.

*В качестве ответа пришлите снимки экрана с поэтапным выполнением задания.*


---

**Выполнение задания 2.**


Развернем тестовую виртуальную машину в YandexCloud через Terraform, и подключим дополнительный диск.


Конфигурация Terraform для создания диска на 1Tb:

```
# дополнительный диск

resource "yandex_compute_disk" "myhdd" {
  name       = "myhdd"
  type       = "network-hdd"
  zone       = "ru-central1-a"
  size       = 1
}

```

Программа **gparted** имеет графический интерфейс, для этого также установим на виртуальную машину **xrdp**  и **xfce4**

```bash 
sudo apt update
sudo apt install gparted -y
sudo apt install xrdp -y 
sudo apt install xfce4 xdm xfce4-xkb-plugin language-pack-ru -y

 systemctl status xrdp.service

```

Установка LUKS

```
sudo apt-get install cryptsetup
 
```

*для основного пользователя (имеющего права root) зададим пароль `sudo passwd igor`*

подключаемся к виртуальной машине  через RDP 


![xrdp1.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/xrdp1.JPG)


размечаем  раздел диска на 100 Мб 

![xrdp2.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/xrdp1.JPG)


Зашифруем созданый раздел 

` sudo cryptsetup luksFormat /dev/vdb1 `

![crypt.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/crypt.JPG)


![xrdp3.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/xrdp3.JPG)


В **gparted** в меню есть пункт "Open Encryption". При выборе этого пункта будет запрошена парольная фраза. 

![xrdp4.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/xrdp4.JPG)

Так мы получаем доступ к зашифрованому разделу

![xrdp5.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/xrdp5.JPG)


Закрыть зашифрованый раздел:

![xrdp6.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/xrdp6.JPG)


Информация о зашифрованном разделе:

![crypt-luks.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/crypt-luks.JPG)


---

при работе в терминале можно зашифрованый раздел, а также примонтировать:

![crypt-open.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/crypt-open.JPG)


![crypt-mount.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/crypt-mount.JPG)




---

### Задание 3 *

1. Установите **apparmor**.
2. Повторите эксперимент, указанный в лекции.
3. Отключите (удалите) apparmor.


*В качестве ответа пришлите снимки экрана с поэтапным выполнением задания.*


---

**Выполнение задания 3.**

AppArmor - это система управления доступом к файлам на основе имен (Mandatory Access Control).
Контроль доступа для программы осуществляется на основе файла профиля. Профили могут работать в двух режимах: "Enforce" и "Complain"
Для каждой программы, которую нужно контролировать создается файл профиля, если его нет или он отключен, программа выполняется без ограничений.

---

Установка **AppArmor**

```
sudo apt install apparmor-profiles 
sudo apt install apparmor-utils
sudo apt install apparmor-profiles-extra

sudo apparmor_status

```

Загружено 54 профилей, 36  находятся в **enforce** режиме 

![AppArmor.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/AppArmort.JPG)


выполним из примера лекции, попробуем заменить на другую программу (например вирусная программа подменяет оригинальный файл). Подменяем программу **man** на **ping** 

```
 sudo cp /usr/bin/man /usr/bin/man1  #сохраним оригинальный файл
 sudo cp /bin/ping /usr/bin/man     
  
 man 127.0.0.1 # проверяем работу
  
```

Включаем профиль : `sudo aa-complain man` и переходим в режим обучения

Включаем профиль :`sudo aa-enforce man` и происходит "блокировка" программы согласно профиля 


![man-complain.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson2/images/man-complain.JPG)

