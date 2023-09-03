# Домашнее задание к занятию "Использование логических операций"

*Примерное время выполнения задания: 45 минут*

### Цель задания
В результате выполнения этого задания вы научитесь строить таблицы истинности для операций, составлять логические выражения и решать логические уравнения на практике.

### Зачем делать это задание
Знать основы булевой алгебры и алгебры логики нужно каждому ИТ-специалисту. Это основа для создания алгоритмов и объяснений компьютеру, как он должен вести себя в той или иной ситуации.

### Чеклист готовности к выполнению домашнего задания
- Вы просмотрели видеолекции по теме «Использование логических операций».
- Вы изучили дополнительный материал по теме «Использование логических операций», представленный в личном кабинете Нетологии.

------

### Инструкция к выполнению домашнего задания

1. Сделайте копию [Шаблона для домашнего задания](https://docs.google.com/document/d/18IVdFLq5yjoU699MkVhZ4Ep4asvGXVijbV4PA64F2Eo/edit?usp=sharing) себе на Google Disk.
2. Выполните домашнее задание, запишите ответы и приложите необходимые скриншоты в свой Google Doc.
3. Для проверки домашнего задания отправьте ссылку на ваш документ в личном кабинете Нетологии.
4. Обратите внимание, что это домашнее задание с самопроверкой. Отправив задание в личном кабинете, вы получите ссылку на правильные ответы с подробными комментариями к решениям. 
5. Проверьте свои ответы и эталонное решение. Внесите правки в свой файл при необходимости.
6. Любые вопросы по решению задач задавайте в чате учебной группы.

------

### Задание 1. Построение таблиц истинности

Постройте таблицы истинности для следующих примеров:

- !(a ∨ b ∧ с) ∧ (a ∧ b)
- !a ∨ !c ∧ !b
- a ∧ b ∧ c ∨ d
- !(a ∧ !b ∧ c)
- !(a ∨ b) ∨ c

------

**Выполнение задания 1**

!a - не - отрицание ; 
∧ - & - и - Конъюнкция ; 
v - | - или - дизъюнкция ; 
(2 в степени количества переменных это число строк таблица истиности) 

порядок действий: 1) действие в скобках 2) по приоритетам: отрицание, Конъюнкция, дизъюнкция

**!(a ∨ b ∧ с) ∧ (a ∧ b)**

a|b|c|b ∧ с|a ∨ (1)|a ∧ b|!(2)|(4)∧(3)
-|-|-|-|-|-|-|-|-|
0|0|0|1|1|0|1|0|
0|0|1|0|0|0|1|0|
0|1|0|0|0|0|1|0|
0|1|1|1|1|0|0|0|
1|0|0|1|1|0|0|0|
1|0|1|0|1|0|0|0|
1|1|0|0|1|1|0|0|
1|1|1|1|1|1|0|0|

**!a ∨ !c ∧ !b**

a|b|c|!a|!c|!b|(2)∧(3)|(1)∨(4)
-|-|-|-|-|-|-|-|-|
0|0|0|1|1|1|1|1
0|0|1|1|0|1|0|1
0|1|0|1|1|0|0|1
0|1|1|1|0|0|1|1
1|0|0|0|1|1|1|1
1|0|1|0|0|1|0|0
1|1|0|0|1|0|0|0
1|1|1|0|0|0|1|1


**a ∧ b ∧ c ∨ d**

a|b|c|d|a ∧ b|(1)∧ c|(2)∨ d|
-|-|-|-|-|-|-|-|-|
0|0|0|0|1|0|0
0|0|0|1|1|0|1
0|0|1|0|1|1|1
0|0|1|1|1|1|1
0|1|0|0|0|1|1
0|1|0|1|0|1|1
0|1|1|0|0|0|0
0|1|1|1|0|0|1
1|0|0|0|0|1|1
1|0|0|1|0|1|1
1|0|1|0|0|0|0
1|0|1|1|0|0|1
1|1|0|0|1|0|0
1|1|0|1|1|0|1
1|1|1|0|1|1|1
1|1|1|1|1|1|1


**!(a ∧ !b ∧ c)**

a|b|c|!b|a ∧ (1)|(2)∧ c|!(3)
-|-|-|-|-|-|-|-|-|
0|0|0|1|0|1|0
0|0|1|1|0|1|0
0|1|0|0|1|0|1
0|1|1|0|1|0|1
1|0|0|1|1|1|0
1|0|1|1|1|1|0
1|1|0|0|0|0|1
1|1|1|0|0|0|1

**!(a ∨ b) ∨ c**

a|b|c|a ∨ b|!(1)|(2) ∨ c
-|-|-|-|-|-|-|-|-|
0|0|0|0|1|1
0|0|1|0|1|1
0|1|0|1|0|0
0|1|1|1|0|0
1|0|0|1|0|1
1|0|1|1|0|1
1|1|0|1|0|1
1|1|1|1|0|1



### Задание 2. Определите, каким выражением может быть Func

Дан фрагмент таблицы истинности выражения Func:

a|b|c|d|e|f|Func
-|-|-|-|-|-|----
1|1 | 0 | 0 | 0 | 0 | 0
1|0 | 1 | 0 | 0 | 1 | 0
1|0 | 0 | 1 | 0 | 0 | 0

*Решите примеры, приведённые ниже, и выберите тот вариант, который подходит под таблицу истинности:*

- (a ∧ b) ∨ (c ∧ d) ∨ (e ∧ f)
- (a ∧ c) ∨ (c ∧ e) ∨ (e ∧ a)
- (b ∧ d) ∨ (d ∧ f) ∨ (f ∧ b)
- (a ∧ d) ∨ (b ∧ e) ∨ (c ∧ f)


**выполение задания 2.**


**(a ∧ b) ∨ (c ∧ d) ∨ (e ∧ f)**


(a ∧ b)|(c ∧ d)|(e ∧ f)|(1) ∨ (2)|(4) ∨ (3)
-|-|-|-|-|-|----
1|0|0|1|1|
0|0|0|0|0|
0|0|0|0|0|


**(a ∧ c) ∨ (c ∧ e) ∨ (e ∧ a)**

(a ∧ c)|(c ∧ e)|(e ∧ a)|(1) ∨ (2)|(4) ∨ (3)
-|-|-|-|-|-|----
0|0|0|0|0|
1|0|0|1|1|
0|0|0|0|0|


**(b ∧ d) ∨ (d ∧ f) ∨ (f ∧ b)**

наиболее подходящее выражение

(b ∧ d)|(d ∧ f) |(f ∧ b)|(1) ∨ (2)|(4) ∨ (3)
-|-|-|-|-|-|----
0|0|0|0|0
0|0|0|0|0
0|0|0|0|0

**(a ∧ d) ∨ (b ∧ e) ∨ (c ∧ f)**

(a ∧ d)|(b ∧ e)|(c ∧ f)|(1) ∨ (2)|(4) ∨ (3)
-|-|-|-|-|-|----
0|0|0|0|0
0|0|1|0|1
1|0|0|1|1




------
### Задание 3. Составьте логические выражения

Даны выражения:

![Alt text](https://github.com/netology-code/balgo-homeworks/blob/main/2/Example2.png "Optional title")

 
Составьте и запишите на языке алгебры логики (используя логические операции) следующие выражения:
- «На улице мороз, небо пасмурное, но снег не идёт»;
- «На улице температура плюсовая и туман или на деревьях иней»;
- «На улице северный ветер или идёт снег, и на улице мороз»;
- «На дорогах нет гололедицы, но при этом дует северный ветер, мороз, снег налипает на провода»;
- «На улице оттепель или на деревьях иней, при этом температура плюсовая, или небо ясное».

*Используйте латинские буквы в столбцах 1 и 3 для обозначения словосочетания из таблицы в логическом выражении. 
Например, N соответствует 'Ветер северный', T - 'температура плюсовая'.* 

------



**Выполнение задания 3**

- «На улице мороз, небо пасмурное, но снег не идёт»;

**M ^ P ^ !c**

- «На улице температура плюсовая и туман или на деревьях иней»;

**(T ^ U) v I**

- «На улице северный ветер или идёт снег, и на улице мороз»;

**(N v C) ^ M** 

- «На дорогах нет гололедицы, но при этом дует северный ветер, мороз, снег налипает на провода»;


**!G ^ N ^ M ^ Z**


- «На улице оттепель или на деревьях иней, при этом температура плюсовая, или небо ясное».

**(O v I) ^ (T v !P) 






### Правила приема домашнего задания

В личном кабинете отправлена ссылка на документ (Google Doc) с выполненным заданием.

---

### Критерии оценки

Задание является самостоятельным. Решив все примеры, отправьте ссылку на решение в личном кабинете. После этого вам будет доступна ссылка на эталонное решение. Сверьте своё решение с эталоном.