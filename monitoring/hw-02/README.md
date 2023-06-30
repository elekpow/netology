# Домашнее задание к занятию "Система мониторинга Zabbix" - Левин Игорь

---

### Задание 1

Установите Zabbix Server с веб-интерфейсом.

Процесс выполнения
  1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
  2. Установите PostgreSQL. Для установки достаточна та версия что есть в системном репозитороии Debian 11
  3. Пользуясь конфигуратором комманд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache
  4. Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server

***Требования к результаты***

Прикрепите в файл README.md скриншот авторизации в админке
Приложите в файл README.md текст использованных команд в GitHub


---

### Выполнение задания 
  
Виртуальные машины устновлены в Yandex Cloud  
  
 ----------------------------------------
 
 Установка успешна 
  
 ![screen1](https://github.com/elekpow/hw-02/blob/main/zabbix.JPG)  
 
 Авторизации в админке
 
 
 ![screen1](https://github.com/elekpow/hw-02/blob/main/zabbix_login.JPG)  
  
 
 
 git add .     
 git commit -m "Readme.md"    
 git push   
 
 git status
 
 git add .     
 git commit -m "Update Readme"    
 git push  
 
   
  
  
---

### Задание 2

Установите Zabbix Agent на два хоста.

***Процесс выполнения***

 1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
 2. Установите Zabbix Agent на 2 виртмашины, одной из них может быть ваш Zabbix Server
 3. Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов
 4. Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera
 5. Проверьте что в разделе Latest Data начали появляться данные с добавленных агентов


---

### Выполнение задания 
  
  
   Установлен агент на двух виртуальных машинах (host и  Elvm2)
  
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent.JPG) 
 
  Подключение успешно 
 
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_configiration.JPG)
 
 данные принимаются, пример  виртуальная машина Elvm2
 
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_LatestData_Elvm2.JPG)
  
   
  
  
---

### Задание 3 со звёздочкой*

Установите Zabbix Agent на Windows (компьютер) и подключите его к серверу Zabbix.

***Требования к результаты***

Приложите в файл README.md скриншот раздела Latest Data, где видно свободное место на диске C:

---

### Выполнение задания   


1) Zabbix сервер устновлен на виртуальной машине. Агент для ОС Windows установлен на локальном компьютере, в брандмауре открыт порт 10050 и а также разрешение для приложения Zabbix Agent

 ![screen1](https://github.com/elekpow/hw-02/blob/main/FW_Windows.JPG)

2) для того что бы получить  доступ из вне необходим "белый ip" или же просто в роутере настроить DDNS
через сервис провайдера, например no-ip.com  , кроме того , "для теста" в роутере временно  открыт полный доступ по порту 10050

3) имеем доступ к компьютеру по доменному имени  проверяем, telnet int93302.hopto.org 10050
порт открыт.  

 ![screen1](https://github.com/elekpow/hw-02/blob/main/telnet.JPG)


Данные отправляются

 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_windows.JPG)
 
мониторинг показывает проблему  
 
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_windows_monitor.JPG)
  
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_windows_problem.JPG)

на локальном компьютере с Windows на диске C: занято более 90% места.





