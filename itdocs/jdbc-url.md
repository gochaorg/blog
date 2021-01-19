JDBC-URL Форматы ссылок для разныз баз данных
=============================================

[toc]

Для работы с базами данных в JAVA используется собственный [формат строки подключения](https://ru.wikipedia.org/wiki/Java_Database_Connectivity)

MySQL (от mariadb, подходит и для mysql)
----------------------------------------

https://mariadb.com/kb/en/mariadb/about-mariadb-connector-j/

### Синтаксис

<pre>
jdbc:(mysql|mariadb):[replication:|failover:|sequential:|aurora:]//<i>hostDescription</i>[,<i>hostDescription</i>...]/[database][?<i>key1</i>=<i>value1</i>[&<i>key2</i>=<i>value2</i>]]
</pre>

HostDescription:

<pre>
<i>host</i>[:<i>portnumber</i>]
</pre>

<pre>
address=(host=<i>host</i>)[(port=<i>portnumber</i>)][(type=(master|slave))]
</pre>

Хост должен быть DNS-именем или IP-адресом. В случае ipv6 и простого описания хоста IP-адрес должен быть записан внутри скобок. Порт по умолчанию - 3306. Тип по умолчанию - мастер. Если установлен режим восстановления репликации, по умолчанию первый хост является мастером, а остальные - подчиненными.

Примеры:

`localhost:3306`

`[2001:0660:7401:0200:0000:0000:0edf:bdd7]:3306`

`somehost.com:3306`

`address=(host=localhost)(port=3306)(type=master)`

### Параметры отказоустойчивости

* `sequential`
	* Поддержка отказоустойчивости для основного кластера репликации (например, Galera) без высокой доступности. Хосты будут подключены в том порядке, в котором они были объявлены. <br>
	Пример использования строки jdbc url `jdbc: mysql: replication: host1, host2, host3 / testdb`: <br>
	При подключении драйвер всегда будет сначала попробовать host1, а если недоступен host2 и т.д.
	<br>
	После отказа хоста драйвер будет подключаться в соответствии с этим заказом.
	<br>
	Этот метод отказоустойчивости не поддерживает чтение балансировки нагрузки на ведомых устройствах.
	<br>
	Первый доступный хост используется для всех запросов.
* `failover` Высокая доступность (инициализация случайного выбора соединения) с поддержкой отказоустойчивости для основного кластера репликации (например, Galera).
* `replication` Высокая доступность (инициализация случайного выбора соединения) с поддержкой отказоустойчивости кластера репликации master / slave (один или несколько мастеров)
* `aurora` Высокая доступность (инициализация случайного выбора соединения) с поддержкой отказоустойчивости для кластера репликации Amazon Aurora

### Дополнительные параметры URL

* `user`
	* Database user name.
* `password`
	* Password of database user.
* `rewriteBatchedStatements`
	* Для запросов вставки перезапустите batchedStatement для выполнения в одном executeQuery.
пример: <pre>
insert into ab (i) values (?) with first batch values = 1, second = 2 will be rewritten
insert into ab (i) values (1), (2).
</pre> Если запрос не может быть перезаписан в «multi-values», rewrite будет использовать несколько запросов:<pre>
INSERT INTO TABLE(col1) VALUES (?) ON DUPLICATE KEY UPDATE col2=? with values [1,2] and [2,3]" will be rewritten
INSERT INTO TABLE(col1) VALUES (1) ON DUPLICATE KEY UPDATE col2=2;INSERT INTO TABLE(col1) VALUES (3) ON DUPLICATE KEY UPDATE col2=4
</pre>
	* при активном параметре useServerPrepStmts устанавливается значение false
	* Default: false
* `connectTimeout`
	* Значение таймаута соединения в миллисекундах или ноль без тайм-аута.
	* Default: 0
* `useServerPrepStmts`
	* Default: false (was true before 1.6.0). Since 1.3.0
* `useBatchMultiSend`
	* Default: true (false if using aurora failover)

### TLS (SSL)

### Pool

### Log

### Нечасто используется

### Параметры URL-адреса отказоустойчивости / высокой доступности

MSSQL (JTDS)
---------------------