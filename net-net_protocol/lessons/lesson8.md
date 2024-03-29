 # Домашнее задание к занятию "4.7 Высокоуровневые протоколы"

------

### Задание 1.

Какие порты используются протоколами:
- Telnet;
- SSH;
- FTP;
- SNMP;

* Приведите ответ в виде списка портов.
--- 

**Выполнение задания: Задание 1.**

* выведем данные из файла `/etc/services`, с помощью *grep* выбираем только нужные протоколы, и применим регулярные выражения для фильтрации результата.
```
grep -E "^ssh|^telnet\b|^ftp\s|^snmp\s" /etc/services
```

**В результате получаем:**

**ftp** использует **21 порт (tcp)**, 
**ssh** использует  **22 порт (tcp)**,
**telnet**  использует **23 порт (tcp)**,
**snmp**  использует **161 порт (tcp или udp)** 

* Из описания:

> SNMP работает на прикладном уровне TCP/IP (седьмой уровень модели OSI). Агент SNMP получает запросы по UDP-порту 161, 
> Ответ агента будет отправлен назад на порт источника на менеджере. Менеджер получает уведомления (Traps и InformRequests) по порту 162.

----------

Тогда  `grep -E "^snmp" /etc/services` 

**snmp** - **161 (tcp)**, **161 (udp)**
**snmp-trap** - **162 (tcp)**, **162 (udp)**




------

### Задание 2.

Какой по счету уровень модели OSI называется прикладным (`application layer`)?

*Зашифруйте ответ с помощью ключа: {5, 21}.*

--- 

**Выполнение задания: Задание 2.**

```
-----------------------------
ключ:  {5, 21}
------------------------------
n = p * q = 105.
F= (p-1) * (q-1)  = 80
e= 11
-------------------------------

открытый ключ{e, n} = {11, 105}
вычислим d из формулы “(d * е) mod F =1” / d = 51
закрытый ключ {d, n}={51, 105}

----------------------------------
m - текст для шифрования  (число 7)
----------------------------------

(m^e) mod n = c

шифруем  (7 ^ 11) mod 105 = 52

(c^d) mod n = m

расшифруем  (52 ^ 51) mod 105 = 7

```





------

### Задание 3.

Создайте свой корневой сертификат, добавьте его в систему. 

Затем подпишите им свой сертификат.

**1. Генерируем ключ**

```
- openssl genrsa -out ca.key 2048
```

**2. Генерируем корневой сертификат. Поля в сертификате указываем любые.**

```
- openssl req -x509 -new -nodes -key ca.key -sha256 -days 720 -out ca.pem
```

**3. Сразу же сделаем сертификат в форме `crt`**

```
- openssl x509 -in ca.pem -inform PEM -out ca.crt
```

**4. Далее установим сертификат в систему. Ниже пример для `Ubuntu`/`Debian` систем**

```
- sudo cp ca.crt /usr/local/share/ca-certificates/myca.crt && sudo update-ca-certificates
```

**5. Приступим к выпуску самого сертификата:**

**5.1. Генерируем ключи**

```
- openssl genrsa -out certificate.key 2048
```

**5.2. На основе ключа создаем `CSR`**

*Обратите внимание, что subject конечного сертификата __не должен__ совпадать с subject корневого. Хотя бы в одном поле нужно указать отличающееся значение, например в common Name или email. В противном случае конечный сертификат не будет верифицироваться, поскольку будет считаться самоподписным.*

```
- openssl req -new -key certificate.key -out certificate.csr
```

**5.3. Подписываем `CSR` нашим корневым сертификатом. Тем самым создаем конечный сертификат.**

```
- openssl x509 -req -in certificate.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out certificate.crt -days 360 -sha256
```

**6. Проверяем валидность сертификата**

*Эта проверка должна вернуть `OK`. Если вы видите `failed`, значит, где-то допущена ошибка.*

```
- openssl verify certificate.crt
```


*В качестве ответа приложите снимки экрана с выводом информации о сертификатах и результатом верификации:*
```
openssl x509 -subject -issuer -noout -in ca.pem
openssl x509 -subject -issuer -noout -in certificate.crt
openssl verify certificate.crt
```
--- 
**Выполнение задания: Задание 3.**



![img1.jpg](https://github.com/elekpow/netology/blob/main/net-net_protocol/images/img1.jpg)
------
