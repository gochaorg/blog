CASE 1 - Использование SNAPSHOT
===============================

- Получить учетки
- Установить maven
- Настроить settings.xml
- Настроить pom.xml
- Проверить обновление

Получить учетки и первоначальные устновки
-----------------------------------------

- логин
- пароль
- имя репозитория
- адрес репозитрия
- политики обновления репозиториев

Установить maven
----------------

1. [Инструкция по установке](maven-install.md)

Настроить settings.xml
----------------------

### Добавить профиь активируемый по умолчанию

```xml
<settings>
    ...
    <profiles>
        ...
        <profile>
            <id>profile-id-1</id>
            ...
        </profile>
        ...
    </profile>
    <activeProfiles>
        <activeProfile>profile-id-1</activeProfile>
  </activeProfiles>
</settings>
```

### Добавить удаленные репозитории

```xml
<settings>
    ...
    <profiles>
        ...
        <profile>
            <id>profile-id-1</id>
            ...
            <repositories>
                <repository>
                    <snapshots>
                        <enabled>false</enabled>
                    </snapshots>
                    <id>server_id1</id>
                    <name>libs-release</name>
                    <url>http://адрес реаозитория</url>
                </repository>
                <repository>
                    <snapshots />
                    <id>server_id2</id>
                    <name>libs-snapshot</name>
                    <url>http://адрес реаозитория</url>
                </repository>
            </repositories>
        </profile>
        ...
    </profiles>
</settings>
```

- имена (name) репозиториев могут быть любые
- идентификаторы (id) используются во всей конфигурации проекта 
  и должны быть уникальные, в пределах локальной машины / сессии maven

### Указать для репозиториев политику обновления

```xml
<repository>
  <id>server_id1</id>
  <name>30cac1e766b6-releases</name>
  <url>http://localhost:8081/artifactory/repo1</url>
  <releases>
    <enabled>true</enabled>
    <!--
    updatePolicy 	String

    The frequency for downloading updates - 
    can be 
      "always", 
      "daily" (default), 
      "interval:XXX" (in minutes) or 
      "never" (only if it doesn't exist locally).
    -->
    <updatePolicy>interval:10</updatePolicy>
  </releases>
  <snapshots>
    <enabled>true</enabled>
    <updatePolicy>always</updatePolicy>
  </snapshots>
</repository>
```

Добавить/указать значение в секциях 
`repository/releases/updatePolicy` и `repository/snapshots/updatePolicy`

Возможные значения:

- `always` - Обновлять всегда , т.е. всегда запрос на сервер при каждом запуске maven
- `daily` - Ежедневно обновлять, _значение по умолчанию_
- `interval:XXX` - Обновлять каждые XXX секунд
- `never` - Никогда не обновлять

### Добавить логин/пароль для сервера

```xml
<settings>
  ...
  <servers>
    ...
    <server>
      <username>login</username>
      <password>password</password>
      <id>server_id1</id>
    </server>
    <server>
      <username>login</username>
      <password>password</password>
      <id>server_id2</id>
    </server>
    ...
  </servers>
  ...
</settings>
```

Настроить pom.xml
------------------

В корневом проекте (pom.xml) или настройках профиля (settings.xml/servers/profiles/profile) 
указать репозитории в которые будет производиться deploy

```xml
<project>
  ...
  <distributionManagement>
    <repository>
      <id>server_id1</id>
      <name>30cac1e766b6-releases</name>
      <url>http://localhost:8081/artifactory/repo1</url>
    </repository>
    <snapshotRepository>
      <id>server_id2</id>
      <name>30cac1e766b6-snapshots</name>
      <url>http://localhost:8081/artifactory/repo1</url>
    </snapshotRepository>
  </distributionManagement>
  ...
</project>
```

Запуск проекта с автоматическим обновлением зависимостей
--------------------------------------------------------

Для запуска проекта с автоматическим обновлением зависимостей необходимо

- Добавить в pom.xml
- Проверить политику обновления репозиториев, см выше `repository/releases/updatePolicy` и `repository/snapshots/updatePolicy`
- Запустить проект `mvn exec:java`

### Добавить в pom.xml

```xml
<project>
  ...
  <build>
    ...
    <plugins>
      ...
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>exec-maven-plugin</artifactId>
        <version>3.0.0</version>
        <executions>
          <execution>
            <goals>
              <goal>java</goal>
            </goals>
          </execution>
        </executions>
        <configuration>
          <mainClass>org.example.Main</mainClass>
          <arguments>
            <argument>argument1</argument>
            <argument>argument2</argument>
            <argument>argument3</argument>
          </arguments>
          <systemProperties>
            <systemProperty>
              <key>myproperty</key>
              <value>myvalue</value>
            </systemProperty>
          </systemProperties>
        </configuration>
      </plugin>
      ...
    </plugins>
    ...
  </build>
  ...
</project>
```

Либо

```xml
<groupId>org.codehaus.mojo</groupId>
<artifactId>exec-maven-plugin</artifactId>
<version>1.3.2</version>
<executions>
  <execution>
    <goals>
      <goal>exec</goal>
    </goals>
  </execution>
</executions>
<configuration> 
  <executable>java</executable>
  <arguments>
    <argument>-classpath</argument> 
    <classpath />
    <argument>com.package.MyMainClass</argument>  
  </arguments>
  <workingDirectory>${project.build.outputDirectory}</workingDirectory>           
</configuration>
```

тогда запуск `mvn exec:exec`

### Форсирование обновления

для форсирования обновления использовать опцию `-U` в команде `mvn`

пример:

`mvn -U exec:java`


Дополнительные ссылки
-------------------------

- 1 тут дополнительная ссылка