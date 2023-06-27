# Домашнее задание к занятию «Kubernetes. Часть 1»

---

### Задание 1

**Выполните действия:**

1. Запустите Kubernetes локально, используя k3s или minikube на свой выбор.
1. Добейтесь стабильной работы всех системных контейнеров.
2. В качестве ответа пришлите скриншот результата выполнения команды kubectl get po -n kube-system.
---


**Выполнение  задания 1**

* k3s

![img43.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img43.jpg)


------

### Задание 2


Есть файл с деплоем:

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: master
        image: bitnami/redis
        env:
         - name: REDIS_PASSWORD
           value: password123
        ports:
        - containerPort: 6379
```

------
**Выполните действия:**

1. Измените файл с учётом условий:

 * redis должен запускаться без пароля;
 * создайте Service, который будет направлять трафик на этот Deployment;
 * версия образа redis должна быть зафиксирована на 6.0.13.

2. Запустите Deployment в своём кластере и добейтесь его стабильной работы.
3. В качестве решения пришлите получившийся файл.

---

**Выполнение  задания 2**


* Для начала  проверяем работает ли  **redis **

* Выводим имя контейнера `kubectl get pods`

* Подключаемся к контейнеру `kubectl exec -it redis-6bc444b5c6-j9z4f bash`

* пробуем войти в **Redis** с терминала `redis-cli, AUTH password123`

![img44.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img44.jpg)

```
    redis без пароля -  меняем параметры :
       env:
         - name: ALLOW_EMPTY_PASSWORD
           value: "yes"
```

![img45.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img45.jpg)


```
--
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: master
        image: bitnami/redis:6.0.13
        env:
         - name: ALLOW_EMPTY_PASSWORD
           value: "yes"
        ports:
        - containerPort: 6379

```

```
---
apiVersion: v1
kind: Service
metadata:
  name: redis
spec:
  selector:
    app: redis
  ports:
    - protocol: TCP
      port: 6379
      targetPort: 6379
```

**Запущенный сервис**

![img46.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img46.jpg)


------


### Задание 3

**Выполните действия:**

1. Напишите команды kubectl для контейнера из предыдущего задания:

 - выполнения команды ps aux внутри контейнера;
 - просмотра логов контейнера за последние 5 минут;
 - удаления контейнера;
 - проброса порта локальной машины в контейнер для отладки.

2. В качестве решения пришлите получившиеся команды.

---

**Выполнение  задания 3**


```
kubectl exec -it redis-58c6d4947b-zvlf9 -- ps aux
kubectl logs --since=5m redis-58c6d4947b-zvlf9
kubectl delete -f redis.yaml && kubectl delete -f redis-serv.yaml 
kubectl port-forward pod/redis-58c6d4947b-zvlf9 53333:6379
```


![img47.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img47.jpg)

![img48.jpg](https://github.com/elekpow/netology/blob/main/virtual/images/img48.jpg)


