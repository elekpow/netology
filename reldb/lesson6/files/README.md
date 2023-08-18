
Менеджер ключей для SSH.
```
eval "$(ssh-agent -s)" 
ssh-add ~/.ssh/id_rsa

```
---

```
sudo docker exec -it replication-master sh 
sudo docker exec -it replication-slave sh 
```

---

```
sudo docker exec -it replication-slave mysql -uroot -p
sudo docker exec -it replication-master mysql -u root -p
```
---

https://losst.pro/oshibka-your-password-does-not-satisfy-the-current-policy-requirements-mysql


https://jeka.by/post/1069/mysql-outside-access/


