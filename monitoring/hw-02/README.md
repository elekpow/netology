# �������� ������� � ������� "������� ����������� Zabbix" - ����� �����

---

### ������� 1

���������� Zabbix Server � ���-�����������.

������� ����������
  1. �������� �� ���������� � ��������� ��������� � ������ ������.
  2. ���������� PostgreSQL. ��� ��������� ���������� �� ������ ��� ���� � ��������� ������������ Debian 11
  3. ��������� �������������� ������� � ������������ �����, ��������� ����� ������ ��� ��������� ��������� ������ Zabbix � ���������� PostgreSQL � Apache
  4. ��������� ��� ����������� ������� ��� ��������� Zabbix Server � Zabbix Web Server

***���������� � ����������***

���������� � ���� README.md �������� ����������� � �������
��������� � ���� README.md ����� �������������� ������ � GitHub


---

### ���������� ������� 
  
����������� ������ ���������� � Yandex Cloud  
  
 ----------------------------------------
 
 ��������� ������� 
  
 ![screen1](https://github.com/elekpow/hw-02/blob/main/zabbix.JPG)  
 
 ����������� � �������
 
 
 ![screen1](https://github.com/elekpow/hw-02/blob/main/zabbix_login.JPG)  
  
 
 
 git add .     
 git commit -m "Readme.md"    
 git push   
 
 git status
 
 git add .     
 git commit -m "Update Readme"    
 git push  
 
   
  
  
---

### ������� 2

���������� Zabbix Agent �� ��� �����.

***������� ����������***

 1. �������� �� ���������� � ��������� ��������� � ������ ������.
 2. ���������� Zabbix Agent �� 2 ����������, ����� �� ��� ����� ���� ��� Zabbix Server
 3. �������� Zabbix Server � ������ ����������� �������� ����� Zabbix Agent��
 4. �������� Zabbix Agent�� � ������ Configuration > Hosts ������ Zabbix Servera
 5. ��������� ��� � ������� Latest Data ������ ���������� ������ � ����������� �������


---

### ���������� ������� 
  
  
   ���������� ����� �� ���� ����������� ������� (host �  Elvm2)
  
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent.JPG) 
 
  ����������� ������� 
 
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_configiration.JPG)
 
 ������ �����������, ������  ����������� ������ Elvm2
 
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_LatestData_Elvm2.JPG)
  
   
  
  
---

### ������� 3 �� ���������*

���������� Zabbix Agent �� Windows (���������) � ���������� ��� � ������� Zabbix.

***���������� � ����������***

��������� � ���� README.md �������� ������� Latest Data, ��� ����� ��������� ����� �� ����� C:

---

### ���������� �������   


1) Zabbix ������ ��������� �� ����������� ������. ����� ��� �� Windows ���������� �� ��������� ����������, � ���������� ������ ���� 10050 � � ����� ���������� ��� ���������� Zabbix Agent

 ![screen1](https://github.com/elekpow/hw-02/blob/main/FW_Windows.JPG)

2) ��� ���� ��� �� ��������  ������ �� ��� ��������� "����� ip" ��� �� ������ � ������� ��������� DDNS
����� ������ ����������, �������� no-ip.com  , ����� ���� , "��� �����" � ������� ��������  ������ ������ ������ �� ����� 10050

3) ����� ������ � ���������� �� ��������� �����  ���������, telnet int93302.hopto.org 10050
���� ������.  

 ![screen1](https://github.com/elekpow/hw-02/blob/main/telnet.JPG)


������ ������������

 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_windows.JPG)
 
���������� ���������� ��������  
 
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_windows_monitor.JPG)
  
 ![screen1](https://github.com/elekpow/hw-02/blob/main/Zabbix_Agent_windows_problem.JPG)

�� ��������� ���������� � Windows �� ����� C: ������ ����� 90% �����.





