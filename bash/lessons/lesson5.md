# Домашнее задание к занятию "Разбор скриптов и и их написание"


### Задание 1.


Дан скрипт:

```bash
#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"

[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
fi

for SUBNET in {1..255}
do
	for HOST in {1..255}
	do
		echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
		arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
	done
done
```


Измените скрипт так, чтобы:

- для ввода пользователем были доступны все параметры. Помимо существующих PREFIX и INTERFACE, сделайте возможность задавать пользователю SUBNET и HOST;
- скрипт должен работать корректно в случае передачи туда только PREFIX и INTERFACE
- скрипт должен сканировать только одну подсеть, если переданы параметры PREFIX, INTERFACE и SUBNET
- скрипт должен сканировать только один IP-адрес, если переданы PREFIX, INTERFACE, SUBNET и HOST
- не забывайте проверять вводимые пользователем параметры с помощью регулярных выражений и знака `~=` в условных операторах 
- проверьте, что скрипт запускается с повышенными привилегиями и сообщите пользователю, если скрипт запускается без них

---

**Выполнение задания 1.**


Скрипт 1 [homeworks_script.sh](https://github.com/elekpow/netology/blob/main/bash/scripts/homeworks_script.sh)



![img16.jpg](https://github.com/elekpow/netology/blob/main/bash/images/img16.jpg)


![img17.jpg](https://github.com/elekpow/netology/blob/main/bash/images/img17.jpg)


```
#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"
trap 'echo "Ping exit (Ctrl+C)"; exit 1' 2

[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
fi
#----------------------------------------
if [[ "$EUID" -ne 0 ]];  then echo "This script must be run as root"
  exit 1
fi

#-----------------------------------------
A=$(echo "${PREFIX}" |cut -f1 -d '.')
B=$(echo "${PREFIX}" |cut -f2 -d '.')
C=$(echo "${PREFIX}" |cut -f3 -d '.')
D=$(echo "${PREFIX}" |cut -f4 -d '.')

if [[ $A =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]] ; then 
        echo ""
else
        echo "Network error: "  "$PREFIX"
        exit 1
fi

if [[ $B =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]] ; then 
        echo ""
else
        echo "Network error: "  "$PREFIX"
        exit 1
fi

if  [[ $D  =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        if  [[ $C  =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
                echo "[*] IP : ${PREFIX}"
                arping -c 3 -i "$INTERFACE" "${PREFIX}" 2> /dev/null
        else
                echo "ping  error: "  "$PREFIX"
        fi
elif [[ $D = *[!\ ]* ]]; then
        echo "Host error: \"($D)\" "  "$PREFIX"
else
        if  [[ $C  =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
                for HOST in {1..255}
                do
                        echo "[*] IP : ${PREFIX}.${HOST}"
                        arping -c 3 -i "$INTERFACE" "${PREFIX}.${HOST}" 2> /dev/null
                done

        elif [[ $C = *[!\ ]* ]]; then
                echo "Subnet error:1 \"($C)\"  " "$PREFIX"
        else
                if  [[ $B  =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
                        echo "ping:" "$PREFIX" "SUBNET" "HOST"
                        for SUBNET in {1..255}
                        do
                                for HOST in {1..255}
                                do
                                        echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
                                        arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
                                done
                        done
                else
                        echo "Prefix error: \"($B)\"  " "$PREFIX"
                fi
        fi
fi

```


------

### Задание 2.

Измените скрипт из Задания 1 так, чтобы:

- единственным параметром для ввода остался сетевой интерфейс;
- определите подсеть и маску с помощью утилиты `ip a` или `ifconfig`
- сканируйте с помощью arping адреса только в этой подсети
- не забывайте проверять в начале работы скрипта, что введенный интерфейс существует 
- воспользуйтесь shellcheck для улучшения качества своего кода

---

**Выполнение задания 2*.**


Скрипт 2 [homeworks_script_nt.sh](https://github.com/elekpow/netology/blob/main/bash/scripts/homeworks_script_nt.sh)



![img18.jpg](https://github.com/elekpow/netology/blob/main/bash/images/img18.jpg)

```
#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"

if [[ -z "$INTERFACE" ]]; then
 INTERFACE="$1"
 PREFIX="$2"

 addr=`ip a | grep "$INTERFACE" |grep inet | awk '/inet/  {print $2}' | cut  -f1 -d '/'`
 PREFIX=$(echo $addr | cut -f1,2,3 -d '.')

else
 PREFIX="${1:-NOT_SET}"
 INTERFACE="$2"
fi

trap 'echo "Ping exit (Ctrl+C)"; exit 1' 2

#----------------------------------------
if [[ "$EUID" -ne 0 ]];  then echo "This script must be run as root"
  exit 1
fi

#-----------------------------------------
A=$(echo "${PREFIX}" |cut -f1 -d '.')
B=$(echo "${PREFIX}" |cut -f2 -d '.')
C=$(echo "${PREFIX}" |cut -f3 -d '.')
D=$(echo "${PREFIX}" |cut -f4 -d '.')

if [[ $A =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]] ; then 
        echo ""
else
        echo "Network error: "  "$PREFIX"
        exit 1
fi

if [[ $B =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]] ; then 
        echo ""
else
        echo "Network error: "  "$PREFIX"
        exit 1
fi

if  [[ $D  =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        if  [[ $C  =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
                echo "[*] IP : ${PREFIX}"
                arping -c 3 -i "$INTERFACE" "${PREFIX}" 2> /dev/null
        else
                echo "ping  error: "  "$PREFIX"
        fi
elif [[ $D = *[!\ ]* ]]; then
        echo "Host error: \"($D)\" "  "$PREFIX"
else
        if  [[ $C  =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
                for HOST in {1..255}
                do
                        echo "[*] IP : ${PREFIX}.${HOST}"
                        arping -c 3 -i "$INTERFACE" "${PREFIX}.${HOST}" 2> /dev/null
                done

        elif [[ $C = *[!\ ]* ]]; then
                echo "Subnet error:1 \"($C)\"  " "$PREFIX"
        else
                if  [[ $B  =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
                        echo "ping:" "$PREFIX" "SUBNET" "HOST"
                        for SUBNET in {1..255}
                        do
                                for HOST in {1..255}
                                do
                                        echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
                                        arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
                                done
                        done
                else
                        echo "Prefix error: \"($B)\"  " "$PREFIX"
                fi
        fi
fi



```

------

