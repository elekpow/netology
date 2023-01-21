<h3>vpn (Filial)</h3>
----------------------------------<br>
<p>conf terminal</p>

<p>crypto isakmp policy 1</p>
<p>encryption 3des</p>
<p>hash md5</p>
<p>authentication pre-share </p>
<p>group 2</p>
<p>lifetime 86400</p>
<p>exit</p>
<p>-</p>
<p>crypto isakmp key cisco address 188.144.0.2 #публичный адрес другой сети</p>
-</p>
<p>ip access-list extended VPN</p>
<p>permit ip 192.168.5.0 0.0.0.15 192.168.0.0 0.0.0.15 # внутренняя сеть </p>
<p>exit</p>
<p>-</p>
<p>crypto ipsec transform-set TS esp-3des esp-md5-hmac</p>
<p>-</p>
<p>crypto map CMAP 10 ipsec-isakmp</p>
<p>set peer 188.144.0.2</p>
<p>set transform-set TS</p>
<p>match address VPN</p>
<p>exit</p>
<p>interface gigabitEthernet 0/0/0</p>
<p>crypto map CMAP</p>
<p>exit</p>
<p>/////////////</p>
<p>ip nat inside source list 100 interface gigabitEthernet 0/0/0 overload</p>
<p>access-list 100 deny ip 192.168.5.0 0.0.0.15 192.168.0.0 0.0.0.15</p>
<p>access-list 100 permit ip 192.168.5.0 0.0.0.15 any</p>
<p></p>

<p>do show crypto map</p>
