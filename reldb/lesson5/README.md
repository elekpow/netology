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



Выполнив `EXPLAIN ANALYZE ` запроса , получаем :

```
-> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=14692..14692 rows=391 loops=1)
    -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=14692..14692 rows=391 loops=1)
        -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=6396..14004 rows=642000 loops=1)
            -> Sort: c.customer_id, f.title  (actual time=6396..6609 rows=642000 loops=1)
                -> Stream results  (cost=21.7e+6 rows=15.8e+6) (actual time=1.24..5089 rows=642000 loops=1)
                    -> Nested loop inner join  (cost=21.7e+6 rows=15.8e+6) (actual time=1.02..4322 rows=642000 loops=1)
                        -> Nested loop inner join  (cost=20.1e+6 rows=15.8e+6) (actual time=1.02..3977 rows=642000 loops=1)
                            -> Nested loop inner join  (cost=18.5e+6 rows=15.8e+6) (actual time=0.991..3470 rows=642000 loops=1)
                                -> Inner hash join (no condition)  (cost=1.58e+6 rows=15.8e+6) (actual time=0.945..213 rows=634000 loops=1)
                                    -> Filter: (cast(p.payment_date as date) = '2005-07-30')  (cost=1.65 rows=15813) (actual time=0.354..15.3 rows=634 loops=1)
                                        -> Table scan on p  (cost=1.65 rows=15813) (actual time=0.339..9.07 rows=16044 loops=1)
                                    -> Hash
                                        -> Covering index scan on f using idx_title  (cost=112 rows=1000) (actual time=0.157..0.475 rows=1000 loops=1)
                                -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=0.969 rows=1) (actual time=0.00328..0.00489 rows=1.01 loops=634000)
                            -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=250e-6 rows=1) (actual time=533e-6..571e-6 rows=1 loops=642000)
                        -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=250e-6 rows=1) (actual time=245e-6..315e-6 rows=1 loops=642000)

```

 ![explain_analyze_1.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson5/images/explain_analyze_1.JPG)


Длительность за проса составила : 14,703 сек., как видно из результата наиболее узким место в запросе является применеие оконной функции 
`Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title ) ` в ней время на выполние занимает 6,396..14,004 секунд
анализируя далее, видим `Sort: c.customer_id, f.title` в котором время выполения составляет 6.396..6,609 секунд. 
Из запроса `sum(p.amount) over (partition by c.customer_id, f.title)` видно, что в партицию,  при выполнении оконной функции также попадает `f.title` , что явялется избыточным, так как таблица - `film` не используется, кроме того лишними будут также `inventory` и `rental`.

Оптимизируем запрос :


```sql

-- оптимизированый запрос----------------------

select DISTINCT concat(c.last_name, ' ', c.first_name) AS customer_name_1, 
sum(p.amount) over (partition by c.customer_id) AS summ 
from payment p,  customer c
where date(p.payment_date) = '2005-07-30' 
and p.customer_id = c.customer_id 

```

 ![explain_analyze1.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson5/images/explain_analyze1.JPG)


Сравним результаты :
 
```sql
EXPLAIN ANALYZE 
-- запрос----------------------

select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id;
/* Затронуто строк: 0  Найденные строки: 1  Предупреждения: 0  Длительность  1 запрос: 15,672 сек. */

EXPLAIN ANALYZE 
-- оптимизированый запрос----------------------

select DISTINCT concat(c.last_name, ' ', c.first_name) AS customer_name_1, 
sum(p.amount) over (partition by c.customer_id) AS summ 
from payment p,  customer c
where date(p.payment_date) = '2005-07-30' 
and p.customer_id = c.customer_id ;
/* Затронуто строк: 0  Найденные строки: 1  Предупреждения: 0  Длительность  1 запрос: 0,016 сек. */
```

