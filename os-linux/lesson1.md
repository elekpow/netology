# Домашнее задание к занятию "Процессы, управление процессами "

---

### Задание 1

Рассмотрим загрузку данных и многопоточность. В описанных ниже ситуациях поможет ли использование нескольких потоков для скачивания уменьшить время общей загрузки?

1. 100 файлов на разных Web-серверах, суммарным объёмом 10 Гбайт, через подключение со скоростью 1Мбит\с;
2. 100 файлов на разных Web-серверах, суммарным объёмом 10 Гбайт, через подключение со скоростью 10 Гбит\с;
3. 1 файл объёмом 10 Гбайт находящийся в торрентах;
4. 1 файл объёмом 10 Гбайт находящийся на FTP-сервере;
5. 10 файлов объёмом по 1 Гб находящихся в общей папке компьютера секретаря.

*Приведите ответ для каждого случай в свободной форме (лучше использовать один поток скачивания, несколько, всё равно) со своим комментарием.*

---

**Выполнение задания: Задание 1.**

1. 100 файлов на разных Web-серверах, суммарным объёмом 10 Гбайт, через подключение со скоростью 1Мбит\с; 

**Вообще скачивание объема данных 10 Гбайт  при скорости скачивания 1Мбит\с займет примерно ~ 22 часа 45 минут ( (10*1024*8)/3600 ). Учитывая, что скачивание 100 файлов одновременное, скорость будет распределена на все файлы. Использование нескольких потоков позволит ускорить загрузку..**

2. 100 файлов на разных Web-серверах, суммарным объёмом 10 Гбайт, через подключение со скоростью 10 Гбит\с; 

**При скорости сети в 10 Гбит\с , распределение на каждый файл составит примерно ~ 100 Мбит\с, этого достаточно и можно не использовать многопоточную загрузку.**

3. 1 файл объёмом 10 Гбайт находящийся в торрентах; 

**Скорость скачивания зависит от количества доступных устройств и их скорости раздачи. Несколько потоков позволяют уменьшить время загрузки.**

4. 1 файл объёмом 10 Гбайт находящийся на FTP-сервере; 

**Скачивание будет в один поток.** 

5. 10 файлов объёмом по 1 Гб находящихся в общей папке компьютера секретаря. 

**Копирование файлов будет в один поток. Но можно многопоточное копирование даст прирост скорости, но для файлов в 1Гб в сети 100**

---

### Задание 2

Объясните, что делает команда:

`ps -aux | grep root | wc -l  >> root`

*Ответ напишите в свободной форме.*

**Примечание:**

Если вы встречаете неизвестную команду Linux, либо неизвестные параметры команды, то можете вызвать встроенную помощь:
`man <команда>`

Например:

- man ps;
- man grep;
- man wc.

---

**Выполнение задания: Задание 2.**

Команда `ps -aux` выводит подробную информацию обо всех процессах пользователя, далее  `grep root`выбираются только для пользователя root , и далее сам происходит  анализ полученного результата -  подсчет количества строк командой `wc -l` , который записывается в файл с названием `root`, который для удобства восприятия назван по имени пользователя 



---

### Задание 3

Напишите команду, которая выводит все запущенные процессы пользователя root в файл `"user_root_ps"`.

---

**Выполнение задания: Задание 3.**

```
ps -fU root > user_root_ps

```


---

### Задание 4

Начинающий администратор захотел вывести все запущенные процессы пользователя с логином "2" в файл "user_2_ps".

Для этого он набрал команду:

`ps -U 2> user_2_ps`

Затем, он аналогично повторил для пользователя с логином "5" вывод в файл "user_5_ps":

`ps -U 5> user_5_ps`

**Вопрос:** 

Почему вывод этих команд и содержимое файлов сильно отличаются друг от друга?  Как должны выглядеть правильные команды?

**Примечание:**

Если у вас в системе нет пользователей "2" и/или "5" (это нормальная ситуация), то утилита ps выводит только одну строку:

`  PID TTY          TIME CMD 


---

**Выполнение задания: Задание 4.**

---

Отличие в выводе команд, `ps -U 2> user_2_ps `  в данном случае в файл `“user_2_ps”` будет выведен - стандартный вывод ошибок stderr (standard error, 2). 

`ps -U 5> user_5_ps`, в это случае будет вывод в 1 поток и выводиться на экран, в файл `“user_5_ps”` ничего на запишеться.

Ошибка в том, что  пропущен пробел между именем пользователя и стрелкой

`ps -U 2 > user_2_ps` , аналогично для `ps -U 5 > user_5_p` , команды выведут

```
  PID TTY          TIME CMD
```
