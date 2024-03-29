# Домашнее задание к занятию "Ядро операционной системы"

---

### Задание 1

При каких событиях выполнение процесса переходит в режим ядра?

* Приведите ответ в свободной форме.

---

**Выполнение задания 1.**

* Ядро в операционной системе Linux представляет собой по своей сути тип программного обеспечения, состоящее из файловой системы, подсистемы управления процессами и памятью, подсистемой ввода - вывода. Многие приложения выполняя различные операции запускаются в пользовательском режиме используя при этом ресурсы операционной системы, но поскольку они ограничены некоторые операции должны выполняться с правами ядра чтобы  получать ресурсы предоставляемые самим ядром, включая ресурсы процессора, ресурсы хранения и ресурсы ввода-вывода.  В режиме ядра имеется доступ ко всем аппаратным ресурсам компьютера. Процессы, работающие в режиме ядра, могут выполнять любые операции (включают доступ к устройствам) и не имеют ограничений на использование ресурсов.

* Выполнение процесса в режиме ядра произойдет в случае системного вызова (обращение программы к ядру операционной системы), он вызывает переключение контекста из пользовательского пространства в пространство ядра. Также переключение контекста происходит и при аппаратном прерывании. Аппаратные прерывания возникают при определенных событиях, они генерируются внешних периферийных устройств, при каком либо событий, например когда периферийное устройство завершает запрошенную пользователем операцию, оно выдаст сигнал прерывания, или о возникшей на устройстве ошибке.  Аппаратные устройства могут запрашивать прерывание, например, таймер / часы могут вызвать прерывание по истечении определенного времени. 


---

### Задание 2

Найдите имя автора модуля `libcrc32c`.

* В качестве ответа приложите скриншот вывода команды.

---

**Выполнение задания 2.**

![img20.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img20.jpg)



`**author:         Clay Haapala <chaapala@cisco.com>**`

---
### Задание 3

Используя утилиту `strace` выясните какой системный вызов использует команда `cd`.

*Примечание:* она не является внешним файлом, но для наших целей можно схитрить: `strace bash -c 'cd /tmp'`.

* В качестве ответа напишите название системного вызова.

---

**Выполнение задания 3.**

`chdir(“/tmp”)` 
Функция **chdir()** изменяет текущий рабочий каталог вызвавшего процесса на каталог `/`

![img21.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img21.jpg)


---

### Задание 4*

**Соберите свой модуль и загрузите его в ядро.**

*Примечание:* лучше использовать чистую виртуальную машину, чтобы нивелировать шанс сломать систему.

**1) Установим необходимые пакеты:**

`apt-get install gcc make linux-headers-$(uname -r)`

**2) Создаем файл модуля:**

```
mkdir kmod-hello_world
cd kmod-hello_world/
touch ./mhello.c
```

```
#define MODULE
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>

MODULE_LICENSE("GPLv3");

int init_module(void){
    printk("<1> Hello,World\n");
    return 0;
}

void cleanup_module(void){
    printk("<1> Goodbye.\n");
}
```

**3) Создаем Makefile:**
`touch ./Makefile`

```
obj-m += mhello.o

hello-objs := mhello.c

all:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
```
_Обратите внимание, что отступы перед `make` - это табуляция, а не пробелы. Для синтаксиса Makefile это важно._

**4) Собираем модуль и устанавливаем его с помощью insmod.**
```
make all
insmod path/to/module.ko
```

* В качестве ответа приложите скриншот вывода установки модуля в `dmesg`.

---

**Выполнение задания 4.**


![img22.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img22.jpg)


