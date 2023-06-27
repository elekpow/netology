# Домашнее задание к занятию "Переменные и условные операторы" 

------
### Задание 1.

Напишите скрипт, который при запуске спрашивает у пользователя путь до директории и создает ее при условии, что ее еще не существует. 

Если директория существует – пользователю выводится сообщение, что директория существует.

Скрипт должен принимать абсолютный путь до директории, например `/tmp/testdir` или `/home/user/testdir`

---

**Выполнение задания 1.**

```
#!/bin/bash
NEWDIR=/home/levin/newdir
echo "Working dir is "$NEWDIR""
if [[ -d $NEWDIR ]]; then
        echo "Directory found !"
elif [[ ! -d $NEWDIR ]]; then
        mkdir $NEWDIR
        echo "Directory created !"
fi

```


![img1.jpg](https://github.com/elekpow/netology/blob/main/bash/images/img1.jpg)




------
### Задание 2.

Напишите скрипт:
1. При запуске скрипта пользователь вводит два числа.
2. Необходимо вычесть из большего числа меньшее и вывести результат в консоль.
3. Если числа равны – умножить их друг на друга (или возвести в квадрат одно из чисел) и вывести результат в консоль.

---

**Выполнение задания 2.**


```
 #!/bin/bash
echo -n "первое число: "
read a
echo -n "второе число: "
read b
if [[ "$a" -gt "$b" ]]; then
        let c=$a-$b
        echo $c
elif [[ "$b" -gt "$a" ]]; then
        let c=$b-$a
        echo $c
else
        echo "равенство чисел! умножаем"
        let c=$a*$b
        echo $c
fi


```

![img2.jpg](https://github.com/elekpow/netology/blob/main/bash/images/img2.jpg)





------
### Задание 3.

Напишите скрипт с использованием оператора `case`:
1. При запуске скрипта пользователь вводит в консоль имя файла с расширением, например 123.jpg или track.mp3.
2. Необходимо сообщить пользователю тип файла:
- Если jpg, gif или png – вывести слово «image»
- Если mp3 или wav – вывести слово «audio»
- Если txt или doc – вывести слово «text»
- Если формат не подходит под заданные выше – написать «unknown»

---

**Выполнение задания 3.**

```
echo -n "имя файла с расширением: "
read filename
FILETYPE=${filename: -4}
case $FILETYPE in
    .mp3|.wav)
        echo "Audio";;
    .jpg|.png|.gif)
        echo "image";;
    .txt|.doc)
        echo "text";;
    *)
        echo "unknown";;
esac`

```

![img3.jpg](https://github.com/elekpow/netology/blob/main/bash/images/img3.jpg)


