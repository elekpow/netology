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
