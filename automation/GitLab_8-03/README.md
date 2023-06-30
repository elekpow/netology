# Домашнее задание к занятию «GitLab» - Игорь Левин


---

### Задание 1

**Что нужно сделать:**

1. Разверните GitLab локально, используя Vagrantfile и инструкцию, описанные в [этом репозитории](https://github.com/netology-code/sdvps-materials/tree/main/gitlab).   
2. Создайте новый проект и пустой репозиторий в нём.
3. Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker. Раннер можно регистрировать и запускать на той же виртуальной машине, на которой запущен GitLab.

В качестве ответа в репозиторий шаблона с решением добавьте скриншоты с настройками раннера в проекте.

---

**Выполнение задания:**


Локальный GitLab

![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/GitLab_local.png)

Создание проекта в локальном GitLab

![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/GitLab_newpoject.png)


Проект My_Project в локальном GitLab

![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/GitLab_newpoject_1.png)

Настройки раннера в проекте.

![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/Config_runner.png)



---

### Задание 2

**Что нужно сделать:**

1. Запушьте [репозиторий](https://github.com/netology-code/sdvps-materials/tree/main/gitlab) на GitLab, изменив origin. Это изучалось на занятии по Git.
2. Создайте .gitlab-ci.yml, описав в нём все необходимые, на ваш взгляд, этапы.

В качестве ответа в шаблон с решением добавьте: 
   
 * файл gitlab-ci.yml для своего проекта или вставьте код в соответствующее поле в шаблоне; 
 * скриншоты с успешно собранными сборками.
 
---

**Выполнение задания:**

Pipeline

```

stages:
  - test
  - build

test:
  stage: test
  image: golang:1.17
  script:
   - go test .

static-analysis:
 stage: test
 image:
  name: sonarsource/sonar-scanner-cli
  entrypoint: [""]
 variables:
 script:
  - sonar-scanner -Dsonar.projectKey=gitproject -Dsonar.sources=. -Dsonar.host.url=http://gitlab.localdomain:9000 -Dsonar.login=sqp_c9ffd46d29e000ac6fbd79b194cdb9296ef56fc7



build:
  stage: build
  image: docker:latest
  script:
   - docker build .

```

Выполненый pipline

![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/Pipelines.png)

Sonar-scanner

![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/pipline_sonarscaner.png)

SonarQube

![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/Sonarqube.png)


```
stages:
  - test
  - build

test:
  stage: test
  image: golang:1.16
  script: 
   - go test .

sonarqube-check:
 stage: test
 image:
  name: sonarsource/sonar-scanner-cli
  entrypoint: [""]
 variables:
 script:
  - sonar-scanner -Dsonar.projectKey=gitproject -Dsonar.sources=. -Dsonar.host.url=http://gitlab.localdomain:9000 -Dsonar.login=sqp_c9ffd46d29e000ac6fbd79b194cdb9296ef56fc7

build:
  stage: build
  image: docker:latest
  only:
    - master
  script:
   - docker build .

build:
  stage: build
  image: docker:latest
  when: manual
  except:
    - master
  script:
   - docker build .

```


Pipeline with manual run

![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/Pipeline_manual_run.png)


![screen1](https://github.com/elekpow/GitLab_8-03/blob/main/Pipeline_manual_jobs.png)

