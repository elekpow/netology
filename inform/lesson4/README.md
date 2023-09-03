**SIEM** (Security Information and Event Management) — это:

технология, обеспечивающая анализ в реальном времени событий безопасности элементов информационной системы;
процесс, объединяющий активность внутри информационной системы в единый набор данных.
**Основная функция SIEM** заключается в том, чтобы предотвращать и обнаруживать атаки на информационную систему или сеть. Для этого система собирает информацию о событиях безопасности, таких как неудачные попытки входа в систему, подозрительные активности пользователей и другие подобные события.


**Основные задачи, решаемые с помощью SIEM:**
сбор, обработка и анализ событий безопасности в режиме реального времени — логи, трафик;

- обнаружение атак — события, корреляции;

- оценка защищённости ресурсов — данные аудита;

- анализ и управление рисками безопасности (активы);

- проведение расследований инцидентов;

- принятие решений по защите информации;

- **формирование отчётных документов.


**Примеры правил корреляций**
- Обнаружение вредоносного ПО, использующего DNS-туннелирование. Правило анализирует данные из логов DNS-серверов и фаерволов. Если система обнаруживает необычную активность, такую как большое количество запросов к определённому домену или большие по объёму запросы, то это может указывать на использование DNS-туннелирования вредоносным ПО.

- Обнаружение атаки на учётные записи. Если система обнаруживает подозрительную активность, такую как попытки входа в систему с разных IP-адресов с использованием одной учётной записи или попытки входа в систему с неправильными учётными данными, то это может указывать на атаку на учётную запись.


**SOC (Security Operation Center)** — центральный пункт для мониторинга и управления информационной безопасностью организации. SOC обеспечивает сбор, анализ и реагирование на угрозы безопасности, которые могут возникнуть в корпоративных сетях.

В идеале SOC должен решать абсолютно весь спектр задач, связанных с ИБ внутри компании:

- обеспечение безопасности и защиты ценных активов организации;
- мониторинг событий безопасности в реальном времени (SIEM);
- анализ данных для выявления угроз — сканеры безопасности;
- реагирование на инциденты безопасности — forensic tools;
- восстановление после инцидента;
- предоставление отчётности о произошедших событиях.


Существует несколько видов Security Operation Center (SOC), каждый из которых имеет свои особенности и направлен на решение определённых задач.

- In-house SOC — центр безопасности, который находится внутри компании и управляется её собственными безопасниками. Такой SOC может быть создан для обеспечения безопасности конкретной службы или всей организации.
- Co-managed SOC — это SOC, который управляется сторонней компанией. Заказчик сохраняет контроль над операциями безопасности, но обслуживающая компания предоставляет персонал и инфраструктуру для выполнения этих операций.
- Fully-managed SOC — SOC, который полностью управляется сторонней компанией. Заказчик выносит все операции, связанные с ИБ, в такую компанию, которая предоставляет персонал, инструменты и инфраструктуру для выполнения операций по обеспечению кибербезопасности.
- Virtual SOC — SOC, который работает виртуально, без физического центра безопасности. Такой SOC может быть настроен для мониторинга и управления безопасностью в облаке.
- Hybrid SOC — SOC, который комбинирует несколько подходов к безопасности и может включать в себя элементы каждого из вышеуказанных типов SOC.

**DMZ (демилитаризованная зона)** — отдельный сетевой сегмент, в котором размещены сервисы, публикуемые в интернете.


**Задачи, которые решает DMZ:**
- уменьшение трафика внутренней сети, связанного с обработкой запросов из интернета;

- обеспечение безопасности внутренней сети компании путём предоставления только необходимых сервисов в DMZ;

- защита серверов, находящихся в DMZ, от атак из интернета путём использования специальных механизмов безопасности, например, брандмауэров или IDS.


