# Домашнее задание к занятию </br> «Базы данных»  </br> **Игорь Левин**
 
---
### Легенда

Заказчик передал вам [файл в формате Excel](https://github.com/netology-code/sdb-homeworks/blob/main/resources/hw-12-1.xlsx), в котором сформирован отчёт. 

На основе этого отчёта нужно выполнить следующие задания.

### Задание 1

Опишите не менее семи таблиц, из которых состоит база данных:

- какие данные хранятся в этих таблицах;
- какой тип данных у столбцов в этих таблицах, если данные хранятся в PostgreSQL.

Приведите решение к следующему виду:

Сотрудники (

- идентификатор, первичный ключ, serial,
- фамилия varchar(50),
- ...
- идентификатор структурного подразделения, внешний ключ, integer).

---

**Выполнение задания 1.**


- Таблица "Сотрудники" , в ней хранятся ФИО Сотрудников, текстовые данные, в sql тип данных `varchar`
- Таблица "Подразделения",  в ней хранятся наименования структурных подразделений,текстовые данные,в sql тип данных `varchar`
- Таблица "Тип подразделения", в этой таблице подраздаеления объединены в своеобразные группы по опредеоенному типу деятельности,текстовые данные,в sql тип данных `varchar`
- Таблица "Должность", в этой таблице каждому сотруднику присвоена должность,текстовые данные,в sql тип данных `varchar`
- Таблица "Оклад", в этой таблице указан оклад сотрудника,текстовые данные,в sql тип данных `decimal`, наиболее походящий для хранения денежных значений
- Таблица "Дата найма",числовые данные,в sql тип данных `int`
- Таблица "Адрес филиала", Таблица содержит адреса филиалов,текстовые данные,в sql тип данных `varchar`
- Таблица "Проекты", Название проектов (Проект на который назначен), на которые назначен сотрудник,текстовые данные,в sql  тип данных `varchar`

---
**Приведем таблицу из Excel в вид таблиц базы данных**
 
- Таблица "Сотрудники" , разделим по столбцам : "Фамилия","Имя","Отчество"
- определим таблицу "Трудоустройство"
- Таблица "Подразделения"
- Таблица "Тип подразделения"
- Таблица "Должность"
- Таблица "Оклад"
- Таблица "Дата найма"
- Таблица "Адрес филиала",
  и разделим:
- Таблицы "Регион"; "Город" 
 "Местоположение", содержащую в себе улицу и дом.



```
"Сотрудники"(
- id SERIAL PRIMARY KEY,
- First_name  varchar(100) NOT NULL,
- Middle_name   varchar(100) NOT NULL,
- last_name  varchar(100) NOT NULL, 
)
```

```
"Трудоустройство"(
- id SERIAL PRIMARY KEY,
- worker_id int,		/*сотрудник*/
- divisions_id int,		/* подраздаеление*/ 
- employment int, 		/* дата найма*/
- project int , 		/* Проекты*/ 
- payment int , 		/* оклад */ 
- post int 			/* должность */
)
```

```
"Оклад"(
- id SERIAL PRIMARY KEY,
- payment DECIMAL(10,2)
)
```

```
"Должность"(
- id SERIAL PRIMARY KEY,
- post varchar(100) NOT NULL
)
```

```
"Проекты"(
- id SERIAL PRIMARY KEY,
- title varchar(50) NOT NULL
)
```

```
"Подразделения"(
- id SERIAL PRIMARY KEY,
- title varchar(100) NOT NULL,
- div_type int,			/* "Тип подразделения" */
- address int			/* "Таблица Адрес" */ 
)
```

```
"Тип подразделения"(
- id SERIAL PRIMARY KEY,
- title varchar(50) NOT NULL
)
```

```
"Таблица Адрес"(
- id SERIAL PRIMARY KEY,
- region_id integer,
- city_id integer,
- street_id integer 
)
```

```
"Таблица Регион"(
- id SERIAL PRIMARY KEY,
- region varchar(50) NOT NULL
)
```

```
"Таблица город"(
- id SERIAL PRIMARY KEY,
- city varchar(50) NOT NULL 
)
```

```
"Таблица Местоположение "(
- id SERIAL PRIMARY KEY,
- address varchar(50) NOT NULL
)
```



---

### Задание 2*

Перечислите, какие, на ваш взгляд, в этой денормализованной таблице встречаются функциональные зависимости и какие правила вывода нужно применить, чтобы нормализовать данные.

---

**Выполнение задания 2*.**

---
В денормализованной таблице данные хранятся в повторяющихся группах или дублируются,  это может привести к избыточности данных и потере целостности.
В нормализованной форме каждая таблица должна хранить информацию только об одной сущности, а каждая ячейка таблицы должна содержать только одно значение.
В приведенной таблице Excel Функциональные зависимости (зависимость значения одного атрибута от другого) например в столбцах: "ФИО сотрудника" и "Оклад".

Уменьшим избыточность данных, и структурируем базу в соответствие нормальным формам. Для нормализации таблицы "Адрес" разделим на составляющие таблицы.

Преобразуем данные в формат хранения  базы данных, раделив по соответсвующим таблицам. Вариант можно представить ввиде диаграммы:

 ![test1.png](https://github.com/elekpow/netology/blob/main/reldb/lesson1/images/test1.png)

