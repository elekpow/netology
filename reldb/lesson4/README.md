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
 

Подключимся  к имеющейся базе данных, которая запущена в docker контейнере через Инструмент администрирования SQL 
 
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

 ![sql.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson4/images/sql.JPG)

---

### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

---

**Выполнение задания 2.**


---

### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.


---

**Выполнение задания 3.**

 
---

### Задание 4*

Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».

---

**Выполнение задания 4.**


---

### Задание 5*

Найдите фильмы, которые ни разу не брали в аренду.


---

**Выполнение задания 5.**


---
