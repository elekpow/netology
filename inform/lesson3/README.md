# Домашнее задание к занятию «Защита сети» <br/> Игорь Левин

------

### Подготовка к выполнению заданий

1. Подготовка защищаемой системы:

- установите **Suricata**,
- установите **Fail2Ban**.

2. Подготовка системы злоумышленника: установите **nmap** и **thc-hydra** либо скачайте и установите **Kali linux**.

Обе системы должны находится в одной подсети.

------

### Задание 1

Проведите разведку системы и определите, какие сетевые службы запущены на защищаемой системе:

**sudo nmap -sA < ip-адрес >**

**sudo nmap -sT < ip-адрес >**

**sudo nmap -sS < ip-адрес >**

**sudo nmap -sV < ip-адрес >**

По желанию можете поэкспериментировать с опциями: https://nmap.org/man/ru/man-briefoptions.html.


*В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.*

------


**Выполнение задания 1.**

Установка зависимостей
```
sudo apt -y install libpcre3 libpcre3-dev build-essential autoconf automake libtool libpcap-dev libnet1-dev libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libmagic-dev libcap-ng-dev libjansson-dev pkg-config libnetfilter-queue-dev geoip-bin geoip-database geoipupdate apt-transport-https
```

Установка suricata и fail2ban  

```
sudo apt-get install suricata

sudo apt-get install fail2ban

```

**suricata**

После завершения установки Suricata нужно настроить интерфейсы, в `/etc/suricata/suricata.yaml`

Интерфейсы могут быть установлены в разделе **af-packets**

Настриваем сеть: 

в файле `/etc/suricata/suricata.yaml` изменим значение

```
HOME_NET: "[192.168.56.100/24]"

EXTERNAL_NET: "any"

```

Перезапустим suricata
```
sudo systemctl restart suricata
```

смотрим лог-файлы:
```
sudo tail -f /var/log/suricata/suricata.log
sudo tail -f /var/log/suricata/stats.log
```

запуск `sudo suricata -c /etc/suricata/suricata.yaml -i <interface>`

Осуществим с помошью Nmap SYN сканирование. 
Выполним его со второй машины Kali linux:

```
sudo nmap -sS 192.168.56.114 
```

Проверяем логи Suricata Fast.log, в них содержатся записи о быстрых алертах, которые были обнаружены системой обнаружения вторжений Suricata. 

```
sudo tail -f /var/log/suricata/fast.log
```


![suricata-fastlog.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/suricata-fastlog.JPG)


**fail2ban**

настроим fail2ban: `/etc/fail2ban/jail.d/default.conf`

```
[DEFAULT]
maxretry = 4
findtime = 480
bantime = 720
action = iptables
ignoreip = 127.0.0.1/8 192.168.56.1
```
maxretry — количество действий, которые разрешено совершить до бана.
findtime — время в секундах, в течение которого учитывается maxretry;
bantime — время, на которое будет блокироваться IP-адрес;
action — действия, которое будет выполняться, если Fail2ban обнаружит активность, соответствующую критериям поиска;
ignoreip — игнорировать защиту, если запросы приходят с перечисленных адресов.


создать новое правило: `/etc/fail2ban/jail.d/service.conf`

```
[ssh]
enabled = true
port = ssh
filter = sshd
action = iptables[name=sshd, port=ssh, protocol=tcp]
logpath = /var/log/auth.log
maxretry = 10
findtime = 600
```

Перезапустим Fail2Ban `sudo systemctl restart fail2ban`

список заблокированых адресов: `sudo fail2ban-client status`

получить статистику по списку  **ssh** : `sudo fail2ban-client status ssh `

```
Status for the jail: ssh
|- Filter
|  |- Currently failed: 0
|  |- Total failed:     0
|  `- File list:        /var/log/auth.log
`- Actions
   |- Currently banned: 0
   |- Total banned:     0
   `- Banned IP list:
```

посмотреть список  адресов можно командой `sudo fail2ban-client banned`

Удаление адреса из списка:` fail2ban-client set <имя правила> unbanip <IP-адрес> `

---

Было обнаружено , что запущена служба ssh , порт 22 , версия OpenSSH 7.9p1, Debian 10

![kali-scan.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/kali-scan.JPG)


было произведено полное сканирование всех портов

**sudo nmap -sA 192.168.56.102**

В сканировании ACK Nmap отправляет пакеты с установленным только флагом ACK (без флагов SYN, FIN или RST) на целевые порты. 

![scan-nmap-sA.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/scan-nmap-sA.JPG)

**sudo nmap -sT 192.168.56.102**

Это сканирование версий сервисов

![scan-nmap-sT.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/scan-nmap-sT.JPG)

**sudo nmap -sS 192.168.56.102**

Это сканирование TCP-портов с использованием сканирования SYN

![scan-nmap-sS.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/scan-nmap-sS.JPG)

**sudo nmap -sV 192.168.56.102**

Это сканирование версий сервисов

![scan-nmap-sV.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/scan-nmap-sV.JPG)




### Задание 2

Проведите атаку на подбор пароля для службы SSH:

**hydra -L users.txt -P pass.txt < ip-адрес > ssh**

1. Настройка **hydra**: 
 
 - создайте два файла: **users.txt** и **pass.txt**;
 - в каждой строчке первого файла должны быть имена пользователей, второго — пароли. В нашем случае это могут быть случайные строки, но ради эксперимента можете добавить имя и пароль существующего пользователя.

Дополнительная информация по **hydra**: https://kali.tools/?p=1847.

2. Включение защиты SSH для Fail2Ban:

-  открыть файл /etc/fail2ban/jail.conf,
-  найти секцию **ssh**,
-  установить **enabled**  в **true**.

Дополнительная информация по **Fail2Ban**:https://putty.org.ru/articles/fail2ban-ssh.html.



*В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.*


------

**Выполнение задания 2.**


Проверяем как работает программа **hydra**. Порт доступен для подключения, пароли подобраны верно.

![kali-hydra-test.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/kali-hydra-test.JPG)

Теперь включим программу Fail2Ban, в настройках  установим **enabled**  в **true**.

Перезапустим Fail2Ban `sudo systemctl restart fail2ban`

проверяем: 

1) со стороны kali-linux атака не удалась 

![kali-hydra-status.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/kali-hydra-status.JPG)

2) со стороны атакуемой машины: file2ban обнаружил и заблокировал ip c которого поступали запросы на порт ssh 

![status-file2ban.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/status-file2ban.JPG)


3) в логах Suricata видна подозрительная активность, сканирование 22 порта

![log-surikata.JPG.JPG](https://github.com/elekpow/netology/blob/main/inform/lesson3/images/log-surikata.JPG.JPG)



