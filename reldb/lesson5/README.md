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
-> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=6000..6000 rows=391 loops=1)
    -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=6000..6000 rows=391 loops=1)
        -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=2448..5756 rows=642000 loops=1)
            -> Sort: c.customer_id, f.title  (actual time=2448..2527 rows=642000 loops=1)
                -> Stream results  (cost=10.8e+6 rows=16.7e+6) (actual time=0.352..1757 rows=642000 loops=1)
                    -> Nested loop inner join  (cost=10.8e+6 rows=16.7e+6) (actual time=0.346..1526 rows=642000 loops=1)
                        -> Nested loop inner join  (cost=9.12e+6 rows=16.7e+6) (actual time=0.343..1339 rows=642000 loops=1)
                            -> Nested loop inner join  (cost=7.45e+6 rows=16.7e+6) (actual time=0.337..1139 rows=642000 loops=1)
                                -> Inner hash join (no condition)  (cost=1.65e+6 rows=16.5e+6) (actual time=0.325..50.8 rows=634000 loops=1)
                                    -> Filter: (cast(p.payment_date as date) = '2005-07-30')  (cost=1.72 rows=16500) (actual time=0.0298..6.3 rows=634 loops=1)
                                        -> Table scan on p  (cost=1.72 rows=16500) (actual time=0.0208..4.14 rows=16044 loops=1)
                                    -> Hash
                                        -> Covering index scan on f using idx_title  (cost=103 rows=1000) (actual time=0.0354..0.223 rows=1000 loops=1)
                                -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=0.25 rows=1.01) (actual time=0.00109..0.00155 rows=1.01 loops=634000)
                            -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=250e-6 rows=1) (actual time=150e-6..176e-6 rows=1 loops=642000)
                        -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=250e-6 rows=1) (actual time=129e-6..158e-6 rows=1 loops=642000)

```

 ![explain_analyze_1.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson5/images/explain_analyze_1.JPG)


Длительность за проса составила : 6,016 сек., как видно из результата наиболее узким место в запросе является применеие оконной функции 
`Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title ) ` в ней время на выполние занимает 6,396..14,004 секунд
анализируя далее, видим `Sort: c.customer_id, f.title` в котором время выполения составляет 2448..2527 секунд. Также Filter: (cast(p.payment_date as date) = '2005-07-30') , указывает на дату по которой идет фильтрация, время выполения составило 0.0298..6.3 секунд, тоже требует оптимизации. 
Из запроса `sum(p.amount) over (partition by c.customer_id, f.title)` видно, что в партицию,  при выполнении оконной функции, также попадает `f.title` , что явялется избыточным, так как таблица - `film` не используется.


Пробую изменить Запрос. 

```sql
-- оптимизированый запрос   -------------------------------------------------

 SELECT DISTINCT concat(c.last_name, ' ', c.first_name) AS customer_name_1, sum(p.amount)  AS summ														
	FROM  customer c
		INNER JOIN rental r ON r.customer_id = c.customer_id 
		INNER JOIN payment p ON p.payment_date = r.rental_date 
		INNER JOIN inventory i ON i.inventory_id = r.inventory_id	
	WHERE p.payment_date  >= '2005-07-30' AND p.payment_date < DATE_ADD('2005-07-30', INTERVAL 1 DAY)	
	GROUP BY customer_name_1;	
```

**Вывод EXPLAIN ANALYZE**

```
-> Table scan on <temporary>  (actual time=8.35..8.42 rows=391 loops=1)
    -> Aggregate using temporary table  (actual time=8.35..8.35 rows=391 loops=1)
        -> Nested loop inner join  (cost=3617 rows=1856) (actual time=0.0867..6.85 rows=642 loops=1)
            -> Nested loop inner join  (cost=2968 rows=1856) (actual time=0.0832..6.25 rows=642 loops=1)
                -> Nested loop inner join  (cost=2318 rows=1856) (actual time=0.076..5.71 rows=642 loops=1)
                    -> Filter: ((p.payment_date >= TIMESTAMP'2005-07-30 00:00:00') and (p.payment_date < <cache>(('2005-07-30' + interval 1 day))))  (cost=1674 rows=1833) (actual time=0.0676..4.49 rows=634 loops=1)
                        -> Table scan on p  (cost=1674 rows=16500) (actual time=0.0592..3.46 rows=16044 loops=1)
                    -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=0.25 rows=1.01) (actual time=0.00126..0.00178 rows=1.01 loops=634)
                -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.25 rows=1) (actual time=697e-6..718e-6 rows=1 loops=642)
            -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.25 rows=1) (actual time=735e-6..762e-6 rows=1 loops=642)
```

```
  Длительность  запроса:  0,016 сек 
```



 ![explain_analyze_2.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson5/images/explain_analyze_2.JPG)
 

 **inventory_id**, **payment_date** имеют значение -  **Extra: Using index**,  Это означает, что данные читаются из индекса, СУБД загружает все данные из него и возвращает результат.
 
 
  ![indexes.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson5/images/indexes.JPG)
 


