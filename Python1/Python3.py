"""
Заработную плату в месяц.
Какой процент(%) от зп уходит на ипотеку.
Какой процент(%) от зп уходит "на жизнь".
Программа подсчитывает и выводит, сколько денег тратит пользователь на ипотеку и сколько он накопит за год (остаток от заработанной платы).

Пример:

Введите заработную плату в месяц: 100000
Введите, какой процент(%) уходит на ипотеку: 30
Введите, какой процент(%) уходит на жизнь: 50

Вывод:
На ипотеку было потрачено: 360000 рублей
Было накоплено: 240000 рублей
"""

def percentage(part, whole):
  percentage = 100 * float(part)/float(whole)
  return str(percentage) + "%"



a = int(input("Введите заработную плату в месяц: "))
b = int(input("Введите, какой процент(%) уходит на ипотеку: "))
c = int(input("Введите, какой процент(%) уходит на жизнь: "))


ipoteka = round( a , 2 )

print(percentage(3, 5))


print("На ипотеку было потрачено: ", ipoteka , " рублей")
print("Было накоплено:  ", percentage(3, 5) , " рублей")
