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


```
 sudo apt install gparted
```

Установка LUKS

```
 sudo apt-get install cryptsetup
```


```
sudo apt install xrdp -y 
sudo apt update && sudo apt install xfce4 xdm xfce4-xkb-plugin language-pack-ru -y
---
 systemctl status xrdp.service

sudo adduser user

sudo adduser user ssl-cert

sudo passwd -d igor
sudo passwd  igor


---

sudo adduser user
sudo adduser user ssl-cert

sudo apt update && sudo apt install xfce4 xdm xfce4-xkb-plugin language-pack-ru -y

sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config

echo "xfce4-session" | tee ~/.xsession

systemctl enable xdm.service

update-locale LANG=ru_RU.UTF-8 

echo 'FRAMEBUFFER=Y' >> /etc/initramfs-tools/initramfs.conf 

update-initramfs -u -k `uname -r`

```


systemctl status xrdp.service

sudo passwd -d igor

sudo passwd  igor



dd if=/dev/zero of=/tmp/disk.img bs=100M count=5
sudo mkfs ext3 -F /tmp/disk.img

sudo mount /tmp/disk.img /mnt/disk1/





### Задание 3 *

1. Установите **apparmor**.
2. Повторите эксперимент, указанный в лекции.
3. Отключите (удалите) apparmor.


*В качестве ответа пришлите снимки экрана с поэтапным выполнением задания.*


---

**Выполнение задания 3.**

