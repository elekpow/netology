# Домашнее задание к занятию "Память, управление памятью "

---

### Задание 1

Что происходит с оперативной памятью во время перехода ПК в:
1) сон (suspend)
2) гибернацию (hibernate)

*Приведите ответ для каждого случая в свободной форме.*

---

**Выполнение задания 1.**

При переходе в спящий режим, оперативная память продолжает работать. Снижается энергопотребление, но питание остается достаточным чтобы сохранить рабочее состояние, кэшированные данные приложений полностью сохраняются. При включении компьютера, переход в рабочее состояние произойдет очень быстро.


В режиме гибернации содержимое оперативной памяти сохраняется на диск, в постоянную память, так на Windows для такого существует файл Hiberfil.sys, в который записывается вся информация. При включении компьютера информация восстанавливается. Но потребуется время, в отличии от спящего режима процесс медленнее.



---

### Задание 2

В лекции не была упомянута одна известная команда для получения информации о нагрузке на компьютер и в частности  на ОЗУ.

Ее вывод выглядит примерно вот так:

<a href="https://imgbb.com/"><img src="https://i.ibb.co/7Q16Chb/2020-12-07-16-52-37.png" alt="2020-12-07-16-52-37" border="0"></a>

*Как называется эта команда? Что такое si и so  в примере на картинке? *

*Приведите ответ в свободной форме.*

---

**Выполнение задания 2.**

с помощью `vmstat`  можно получить информацию  о виртуальной памяти, о памяти используемой для кэша, для буфера обмена, Swap памяти. 

Так `si` и `so` для Swap раздела выводят информацию об объеме памяти si - выгруженной с диска, so - перенесенной на диск.



---

### Задание 3

Приведите 3 команды, которые выведут на экран следующее::

1) Архитектуру ПК
2) Модель процессора
3) Количество памяти, которая уже не используется процессами, но еще остается в памяти(ключевое слово - inactive).

*Примечание: при выполнении задания предполагается использование конструкции "{команда} | grep {параметр для фильрации вывода}"*

---

**Выполнение задания 3.**

1. `1. hostnamectl | grep  Architecture`

2. `lscpu | grep 'Model name'`

3. `cat /proc/meminfo | grep Inactive`


---

### Задание 4

1) Создайте скрин вывода команды `free -h -t`
2) Создайте swap-файл размером 1Гб
3) Добавьте настройку чтобы swap-файл подключался автоматически при перезагрузке виртуальной машины (подсказка: необходимо внести изменения в файл `/etc/fstab`)
4) Создайте скрин вывода команды `free -h -t`
5) Создайте скрин вывода команды `swapon -s`
6) Измените процент свободной оперативной памяти, при котором начинает использоваться раздел подкачки до 30%. Сделайте скрин внесенного изменения.


*В качестве ответа приложите созданные скриншоты*

---

**Выполнение задания 4.**


![img1.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img1.jpg)

![img2.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img2.jpg)

![img3.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img3.jpg)

![img4.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img4.jpg)

***после перезагрузки***

![img5.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img5.jpg)

---


### Задание 5*

Найдите информацию про tmpfs.

*Расскажите в свободной форме, в каких случаях уместно использовать эту технологию.*

Создайте диск `tmpfs` (размер выберите исходя из объёма ОЗУ на ПК: 512Мб-1Гб), смонтируйте его в директорию `/mytmpfs`.

*В качестве ответа приведите скрин вывода команды df- h до и после монтирования диска tmpfs.*


---

**Выполнение задания 5.**

**tmpfs**

 монтирую tmpfs `mount -t tmpfs -o size=1G,nr_inodes=10k,mode=0700 tmpfs /mytmpfs`

с целью сравнить скорости копирования  создаю один файл образа диска в 800 Мб,  

`sudo dd if=/dev/zero of=test-1g bs=1M count=800`


выполняю копирование файла в диреткорию `sudo cp test-1g /mytmpfs `

определяю время выполнения `time sudo cp test-1g /mytmpfs`


**результаты:**

```
real    0m0,581s
user    0m0,010s
sys     0m0,568s
```

**а также выполняю копирование в текущую же диреторию**

копирование `cp test-1g .test-1g_1`
определяю время `time cp test-1g .test-1g_1`

**результаты:**

```
real    0m1,816s
user    0m0,008s
sys     0m1,589s
```

По тесту можно заметить разницу в скорости работы копирования файла , из за того что `tmpfs` размещается в ОЗУ вместо основного диска. 
В основном файловая система применяется для временного хранения данных. После перезагрузки размещенные в ней данные могут быть утеряны.



`вывод команды df -h`

![img6.JPG](https://github.com/elekpow/netology/blob/main/os-linux/images/img6.jpg)

---
    `
