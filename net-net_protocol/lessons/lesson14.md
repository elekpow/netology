### Cisco

* Заходим в привилегированный режим
`enable или en`
* Заходим в режим конфигурирования 
`configure terminal` или `conf t`
------------------------------------------
* Нам нужно включить 3 интерфейса (FastEthernet 0/1-0/3), поэтому начнем с 0/1 
`int f` и нажимаем **tab**, затем дописываем 0/1 , enter
активируем его командой `no sh` и нажимаем **tab**, потом enter. 

Теперь этот порт открыт (активен);

* Выходим из настроек интерфейса командой `exit` и enter;

--------------------

* Создадим VLAN 10 на коммутаторах:

`vlan 10` (создался VLAN)
`Interface FastEthernet 0/1` **(для ПК1)**, 
`switchport mode access`
`switchport access vlan 10`

---------------------
* диапазон интерфесов `int range fa 0/1-3`
--------------------------
* trunk: 

`interface gigabitEthernet 0/1`

`switchport mode trunk`

---------------------------
* получить текущую конфигурацию любого устройства

`show running-config`

----------------------------------

`configure terminal`
`enable secret superpass` **привилегированный режим **
`line console 0`
`password cisco`
`login`
`exit`
`line vty 0 15`
`password cisco`
`login`
`end`
`wr`

---------------

`interface vlan 20`
`ip address 192.168.20.5 255.255.255.248`
`no shutdown`

--------------------
`int g 0/1` **// Выбор интерфейса**
`switchport mode access` **// Сообщаем системе, что это абонентский порт**
`switchport port-security` **// Активируем функцию switchport port-security на интерфейсе fa 0/1**
`switchport port-security maximum 3` **// Устанавливаем количество активных MAC-адресов на порт устройства**

-----------

`storm-control broadcast level 30.00`

---

### Cisco router

* Заходим в привилегированный режим
`enable` или `en`
* Заходим в режим конфигурирования 
`configure terminal` или `conf t`
------------------------------------------
* Выберите интерфейс `gigabitEthernet0/0/0` и очистите его
`interface gigabitEthernet0/0`
`no shut`
`no ip address`
---------------
**Настройка интерфейса для сети управления оборудованием**
`interface gigabitEthernet0/0/0`
`ip address 192.168.1.1 255.255.255.0`
----------------------------
**Настройка сабинтерфейса**
`interface gigabitEthernet0/0/0.10`
`encapsulation dot1q 10`
`ip address 192.168.10.1 255.255.255.0`
`description dlyaVlan10`
--------------------------
* сохранить конфигурацию всех устройств командой `write` или `copy run start`.

----------------
**Подключение по telnet или ssh называется виртуальным терминалом (vt)**

`line vty 0 4`	- Configure a terminal line
`password cisco`
`service password-encryption`

`login`           -  Enable secure login checking

**пароль для enable-режима:8**
`enable secret superpass`


------------------------------------
## интернет
------------------------

**2 интерфейса**
**1 -в локальную сеть** `interface gigabitEthernet0/0/1`
**2- в сеть провайдера** `interface gigabitEthernet0/0/0`

`conf terminal`
`interface gigabitEthernet0/0/0`
`ip address 188.144.1.2 255.255.255.252`
`no shutdown`
`exit`
`ip route 0.0.0.0 0.0.0.0 188.144.1.1`
`end`
`write`

ping   188.144.1.1

----------------------
### nat
----------------------

`interface gigabitEthernet0/0/0`
`ip nat outside`
`exit`
`interface gigabitEthernet0/0/1.10` **#для саб интерфейса (10 20 30)**
`ip nat inside`
`end`

`conf terminal`
`ip access-list standard FOR-NAT`
`permit 192.168.10.0 0.0.0.7`
`permit 192.168.20.0 0.0.0.7`
`permit 192.168.30.0 0.0.0.7`
`end`
----------
`show access-lists`
`show run`
----------
`conf terminal`
`ip nat inside source list FOR-NAT interface gigabitEthernet 0/0/0 overload `
`end`
`write`
-------------
`show ip nat translations`
----------------------------------------------

### статичная нат трансляция

`conf terminal`
`ip nat inside source static tcp 192.168.30.5 80 188.144.1.2 80`
`end`
`write`

-------------------------------------------
### динамическая маршрутизация , 2 сети 

```
show ip route
router rip 
version 2
network 188.144.0.0 #все сети
network 192.168.0.0 #все сети
no auto-summary 
do write
```
----------------------------------
### vpn (Filial)
----------------------------------

```
conf terminal

crypto isakmp policy 1
encryption 3des
hash md5
authentication pre-share 
group 2
lifetime 86400
exit
```
---
`crypto isakmp key cisco address 188.144.0.2` **#публичный адрес другой сети**
---
```
ip access-list extended VPN
permit ip 192.168.5.0 0.0.0.15 192.168.0.0 0.0.0.15 # внутренняя сеть 
exit
```
---
`crypto ipsec transform-set TS esp-3des esp-md5-hmac`
---

```
crypto map CMAP 10 ipsec-isakmp
set peer 188.144.0.2
set transform-set TS
match address VPN
exit
interface gigabitEthernet 0/0/0
crypto map CMAP
exit
```

**/////////////**

```
ip nat inside source list 100 interface gigabitEthernet 0/0/0 overload
access-list 100 deny ip 192.168.5.0 0.0.0.15 192.168.0.0 0.0.0.15
access-list 100 permit ip 192.168.5.0 0.0.0.15 any
```

`do show crypto map`


---

```
crypto isakmp policy 1
encryption 3des
authentication pre-share 
group 2
lifetime 86400
exit
```
---

`crypto isakmp key cisco address 87.250.0.2`
---

```
ip access-list extended VPN
permit ip 192.168.0.0 0.0.0.7 192.168.5.0 0.0.0.7
exit
crypto ipsec transform-set TS esp-3des esp-md5-hmac

crypto map CMAP 10 ipsec-isakmp
set peer 87.250.0.2
set transform-set TS
match address VPN

interface gigabitEthernet 0/0/0
crypto map CMAP
```


**/////////////**

```
ip nat inside source list 100 interface gigabitEthernet 0/0/0 overload
access-list 100 deny ip 192.168.5.0 0.0.0.7 192.168.0.0 0.0.0.7
access-list 100 permit ip 192.168.5.0 0.0.0.7 any
```

