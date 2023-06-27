# Домашнее задание к занятию «Типы виртуализации: KVM, QEMU»

---

### Задание 1

**Ответьте на вопрос в свободной форме.**

Какие виртуализации существуют? Приведите примеры продуктов разных типов виртуализации.
---

**Выполнение  задания 1**

* Технология виртуализации  позволяет  разделить ресурсы сервера между физический сервер на несколько виртуальных и обеспечить изоляцию вычислительных процессов друг от друга, при этом каждый из них может иметь различный набор программного обеспечения.

* Существуют множество видов виртуализации: 

- **Аппаратная виртуализация** - эта модель использует менеджер виртуальных машин (гипервизор), в  качестве примера могут быть: Oracle VirtualBox, Microsoft Hyper-V, VMware ESXi. В своей работе виртуальная машина полностью эмулирует аппаратное обеспечение, что позволяет запускать на ней различные операционные системы.

- **Паравиртуализация**. В этом случае виртуальная машина использует общее ядро операционной системы хоста, что повышает производительность. Примеры продуктов: Xen, KVM.

- **Контейнеризация (контейнерная виртуализация)** (Docker, LXC)  Это виртуализация на уровне операционной системы. Изолированные контейнеры, используют общую операционную систему хоста.

- **Виртуализация ресурсов** - это процесс создания виртуальных экземпляров ресурсов, таких как вычислительная мощность, память, хранилище данных и сетевые ресурсы. Эти виртуальные экземпляры могут быть использованы для создания виртуальных машин, контейнеров или других форм виртуализации.

- **Виртуализация хранилища** - объединение физических дисков в единое хранилище и предоставление доступа к нему виртуальным машинам. Примеры продуктов: VMware vSAN, Microsoft Storage Spaces Direct.

- **Виртуализация приложений** (VMware ThinApp,Citrix XenApp),  такой тип виртуализации изолирует приложения от операционной системы и других приложений на хосте. 

- **Виртуализация сети** - создание виртуальных сетей, которые могут быть использованы для тестирования или для развертывания приложений в облаке. Примеры продуктов: Cisco ACI, VMware NSX.





---

### Задание 2 

Выполните действия и приложите скриншоты по каждому этапу:

1. Установите QEMU в зависимости от системы (в лекции рассматривались примеры).
2. Создайте виртуальную машину.
3. Установите виртуальную машину.
Можете использовать пример [по ссылке](https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/x86/alpine-standard-3.13.5-x86.iso).

Пример взят [с сайта](https://alpinelinux.org). 

---

**Выполнение  задания 2**

* Устанавливаю QEMU с помощью MSYS2 (среда для создания, установки и запуска программного обеспечения в Windows). MSYS2 использует **pacman** для управления пакетами 

`pacman -S mingw-w64-ucrt-x86_64-qemu`

![img9.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img9.jpg)


* Запускаем в QEMU сохраненный образ Alpine Linux 

`qemu-system-x86_64.exe -L . -m 256 -boot d -cdrom ./alpine-standard-3.13.5-x86.iso`

![img10.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img10.jpg)

![img11.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img11.jpg)

---

### Задание 3 

Выполните действия и приложите скриншоты по каждому этапу:

1. Установите KVM и библиотеку libvirt. Можете использовать GUI-версию из лекции. 
2. Создайте виртуальную машину. 
3. Установите виртуальную машину. 
Можете использовать пример [по ссылке](https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/x86/alpine-standard-3.13.5-x86.iso). 

Пример взят [с сайта](https://alpinelinux.org). 

---

**Выполнение  задания 3**


* Установка KVM в виртуальной машине VirtualBox

![img12.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img12.jpg)


**libvirtd.service** запущен


![img13.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img13.jpg)


* однако INFO: Your CPU does not support KVM extensions


![img14.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img14.jpg)


* пробуем запустить, через GUI 

образ `alpine-standard-3.13.5-x86.iso`

![img15.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img15.jpg)

**Виртуальная машина запущена успешно**




---

### Задание 4

Выполните действия и приложите скриншоты по каждому этапу:

1. Создайте проект в GNS3, предварительно установив [GNS3](https://github.com/GNS3/gns3-gui/releases).
2. Создайте топологию, как на скрине ниже.
3. Для реализации используйте машину на базе QEMU. Можно дублировать, сделанную ранее. 

![image](https://user-images.githubusercontent.com/73060384/118615008-f95e9680-b7c8-11eb-9610-fc1e73d8bd70.png)


---

**Выполнение  задания 4**


Устанавливаю GNS3 под систему Windows

![img16.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img16.jpg)

![img17.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img17.jpg)

Пинг до первой машины проходит

![img18.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img18.jpg)


