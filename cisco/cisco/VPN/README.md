vpn (Filial)
----------------------------------
conf terminal

crypto isakmp policy 1
encryption 3des
hash md5
authentication pre-share 
group 2
lifetime 86400
exit
-
crypto isakmp key cisco address 188.144.0.2 #публичный адрес другой сети
-
ip access-list extended VPN
permit ip 192.168.5.0 0.0.0.15 192.168.0.0 0.0.0.15 # внутренняя сеть 
exit
-
crypto ipsec transform-set TS esp-3des esp-md5-hmac
-
crypto map CMAP 10 ipsec-isakmp
set peer 188.144.0.2
set transform-set TS
match address VPN
exit
interface gigabitEthernet 0/0/0
crypto map CMAP
exit
/////////////
ip nat inside source list 100 interface gigabitEthernet 0/0/0 overload
access-list 100 deny ip 192.168.5.0 0.0.0.15 192.168.0.0 0.0.0.15
access-list 100 permit ip 192.168.5.0 0.0.0.15 any


do show crypto map
