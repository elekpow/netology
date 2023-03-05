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
set -- "$PREFIX" 
IFS="."; declare -a Array=($*)

A="${Array[0]}"
B="${Array[1]}"
C="${Array[2]}"
D="${Array[3]}"

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
