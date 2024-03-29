 # Домашнее задание к занятию "4.13. IPv6"

---

### Задание 1. 

Какая нотация используется для записи IPv6-адресов:

 - какие и сколько символов?
 - какие разделители?

* Приведите ответ в свободной форме.
--- 

**Выполнение задания: Задание 1.**

* Для записи ip-адресов в **IPv6**  используются адреса длиной **128 бит**, в **16-ричном формате**. Состоящие из **8 групп по 4 разряда**. Для разделения используется `:` двоеточие. Протокол обладает значительно большим адресным пространством и должен прийти на замену **IPv4**.


---

### Задание 2. 

Какой адрес используется в IPv6 как `loopback`?

* Приведите ответ в свободной форме.
--- 

**Выполнение задания: Задание 2.**

* Адрес **loopback** представляет собой в большей части набор нулей `0000:0000:0000:0000:0000:0000:0000:0001`

* в сокращенном виде он заменяется на `0:0:0:0:0:0:0:1` , что можно записать как  `::1/128` либо записать как `::1 `

* **loopback-адрес** используется узлом для отправки пакета самому себе и не может быть назначен физическому интерфейсу, все пакеты, идущие на него не выходят за пределы устройства, он аналогичен `127.0.0.1` в **IPv4**.


---

### Задание 3. 

Что такое `Unicast`, `Multicast`, `Anycast` адреса?

* Приведите ответ в свободной форме.
--- 

**Выполнение задания: Задание 3.**

В IPv6-адреса можно классифицировать по способу адресации:

**Unicast** - предназначены для идентификации интерфейса узла на устройстве под управлением протокола **IPv6**,  и идентифицируют только один сетевой интерфейс.

**Multicast** - используется группой узлов, в сети каждый отправленный  пакет  будет доставлен каждому узлу в группе.

**Anycast** - адреса назначаются группе интерфейсов, пакет, отправленный на такой адрес, доставляется на один из интерфейсов данной группы, и направляется к ближайшему устройству с этим адресом


---

### Задание 4. 

Используя любую консольную утилиту в Linux, получите IPv6-адрес для какого либо ресурса.

* В качестве ответа приложите скриншот выполнения команды.
--- 

**Выполнение задания: Задание 4.**

![img8.jpg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/img8.jpg)


---

### Задание 5. 

 - Как выглядят IPv6-адреса, которые маршрутизируются в интернете?
 - Как выглядят локальные IPv6 адреса?

* Приведите ответ в свободной форме.
--- 

**Выполнение задания: Задание 5.**

* **Global unicast**, это публичные адреса, являющиеся аналогом публичных адресов в протоколе **IPv4**.  Глобальные адреса, как уже принято начинаются только с 2 или 3, сделано так для того, чтобы избежать неэффективного распределения адресов **IPv6**.

```
Для сайта mail.ru он будет выгдядеть так:

Addresses:  2a00:1148:db00:0:b0b0::1

Для сайта google.com:

Addresses: 2a00:1450:4010:c08::71
```

* **Link-Local**  - адреса сети, которые предназначены только для коммуникаций в пределах одного сегмента местной сети или магистральной линии. 

Для **IPv6** в качестве **link-local** адресов выделена подсеть `FE80::/10` , адрес подсети составляет 64 бита, и 64 бита выделено на адрес интерфейса.

Локальный адрес выглядит так: `fe80::8d9e:b49a:b60c:6573/64`
 

