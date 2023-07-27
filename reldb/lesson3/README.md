# Домашнее задание к занятию «SQL. Часть 1»  <br/> Игорь Левин 

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.

---

**Выполнение задания 1.**


 Определим список таблиц в базе данных , а также имена колонок в таблице **'address'**

```
SELECT TABLE_NAME, GROUP_CONCAT(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'sakila' AND COLUMN_KEY = 'PRI' GROUP BY TABLE_NAME;

SELECT COLUMN_NAME  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'sakila' AND TABLE_NAME = 'address';
```

Проверим все какие столбцы имеются в таблице `SELECT * FROM sakila.address LIMIT 3 ;` , нужный нам столбец **district** 

**DISTINCT** - вывести уникальные значения

**LIKE** используется для поиска строк, содержащих определённый шаблон символов. 

**NOT LIKE** - не соответствие шаблону


Уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.

```
SELECT DISTINCT (district) FROM sakila.address WHERE district LIKE 'K%a' AND district NOT LIKE '% %'   ORDER BY district ASC;
```

![district_like.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson3/images/district_like.JPG)


---

### Задание 2

Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года **включительно** и стоимость которых превышает 10.00.

---

**Выполнение задания 2.**


Определим  имена колонок в таблице **'payment'**

`SELECT COLUMN_NAME  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'sakila' AND TABLE_NAME = 'payment';`

с помощью **BETWEEN** определим диапазон дат 

```
SELECT DISTINCT (DATE_FORMAT(payment_date,'%Y-%m-%d') )  
FROM sakila.payment 
WHERE DATE_FORMAT(payment_date,'%Y-%m-%d') BETWEEN '2005-06-15' AND '2005-06-18' 
ORDER BY DATE_FORMAT(payment_date,'%Y-%m-%d') ASC ;
```

а теперь получим из таблицы платежей информацию по платежам в промежутке с 15 июня 2005 года по 18 июня 2005 года,  со стоимостью превышающей 10.00.


``` 
SELECT amount, payment_date  FROM sakila.payment WHERE  DATE_FORMAT(payment_date,'%Y-%m-%d') BETWEEN '2005-06-15' AND '2005-06-18' AND amount > '10.00'  ORDER BY DATE_FORMAT(payment_date,'%Y-%m-%d') ASC ;
```
  
 
 ![payment_date.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson3/images/payment_date.JPG)
 
---

### Задание 3

Получите последние пять аренд фильмов.

---

**Выполнение задания 3.**


Определим  имена колонок в таблице **'rental'**

```
SELECT COLUMN_NAME  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'sakila' AND TABLE_NAME = 'rental';
```

Из таблицы **rental** получим последние пять аренд фильмов, прменим `limit 5`

```
SELECT inventory_id,rental_date  FROM sakila.rental WHERE return_date IS NULL ORDER BY DATE_FORMAT(rental_date,'%Y-%m-%d') DESC limit 5 ;

```
 ![rental.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson3/images/rental.JPG)
 

---

### Задание 4

Одним запросом получите активных покупателей, имена которых Kelly или Willie. 

Сформируйте вывод в результат таким образом:
- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
- замените буквы 'll' в именах на 'pp'.

---

**Выполнение задания 4.**

Определим  имена колонок в таблице **'customer'**

```
SELECT COLUMN_NAME  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'sakila' AND TABLE_NAME = 'customer';
```

Получим список активных покупателей, имена которых Kelly или Willie. 

```
SELECT first_name,last_name  FROM sakila.customer WHERE active = 1 AND first_name IN ('Kelly','Willie') ORDER BY first_name ASC;
```

Переводим все буквы в фамилии и имени из верхнего регистра  в нижний регистр.

**LOWER** - преобразует все символы указанной строки в строчные

```
SELECT LOWER(first_name),LOWER(last_name)  FROM sakila.customer WHERE active = 1 AND first_name IN ('Kelly','Willie') ORDER BY first_name ASC;
```

Заменим буквы 'll' в именах на 'pp', применим **REPLACE** для замены символов в строк

```
SELECT LOWER(REPLACE(first_name,'LL','PP')),LOWER(last_name)  FROM sakila.customer WHERE active = 1 AND first_name IN ('Kelly','Willie'
) ORDER
```

![REPLACE_LOWER.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson3/images/REPLACE_LOWER.JPG)


---

### Задание 5*

Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.

---

**Выполнение задания 5***

Определим в таблице количество строк *count*

```
SELECT count(*) FROM sakila.customer;
```

Применяем SUBSTRING_INDEX - он вырезает из строки подстроку с заданым  разделителем (delimiter).

```
SELECT SUBSTRING_INDEX(email,'@',1) AS Name ,SUBSTRING_INDEX(email,'@',-1) AS Domaine FROM sakila.customer  ORDER BY first_name ASC LIMIT 15;
```



 ![email.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson3/images/email.JPG)


### Задание 6*

Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные — строчными.


---

**Выполнение задания 6***

Применяем **SUBSTRING_INDEX **- он вырезает из строки подстроку с заданым  разделителем (delimiter) **'@'** с начальной позиции '1' , если указать '-1' то с конца строки.
**LEFT - вырезает с начала строки определенное количество символов, в данном случае - 1, заглавную букву.
**CONCAT** -  объединяет строки.
**UCASE**  - преобразует все символы в верхний регистр
**LOWER** - преобразует все символы в строчные.
**LIMIT 15** - вывести 15 строк из всей таблицы.


Общий вид запроса выглядит так:

```
SELECT 
CONCAT(UCASE(LEFT(SUBSTRING_INDEX(email,'@',1),1)), LOWER(SUBSTRING(SUBSTRING_INDEX(email,'@',1),2)) ) AS Name, 
CONCAT(UCASE(LEFT(SUBSTRING_INDEX(email,'@',-1),1)), LOWER(SUBSTRING(SUBSTRING_INDEX(email,'@',-1),2)) ) AS Domaine 
FROM sakila.customer 
ORDER BY first_name ASC LIMIT 15;
```

![SUBSTRING_INDEX.JPG](https://github.com/elekpow/netology/blob/main/reldb/lesson3/images/SUBSTRING_INDEX.JPG)

