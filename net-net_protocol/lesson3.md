 # Домашнее задание к занятию "L3-сеть"


### Цели задания:
- научиться правильно рассчитывать маску для выделенных подсетей,
- освоить конфигурацию сетевых интерфейсов устройств, работающих на третьем уровне модели OSI,
- научиться создавать IP-связность между устройствами.

Практика закрепляет знания о работе устройств на сетевом уровне модели OSI. Полученные навыки пригодятся для понимания принципов построения сети и создания связности сетевых устройств между собой.

### Чеклист готовности к домашнему заданию:
1. вы прочитали статью [«Основы работы с Cisco Packet Tracer»;](https://pc.ru/articles/osnovy-raboty-s-cisco-packet-tracer)
2. на вашем компьютере установлена программа Cisco Packet Tracer;
3. вы выполнили домашнее задание [«L2-сеть».](https://github.com/netology-code/snet-homeworks/blob/snet-18/4-02.md)

### Инструкция по выполнению: 
- Выполните оба задания.
- Сделайте скриншоты из Cisco Packet Tracer по итогам выполнения каждого задания.
- Отправьте на проверку в личном кабинете Нетологии два PKT-файла. Файлы прикрепите в раздел «Решение» в практическом задании.
- В комментариях к решению в личном кабинете напишите пояснения к полученным результатам. 

---

## Задание 1. Сборка локальной сети
*Важно. Задание сквозное и составлено на основе практического задания из домашней работы [«L2-сеть».](https://github.com/netology-code/snet-homeworks/blob/snet-18/4-02.md)* 

### Описание задания
Перед вами стоит задача собрать часть локальной сети главного офиса. 

В вашем распоряжении две сети:
- 192.168.0.0 — предназначена для устройств главного офиса;
- 10.0.0.0 — предназначена для сетевого оборудования главного офиса.

Необходимо из каждой выделить минимальную подсеть для 4 сетевых устройств и 10 пользовательских устройств.

### Требования к результату:
- Отправьте PKT-файл с выполненным заданием.
- Добавьте скриншоты с доступностью устройств между собой и ответ на вопрос.

### Процесс выполнения:
1. Запустите программу Cisco Packet Tracer.
2. В программе загрузите предыдущую практическую работу.
3. Добавьте два маршрутизатора, соедините и создайте между ними сетевую связность.
4. К одному из маршрутизаторов подключите гигабитным интерфейсом ещё один коммутатор, за которым подключены два ПК, два ноутбука и два принтера. Это будет сеть главного офиса.
5. Выделите минимальную подсеть для 10 пользовательских устройств.
6. Настройте сетевые интерфейсы всех оконечных устройств так, чтобы была доступность всех со всеми.
7. Проверьте доступность каждого типа устройств с маршрутизатора, к которому они подключены, командой ping.
8. Какую минимальную маску необходимо выделить для устройств и почему? Ответ внесите в комментарии к решению задания в личном кабинете.

### Топология после выполнения задания должна выглядеть так:
[![](https://i.postimg.cc/T2s1mSHC/nELDf2C9.jpg)](https://postimg.cc/LhzmFyS1)

---

**Выполнение задания: Задание 1.**

* L3-1) Минимальная маска: `255.255.255.240 (28)` , на 14 адресов, у нас всего 7 (2 компьютера, 2 ноутбука, 2 принтера и порт роутера)

Файл Packet tracer [l3-1.pkt](https://github.com/elekpow/netology/blob/main/net-net_protocol/packet_tracer/l3-1.pkt)

![L3-1.jpeg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/L3-1.jpeg)





---

## Задание 2. Подключение локальной сети 
*Важно. Задание сквозное и составлено на основе практического задания из домашней работы [«L2-сеть».](https://github.com/netology-code/snet-homeworks/blob/snet-18/4-02.md)*

### Описание задания
Перед вами стоит задача подключить получившуюся небольшую локальную сеть к главной сети офиса. 

### Требования к результату:
- Отправьте PKT-файл с выполненным заданием.
- Добавьте скриншоты с доступностью устройств между собой и ответы на вопросы.

### Процесс выполнения:
1. Запустите программу Cisco Packet Tracer.
2. В программе загрузите предыдущую практическую работу.
3. Маршрутизатор без устройств соедините с любым коммутатором из предыдущей практической задачи домашней работы 4.2 «L2-сеть». 
4. Создайте сабинтерфейсы для каждой VLAN: 10, 20, 30.
5. Назначьте IP-адреса каждому сабинтерфейсу.
6. Напишите в комментариях, какую минимальную маску необходимо указать для сабинтерфейса, обоснуйте своё решение.
7. Проверьте связь маршрутизатора с конечными устройствами в каждой VLAN командой ping.
8. Есть ли доступность между компьютерами за разными сетями маршрутизаторов? Ответ внесите в комментарии к решению задания в личном кабинете.

### Топология после выполнения задания должна иметь следующий вид:
[![](https://i.postimg.cc/pLD0NLVm/U3jjCbKB.jpg)](https://postimg.cc/Jsz3Zmk8)
---

**Выполнение задания: Задание 2.**


* L3-2)на роутере настроен сабинтерфейс для VLAN 10, минимальная маска для сетей будет `255.255.255.248 (29)`, этого достаточно для 6 адресов
Компьютеры за разными маршрутизаторами недоступны.

Файл Packet tracer [l3-2.pkt](https://github.com/elekpow/netology/blob/main/net-net_protocol/packet_tracer/l3-2.pkt)

![L3-2.jpeg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/L3-2.jpeg)



---

## Задание 3. Создание связности между сетями 

*ВАЖНО. Задание является сквозным и составлено на основе практической задачи из домашних работ ["L2-сеть"](https://github.com/netology-code/snet-homeworks/blob/snet-18/4-02.md) и [“L3-сеть”](https://github.com/netology-code/snet-homeworks/edit/snet-18/4-03.md).* 

### Описание задания
Перед вами стоит задача создать доступность устройств небольшой локальной сети к главной сети офиса. 

### Требование к результату
- Отправьте файл .pkt с выполненным заданием.
- К выполненной задаче добавьте скриншоты с доступностью устройств между собой.

### Процесс выполнения
1. Запустите программу Cisco Packet Tracer.
2. В программе Cisco Packet Tracer загрузите предыдущую практическую работу из домашних заданий [4.2 "L2-сеть".](https://github.com/netology-code/snet-homeworks/blob/snet-18/4-02.md) и [4.3 “L3-сеть”](https://github.com/netology-code/snet-homeworks/edit/snet-18/4-03.md).
3. На маршрутизаторах добавьте статические записи маршрутизации о доступности других сетей.
4. Проверьте связь с конечного устройств за одним маршрутизатором до конечного устройства за другим маршрутизатором.
5. Какой вид анонса внутренней сети вы выбрали и почему? Ответ внесите в комментарии к решению задания в личном кабинете Нетологии

---

**Выполнение задания: Задание 3.**


Файл Packet tracer [l3-3.pkt](https://github.com/elekpow/netology/blob/main/net-net_protocol/packet_tracer/l3-3.pkt)


* L3-3) Добавлены статические маршруты. Компьютеры за разными маршрутизаторами теперь доступны. Применена статическая маршрутизация сетей.
