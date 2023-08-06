# Домашнее задание к занятию «Индексы» <br/> Игорь Левин

### Задание 1

Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.

---

**Выполнение задания 1.**


значения индексов получить через запарос к `INFORMATION_SCHEMA.TABLES`
```sql
SELECT index_length,data_length
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sakila';
```

Вычислим процентное отношение общего размера всех индексов к общему размеру всех таблиц:

```sql
SELECT table_schema AS 'DataBase' , 
CONCAT(ROUND((SUM(index_length) * 100 / SUM(data_length)), 2), ' ', '%' )AS 'index/size'
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sakila';


```
 ![sakila_indexes.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson5/images/sakila_indexes.JPG)


---
### Задание 2

Выполните explain analyze следующего запроса:
```sql
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
- перечислите узкие места;
- оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.
---



**Выполнение задания 2.**


---

### Задание 3*

Самостоятельно изучите, какие типы индексов используются в PostgreSQL. Перечислите те индексы, которые используются в PostgreSQL, а в MySQL — нет.

*Приведите ответ в свободной форме.*

---

**Выполнение задания 3.**


---