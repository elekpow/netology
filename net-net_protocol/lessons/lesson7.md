 # Домашнее задание к занятию "Сеть и сетевые протоколы: VPN"
 
---

## Задание. Создание дополнительного офиса и настройка ISAKMP-туннеля для согласования параметров протокола.

### Описание задания
Руководство решило открыть новый филиал в соседней области. Перед вами стоит задача  между главным офисом и филиалом создать VPN-туннель. Новый филиал подключен к тому же интернет-провайдеру. Но имеет другие “белые” ip-адреса для подключения: 87.250.0.0/30

### Требование к результату
- Вы должны отправить файл .pkt с выполненным заданием
- К выполненной задаче добавьте скриншоты с доступностью “внешней сети” и ответы на вопросы.

### Процесс выполнения
1. Запустите программу Cisco Packet Tracer
2. В программе Cisco Packet Tracer загрузите предыдущую практическую работу.
3. На маршрутизаторе интернет-провайдера добавьте в модуль физически порты GLC-TE, предварительно его выключив.
4. Создайте сеть нового филиала, состоящую из 3 ПК, 1 коммутатора и 1 маршрутизатора.
5. Создайте сетевую связность между маршрутизатором филиала и маршрутизатором интернет-провайдера, согласно условиям.
6. На маршрутизаторе филиала создайте NAT-трансляцию с помощью access-листов для внутренней сети. Адресацию внутри сети филиала можно использовать любую.
7. На маршрутизаторе главного офиса настройте политики ISAKMP: 

*R1(config)#  crypto isakmp policy 1*

*R1(config-isakmp)# encr 3des - метод шифрования*

*R1(config-isakmp)# hash md5 - алгоритм хеширования*

*R1(config-isakmp)# authentication pre-share - использование предварительного общего ключа (PSK) в качестве метода проверки подлинности*

*R1(config-isakmp)# group 2 - группа Диффи-Хеллмана, которая будет использоваться*

*R1(config-isakmp)# lifetime 86400 - время жизни ключа сеанса*

8. Укажите Pre-Shared ключ для аутентификации с маршрутизатором филиала. Проверьте доступность с любого конечного устройства доступность роутера интернет-провайдера, командой ping.
9. Создайте набор преобразования (Transform Set), используемого для защиты наших данных.

*crypto ipsec transform-set <название> esp-3des esp-md5-hmac*

10. Создайте крипто-карту с указанием внешнего ip-адреса интерфейса и привяжите его к интерфейсу.

*R1(config)# crypto map <название> 10 ipsec-isakmp*

*R1(config-crypto-map)# set peer <ip-address>*

*R1(config-crypto-map)# set transform-set <название>*

*R1(config-crypto-map)# match address <название access-листа>*

*R1(config- if)# crypto map <название крипто-карты>*

10. Проделайте вышеуказанные операции на маршрутизаторе филиала в соответствии ip-адресов и access-листов и отключите NAT-трансляцию сетевых адресов.
11. Проверьте сетевую доступность между роутерами командой ping.
12. Проверьте установившееся VPN-соединение на каждом роутере командой: “show crypto session”. Статус должен быть UP-ACTIVE. Сделайте скриншот.
13. Ответ внесите в комментарии к решению задания в личном кабинете Нетологии

### Топология после выполнения задания должна выглядеть следующим образом:
[![](https://i.postimg.cc/SRYBKKtR/oYEo8eD2.jpg)](https://postimg.cc/T5G77Txv)


--- 

**Выполнение задания**

Настроено соединение между Главным офисом Router(HeadOffice) и Филиалом Router(Filial)


Файл Packet tracer [VPN-1.pkt](https://github.com/elekpow/netology/blob/main/net-net_protocol/packet_tracer/VPN-1.pkt)

![VPN-1.jpeg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/VPN-1.jpeg)


![VPN-2.jpeg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/VPN-2.jpeg)


* на скриншотах "VPN-Filial_cryptomap.JPG" и "VPN-HadOffice_cryptomap.JPG" вывод команды `show crypto map`

![VPN-Filial_cryptomap.jpeg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/VPN-Filial_cryptomap.jpeg)


![VPN-HadOffice_cryptomap.jpeg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/VPN-HadOffice_cryptomap.jpeg)




