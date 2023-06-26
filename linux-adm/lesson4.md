# Домашнее задание к занятию "Управление пользователями"

------

### Задание 1.

Создайте пользователя `student1` с оболочкой bash, входящего в группу `student1`.

Создайте пользователя `student2`, входящего в группу `student2`.

*Приведите ответ в виде снимков экрана.*


---

**Выполнение задания 1.**

![img19.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img19.jpg)

---

### Задание 2.

Создайте в общем каталоге (например, /tmp) директорию и назначьте для неё полный доступ со стороны группы `student2` и доступ на чтение всем остальным

*Приведите ответ в виде снимков экрана.*


---

**Выполнение задания 2.**

Создал каталог folder

![img20.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img20.jpg)

![img21.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img21.jpg)

`chown - владелец  student2 ,  chmod -  для всех только чтение`

![img22.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img22.jpg)

![img23.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img23.jpg)


---

### Задание 3.

Какой режим доступа установлен для файлов `/etc/passwd` и `/etc/shadow`?

Объясните, зачем понадобилось именно два файла?

*Приведите ответ в свободной форме.*


---

**Выполнение задания 3.**

![img24.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img24.jpg)

* Для файла **passwd** установлен доступ для владельца root - чтение и запись в файл, для группы **root** в которую входит root -чтение, а для всех остальных только чтение.
* Для файла **shadow** установлен доступ для владельца root - чтение и запись в файл, для группы **root** в которую входит root -чтение, а для всех остальных ничего.
* Файл **passwd**  -  этот файл содержит в текстовом формате список пользовательских учётных записей, а файл **shadow** содержит шифрованные пароли учётных записей пользователей.



---

### Задание 4.

Удалите группу `student2`, а пользователя `student2` добавьте в группу `student1`.

*Приведите ответ в виде снимков экрана.*


---

**Выполнение задания 4.**


![img25.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img25.jpg)



### Задание 5*.

Создайте в общем каталоге (например, /tmp) директорию и назначьте для неё полный доступ для всех, кроме группы `student1`.  Группа `student1` не должна иметь доступа к содержимому этого каталога.

*Приведите ответ в виде снимков экрана.*

---

**Выполнение задания 5*.**

* Чтобы запретить доступ к каталогу определенной группе нужны более расширенные права доступа через **ACL (Access control lists)**.

Создаю каталог **myfolder**

![img26.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img26.jpg)


* для всех пользователей даю полные права 


![img27.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img27.jpg)


* Проверяем что настроено в данный момент через **getfacl**


![img28.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img28.jpg)


и добавляем группу **student1**, задаем права через без права чтения и запиcи

   ` setfacl -m g:student1:x  myfolder`

![img29.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img29.jpg)

* по идее можно вообще без прав **(setfacl -m g:student1:-  myfolder) **

* Теперь пользователь принадлежащий группе student1  не может получить доступ, для всех остальных пользователей полный доступ.

![img30.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img30.jpg)

* проверяем через другого пользователя -  test ,  доступ имеется


![img31.JPG](https://github.com/elekpow/netology/blob/main/linux-adm/images/img31.jpg)






---

