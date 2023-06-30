# Домашнее задание к занятию "Обзор систем IT-мониторинга" - Левин Игорь

---

### Задание 1

Создайте виртуальную машину в Yandex Compute Cloud и с помощью Yandex Monitoring создайте дашборд, на котором будет видно загрузку процессора.


**Требования к результату **
прикрепите в файл README.md скриншот вашего дашборда в Yandex Monitoring с мониторингом загрузки процессора виртуальной машины


### Выполнение задания   
                
 Виртуальная машина: платформа Intel Ice Lake
 1) HDD = 3ГБ 
 2) RAM = 1ГБ 
 3) vCPU = 2 , гарантированная доля vCPU = 20% ,"Прерываемая"
 4) операционная система: Debian 11
 
 - Сервисный аккаунт  с ролью monitoring.editor
 

 Виртуальная машина

![screen1](https://github.com/elekpow/hw-01/blob/main/vm.JPG)

 Дашборд

![screen1](https://github.com/elekpow/hw-01/blob/main/monitoring.JPG)

---

## Дополнительные задания (со звездочкой*)


С помощью Yandex Monitoring сделайте 2 алерта на загрузку процессора: WARN и ALARM. Создайте уведомление по e-mail.

Требования к результату
прикрепите в файл README.md скриншот уведомления в Yandex Monitoring


 ### Выполнение задания 
 
 
  при минималальной нагрузке  (ping ya.ru)

![screen1](https://github.com/elekpow/hw-01/blob/main/warning.JPG) 
                                                                       

при большой нагрузке ( запуск установки -  apt install docker.io)  

![screen1](https://github.com/elekpow/hw-01/blob/main/warning1.JPG)

Полученное уведомление 1

![screen1](https://github.com/elekpow/hw-01/blob/main/warn.JPG)

Полученное уведомление 2

![screen1](https://github.com/elekpow/hw-01/blob/main/Alarm.JPG)


