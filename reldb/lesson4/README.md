# Домашнее задание к занятию «SQL. Часть 2» <br/> Игорь Левин

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию: 
- фамилия и имя сотрудника из этого магазина;
- город нахождения магазина;
- количество пользователей, закреплённых в этом магазине.

---

**Выполнение задания 1.**

проверим все имеющиеся таблицы
```
SELECT TABLE_NAME, GROUP_CONCAT(COLUMN_NAME) 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'sakila' AND COLUMN_KEY = 'PRI' 
GROUP BY TABLE_NAME;
```

 ![command.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/command.JPG)
 

Определим нужные таблицы:
фамилия и имя сотрудника - находятся в таблице  `staff` 
город нахождения магазина - в таблице `city`
количество пользователей получить из таблицы `customer`, и из неё определить количество больше 300

соединим таблицы через внутреннее соединение  `INNER JOIN`

**запрос примет вид:**

```
SELECT CONCAT (staff.last_name,' ',staff.first_name) AS 'shop worker',
city.city AS 'shop city', 
COUNT(customer.customer_id) AS 'number of users'
FROM  staff
 JOIN address ON staff.address_id=address.address_id
 JOIN city ON address.city_id=city.city_id
 JOIN country ON city.country_id=country.country_id
 JOIN store on staff.store_id=store.store_id
 JOIN customer on store.store_id=customer.store_id
GROUP BY customer.store_id
HAVING COUNT(customer.customer_id) > 300
```

 ![command_sql.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/command_sql.JPG)
 
 
Для удобства подключимся  к имеющейся базе данных, которая запущена в docker контейнере через **Инструмент администрирования SQL** 
 
 ![sql.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/sql.JPG)

---

### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

---

**Выполнение задания 2.**


Среднюю продолжительность фильмов определим через функцию `AVG` , используя подзапрос `SELECT avg(film.length ) FROM sakila.film` ,  также через функцию CASE сравним продолжительность каждого фильма к найденому среднему значению. 

Запрос будет выглядеть следующим образом:

```
SELECT
COUNT(1) AS 'count', (SELECT avg(film.length ) FROM sakila.film ) AS 'average'
FROM sakila.film 
WHERE 
 case 
 	when film.length < (SELECT avg(film.length ) FROM sakila.film ) 
		then 'over' 
		ELSE TRUE
	END

```

 ![AVG.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/AVG.JPG)


---

### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.


---

**Выполнение задания 3.**

Для получения информации о месяце с наибольшей суммой платежей нужно сгруппировать платежи по месяцам,и вычислить суммы платежей в каждом месяце. 

Ограничим результаты одной записью `LIMIT 1`, чтобы выбрать только месяц с наибольшей суммой.

Запрос будет выглядеть следующим образом:

```
SELECT COUNT(*) AS count_renatals, 
MONTHNAME(payment.payment_date) AS months,
YEAR(payment.payment_date) AS years 
FROM payment
INNER JOIN rental ON payment.rental_id=rental.rental_id
GROUP BY months
ORDER BY count_renatals DESC
LIMIT 1;
```

 ![count_renatals.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/count_renatals.JPG)

Информация о количестве аренд за этот месяц, получена из таблицы `rental` .

Запрос будет выглядеть так:

```
SELECT
MONTHNAME(payment.payment_date) AS MONTH, 
YEAR(payment.payment_date) AS YEARS, 
sum(payment.amount) AS total_payments,
COUNT(rental.rental_id)
FROM payment
INNER JOIN rental ON payment.rental_id=rental.rental_id
GROUP BY MONTH
ORDER BY total_payments DESC
LIMIT 1;
```
 
 ![total_payments.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/total_payments.JPG)


 
 
---

### Задание 4*

Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».

---

**Выполнение задания 4.**

вычислим количество продаж для каждого продавца , для удобства объединим имя и фамилию. Объединим таблицы **store**  **customer** **payment** 
Определим условие получение премии, оно должно превышать 8000 , для этого задаем условие `count(payment.amount) > 8000`

Запрос будет выглядеть так:

```
SELECT
concat(staff.first_name,' ',staff.last_name) AS Name,
count(payment.amount) AS sales, 
case 
	when count(payment.amount) > 8000 
		then 'Yes'
		ELSE 'No'
END AS 'cash_bonus'
FROM staff
INNER JOIN store ON staff.store_id=store.store_id
INNER JOIN customer ON store.store_id=customer.store_id
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY Name; 
```


 ![cash_bonus.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/cash_bonus.JPG)

---

### Задание 5*

Найдите фильмы, которые ни разу не брали в аренду.


---

**Выполнение задания 5.**

---
Фильмы, которые не брали в аренду ,в таблице `rental_date` имеют значение `NULL`, получим их по условию `WHERE rental.rental_date IS NULL `  

Запрос будет выглядеть так:

```
SELECT film.title AS 'movies', COUNT(*) AS 'Total'
FROM film
LEFT JOIN inventory ON film.film_id=inventory.film_id
LEFT JOIN rental ON inventory.inventory_id=rental.inventory_id
WHERE rental.rental_date IS NULL 
GROUP BY movies
ORDER BY film.title ASC
```

 ![films.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/films.JPG)


Определим количество фильмов:
 
 ![films_not_rent.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/films_not_rent.JPG)


 
