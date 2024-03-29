# Домашнее задание к занятию «Ansible. Часть 1»

---

### Задание 1

**Ответьте на вопрос в свободной форме.**

Какие преимущества даёт подход IAC?

---

**Выполнене задания 1**

* **infrastructure as Code, или сокращенно IaC**. Применение такого подхода позволяет быстро конфигурировать инфраструктуру. Для разработчиков IaC обеспечивает соблюдение корректности при  настройке, установка инфраструктуры полностью стандартизирована , что снижает вероятность появления ошибок. IaC позволяет документировать , и отслеживать каждое изменение конфигурации сервера. Благодаря такому подходу IaC обеспечивает масштабируемость и стандартизацию инфраструктуры, кроме того имеется возможность повторного развертывания и в случае сбоев, быстро восстановить рабочее состояние.


---


### Задание 2 

**Выполните действия и приложите скриншоты действий.**

1. Установите Ansible.
2. Настройте управляемые виртуальные машины, не меньше двух.
3. Создайте файл inventory. Предлагается использовать файл, размещённый в папке с проектом, а не файл inventory по умолчанию.
4. Проверьте доступность хостов с помощью модуля ping.
 
---

**Выполнене задания 2**

* Запущены  две виртуальные машины Debian 11, CentOS 8.


![img1.jpg](https://github.com/elekpow/netology/blob/main/automation/images/img1.jpg)


![img2.jpg](https://github.com/elekpow/netology/blob/main/automation/images/img2.jpg)



---

### Задание 3 

**Ответьте на вопрос в свободной форме.**

Какая разница между параметрами forks и serial? 

---

**Выполнене задания 3**

* **Forks** определяет максимальное количество одновременных подключений, которые Ansible выполнял для каждой задачи за один запуск. Ansible выполняет каждую задачу не на всех узлах сразу, а партиями. Размер партий настраивается через параметр forks

* **Serial** определяет максимальное количество узлов, обрабатывая каждую задачу за один запуск. Если общее количество узлов превышает серийное значение, то playbook запускается снова для оставшихся узлов.

---

### Задание 4 

В этом задании вы будете работать с Ad-hoc коммандами.

**Выполните действия и приложите скриншоты запуска команд.**

1. Установите на управляемых хостах любой пакет, которого нет.
2. Проверьте статус любого, присутствующего на управляемой машине, сервиса. 
3. Создайте файл с содержимым «I like Linux» по пути /tmp/netology.txt.

---

**Выполнене задания 4**

* **1)** запущены  две виртуальные машины Debian 11, CentOS 8.

* Устанавливаем midnight commander 

```
inventory.ini
[hosts-deb]
192.168.0.102
[hosts-cent]
192.168.0.103
```

![img3.jpg](https://github.com/elekpow/netology/blob/main/automation/images/img3.jpg)

![img4.jpg](https://github.com/elekpow/netology/blob/main/automation/images/img4.jpg)



* 2) проверяем статус сервиса sshd

`ansible -i inventory.ini all -m shell -a "service sshd  status" -b`


![img5.jpg](https://github.com/elekpow/netology/blob/main/automation/images/img5.jpg)

* 3) записываем в файл /tmp/netology.txt текст и сразу же читаем файл

`ansible -i inventory.ini all -m shell -a "echo I Like Linux> /tmp/netology.txt  | cat /tmp/netology.txt" -b`


![img6.jpg](https://github.com/elekpow/netology/blob/main/automation/images/img6.jpg)


---
 
