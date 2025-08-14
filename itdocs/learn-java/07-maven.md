# 📘 **Обновлённый полный практический план по изучению Apache Maven**  
*Согласованный, пошаговый, с контролируемыми результатами и каверзными вопросами*

---

## 🔧 **Требования к окружению**
- Java 11+
- Maven 3.8+
- Git
- GPG (`gpg --version`)
- Локальный репозиторий (Nexus OSS / Artifactory OSS — опционально)
- Доступ к GitHub / GitLab (для пакетных репозиториев)

---

## 📌 **Принципы плана**
1. Каждая тема **опирается на результаты предыдущих**
2. Все задания имеют **точные инструкции** и **контролируемый результат**
3. Каверзные вопросы проверяют **глубокое понимание**
4. Примеры решений включают **рабочие команды и конфиги**
5. Финальная проверка объединяет все навыки

---

# 🚀 **Полный план**

---

## **1. Основы: Жизненный цикл и простой проект**

### ✅ **Задача**  
Создать проект, реализовать `main()`, выполнить:  
`mvn compile → test → package → install`

### 🛠 **Пример решения**  
```bash
mvn archetype:generate \
  -DgroupId=org.example \
  -DartifactId=basic-app \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false
```

`src/main/java/org/example/App.java`:
```java
public class App {
    public static void main(String[] args) {
        System.out.println("Maven 101");
    }
}
```

`pom.xml` (добавить):
```xml
<properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
</properties>
```

**Команды**:
```bash
mvn clean compile   # Проверка: target/classes/
mvn test            # Проверка: target/surefire-reports/
mvn package         # Проверка: target/basic-app-1.0-SNAPSHOT.jar
mvn install         # Проверка: ~/.m2/repository/org/example/basic-app/
```

### 🔍 **Контроль**  
- В `target/` есть `.class` файлы
- В `.m2/repository/` установлен артефакт

### ❓ **Каверзные вопросы**  
1. Почему `mvn install` не требует указания версии, но `mvn deploy` — да?  
2. Что произойдет, если удалить `<properties>` с версией Java?  
3. Где хранятся результаты `test` — в `target/` или в папке проекта?

---

## **2. Ресурсы и свойства: Фильтрация и подстановка значений**

### ✅ **Задача**  
Создать конфигурационный файл с подстановкой:
- Версии проекта из `pom.xml`
- Кастомного свойства `build.number`
- Переменной окружения `ENV_NAME`

### 🛠 **Пример решения**  
`src/main/resources/app.properties`:
```properties
app.version=${project.version}
build.number=${build.number}
env=${env.ENV_NAME}
```

`pom.xml`:
```xml
<properties>
    <build.number>1</build.number>
</properties>

<build>
    <resources>
        <resource>
            <directory>src/main/resources</directory>
            <filtering>true</filtering>
        </resource>
    </resources>
</build>
```

**Команды**:  
```bash
ENV_NAME=prod mvn clean process-resources
cat target/classes/app.properties
```

### 🔍 **Контроль**  
- Вывод должен содержать:
  ```
  app.version=1.0-SNAPSHOT
  build.number=1
  env=prod
  ```

### ❓ **Каверзные вопросы**  
1. Почему `${project.version}` работает без `<filtering>` в `<plugin>`?  
2. Что будет, если свойство не определено (например, `${undefined}`)?  
3. Как отключить фильтрацию для конкретного файла?  
4. Почему переменные окружения требуют префикса `env.`?

> 💡 **Подсказка для вопроса 2**:  
> По умолчанию Maven оставит `${undefined}` как есть. Чтобы упасть при отсутствии свойства, добавьте:  
> ```xml
> <plugin>
>     <groupId>org.apache.maven.plugins</groupId>
>     <artifactId>maven-resources-plugin</artifactId>
>     <configuration>
>         <failOnMissingWebXml>false</failOnMissingWebXml>
>         <delimiters>
>             <delimiter>@</delimiter> <!-- Используйте @value@ вместо ${value} -->
>         </delimiters>
>         <useDefaultDelimiters>false</useDefaultDelimiters>
>     </configuration>
> </plugin>
> ```

---

## **3. Множественные проекты: Multi-module архитектура**

### ✅ **Задача**  
Создать проект с модулями:  
- `parent` (POM)  
- `core` (библиотека)  
- `app` (приложение, зависящее от `core`)

### 🛠 **Пример решения**  
**Структура**:
```
multi-module/
├── pom.xml          # Parent
├── core/pom.xml     # Библиотека
└── app/pom.xml      # Приложение
```

`parent/pom.xml`:
```xml
<groupId>org.example</groupId>
<artifactId>multi-module</artifactId>
<version>1.0-SNAPSHOT</version>
<packaging>pom</packaging>

<modules>
    <module>core</module>
    <module>app</module>
</modules>
```

`core/pom.xml`:
```xml
<parent>
    <groupId>org.example</groupId>
    <artifactId>multi-module</artifactId>
    <version>1.0-SNAPSHOT</version>
</parent>
<artifactId>core</artifactId>
```

`app/pom.xml`:
```xml
<dependencies>
    <dependency>
        <groupId>org.example</groupId>
        <artifactId>core</artifactId>
        <version>1.0-SNAPSHOT</version>
    </dependency>
</dependencies>
```

**Команда**:  
```bash
mvn clean install  # Должны собраться оба модуля
```

### 🔍 **Контроль**  
- `app` запускается и использует классы из `core`
- В `.m2/repository` есть артефакты обоих модулей

### ❓ **Каверзные вопросы**  
1. Что будет, если в `app/pom.xml` убрать `<version>` у зависимости?  
2. Почему `core` не нужно явно указывать в `<dependencies>` `parent`?  
3. Как добавить общий плагин для всех модулей?

---

## **4. Артефакты и версии: Деплой и управление версиями**

### ✅ **Задача**  
1. Изменить версию проекта на `1.0.0`  
2. Настроить `distributionManagement` для локального деплоя  
3. Выполнить `mvn deploy`

### 🛠 **Пример решения**  
`parent/pom.xml`:
```xml
<distributionManagement>
    <repository>
        <id>local-release</id>
        <url>file://${user.home}/.m2/local-repo</url>
    </repository>
</distributionManagement>
```

**Команды**:
```bash
mvn versions:set -DnewVersion=1.0.0  # Изменяет версию во всех pom.xml
mvn clean deploy                     # Деплой в local-repo
```

### 🔍 **Контроль**  
- В `~/.m2/local-repo/org/example/...` появился `1.0.0`
- Все `pom.xml` обновлены до `1.0.0`

### ❓ **Каверзные вопросы**  
1. Почему `SNAPSHOT` можно деплоить повторно, а `release` — нет?  
2. Что делает `mvn versions:commit` после `versions:set`?  
3. Как откатить изменения версии без `versions:commit`?

---

## **5. Генерация версии приложения: Интеграция с Git**

### ✅ **Задача**  
Сгенерировать версию вида `1.0.0-git-abc123`:
- Основная версия из `pom.xml`
- Git commit hash
- Признак "dirty" для незакоммиченных изменений

### 🛠 **Пример решения**  
`parent/pom.xml`:
```xml
<build>
    <plugins>
        <plugin>
            <groupId>pl.project13.maven</groupId>
            <artifactId>git-commit-id-plugin</artifactId>
            <version>4.9.10</version>
            <executions>
                <execution>
                    <id>get-the-git-infos</id>
                    <goals><goal>revision</goal></goals>
                </execution>
            </executions>
            <configuration>
                <dotGitDirectory>${project.basedir}/.git</dotGitDirectory>
                <generateGitPropertiesFile>true</generateGitPropertiesFile>
                <includeOnlyProperties>
                    <includeOnlyProperty>^git.commit.id.abbrev$</includeOnlyProperty>
                    <includeOnlyProperty>^git.dirty$</includeOnlyProperty>
                </includeOnlyProperties>
            </configuration>
        </plugin>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <version>3.3.0</version>
            <configuration>
                <archive>
                    <manifestEntries>
                        <Implementation-Version>${project.version}-git-${git.commit.id.abbrev}${git.dirty, '-dirty'}</Implementation-Version>
                    </manifestEntries>
                </archive>
            </configuration>
        </plugin>
    </plugins>
</build>
```

**Команды**:  
```bash
git init
git add .
git commit -m "Initial"
mvn clean package
unzip -p target/app-1.0.0.jar META-INF/MANIFEST.MF | grep Implementation-Version
```

### 🔍 **Контроль**  
- Вывод должен содержать:  
  `Implementation-Version: 1.0.0-git-abc123`  
  или `1.0.0-git-abc123-dirty` для изменённых файлов

### ❓ **Каверзные вопросы**  
1. Почему `${git.dirty, '-dirty'}` не работает без кавычек?  
2. Как добавить дату коммита в версию?  
3. Что будет, если `.git` отсутствует?  
4. Как использовать версию в коде приложения?  
   > ✅ Пример:  
   > ```java
   > String version = App.class.getPackage().getImplementationVersion();
   > ```

---

## **6. Документация: Javadoc и исходники**

### ✅ **Задача**  
Сгенерировать и прикрепить к артефактам:  
- Javadoc в виде JAR  
- Исходники в виде JAR

### 🛠 **Пример решения**  
`parent/pom.xml`:
```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-source-plugin</artifactId>
            <version>3.3.0</version>
            <executions>
                <execution>
                    <id>attach-sources</id>
                    <goals><goal>jar</goal></goals>
                </execution>
            </executions>
        </plugin>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-javadoc-plugin</artifactId>
            <version>3.5.0</version>
            <executions>
                <execution>
                    <id>attach-javadocs</id>
                    <goals><goal>jar</goal></goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

**Команда**:  
```bash
mvn clean install  # Проверка: target/*.jar + *-sources.jar + *-javadoc.jar
```

### 🔍 **Контроль**  
- В `target/` есть 3 артефакта на модуль

### ❓ **Каверзные вопросы**  
1. Почему `javadoc:jar` может упасть, даже если код компилируется?  
2. Как исключить тестовые классы из `sources.jar`?  
3. Что будет, если запустить `mvn deploy` без `source` и `javadoc`?

---

## **7. Документация сайта: Maven Site + Markdown**

### ✅ **Задача**  
Сгенерировать сайт с:  
- Главной страницей на Markdown  
- Отчётом о тестах  
- Ссылкой на Javadoc

### 🛠 **Пример решения**  
`src/site/markdown/index.md`:
```md
# Project Docs

Learn how to use:
```bash
mvn clean install
```
```

`parent/pom.xml`:
```xml
<reporting>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-report-plugin</artifactId>
            <version>3.2.0</version>
        </plugin>
    </plugins>
</reporting>
```

**Команда**:  
```bash
mvn site  # Проверка: target/site/index.html
```

### 🔍 **Контроль**  
- В `target/site/` есть HTML-версия Markdown  
- Есть отчёт `surefire-report.html`

### ❓ **Каверзные вопросы**  
1. Почему `mvn site` не включает Javadoc по умолчанию?  
2. Как добавить кастомный CSS для сайта?  
3. Что произойдет, если `index.md` содержит синтаксис AsciiDoc?

---

## **8. Дополнительные артефакты: Сборка config.zip**

### ✅ **Задача**  
Создать артефакт `config.zip` с файлами из `src/main/config/`

### 🛠 **Пример решения**  
`src/assembly/config.xml`:
```xml
<assembly>
    <id>config</id>
    <formats><format>zip</format></formats>
    <fileSets>
        <fileSet>
            <directory>src/main/config</directory>
            <outputDirectory>/</outputDirectory>
        </fileSet>
    </fileSets>
</assembly>
```

`core/pom.xml`:
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-assembly-plugin</artifactId>
    <version>3.6.0</version>
    <executions>
        <execution>
            <phase>package</phase>
            <goals><goal>single</goal></goals>
            <configuration>
                <descriptors>
                    <descriptor>src/assembly/config.xml</descriptor>
                </descriptors>
            </configuration>
        </execution>
    </executions>
</plugin>
```

**Команда**:  
```bash
mvn package  # Проверка: target/core-1.0.0-config.zip
```

### 🔍 **Контроль**  
- Архив содержит файлы из `src/main/config/`

### ❓ **Каверзные вопросы**  
1. Почему `assembly:single` работает в фазе `package`, а не `install`?  
2. Как добавить classifier `config` к артефакту?  
3. Что будет, если два модуля используют одинаковый `id` в assembly?

---

## **9. Подпись артефактов: GPG**

### ✅ **Задача**  
Подписать основной JAR, sources и javadoc с помощью GPG

### 🛠 **Пример решения**  
`parent/pom.xml`:
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-gpg-plugin</artifactId>
    <version>3.1.0</version>
    <executions>
        <execution>
            <id>sign-artifacts</id>
            <phase>verify</phase>
            <goals><goal>sign</goal></goals>
        </execution>
    </executions>
</plugin>
```

**Команды**:  
```bash
gpg --gen-key  # Создать ключ (email: test@example.com)
mvn clean install -Dgpg.passphrase="your-pass"
```

### 🔍 **Контроль**  
- В `target/` есть файлы `.asc` для всех артефактов

### ❓ **Каверзные вопросы**  
1. Почему подпись происходит в фазе `verify`, а не `install`?  
2. Что будет, если GPG ключ не найден?  
3. Как проверить подпись артефакта?

---

## **10. Профили: Условная компиляция**

### ✅ **Задача**  
Создать профили:  
- `dev` (активен по умолчанию, отладка включена)  
- `prod` (оптимизация)

### 🛠 **Пример решения**  
`parent/pom.xml`:
```xml
<profiles>
    <profile>
        <id>dev</id>
        <activation><activeByDefault>true</activeByDefault></activation>
        <properties>
            <maven.compiler.debug>true</maven.compiler.debug>
        </properties>
    </profile>
    <profile>
        <id>prod</id>
        <properties>
            <maven.compiler.optimize>true</maven.compiler.optimize>
        </properties>
    </profile>
</profiles>
```

**Команды**:  
```bash
mvn compile -Pprod  # Проверка: javap -v target/classes/... | grep flags
```

### 🔍 **Контроль**  
- В классах есть `Synthetic` флаг в `prod`

### ❓ **Каверзные вопросы**  
1. Как активировать профиль переменной окружения `ENV=prod`?  
2. Что будет, если активировать два профиля с конфликтующими свойствами?  
3. Почему `activeByDefault` не работает с `-P`?

---

## **11. Скрипты: exec, Ant, сторонние команды**

### ✅ **Задача**  
1. Запустить `echo` через `exec:exec`  
2. Создать файл через Ant  
3. Запустить Java-класс через `exec:java`

### 🛠 **Пример решения**  
`app/pom.xml`:
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-antrun-plugin</artifactId>
    <version>3.1.0</version>
    <executions>
        <execution>
            <phase>initialize</phase>
            <configuration>
                <target>
                    <echo file="target/build.txt">Build started</echo>
                </target>
            </configuration>
            <goals><goal>run</goal></goals>
        </execution>
    </executions>
</plugin>
```

**Команды**:  
```bash
mvn exec:exec -Dexec.executable="echo" -Dexec.args="Hello"
mvn exec:java -Dexec.mainClass="org.example.app.App"
mvn initialize  # Создаст build.txt
```

### 🔍 **Контроль**  
- Файл `target/build.txt` создан  
- Вывод `echo` в консоли

### ❓ **Каверзные вопросы**  
1. Почему `exec:java` не требует `phase`, а `antrun` — да?  
2. Как передать системные свойства в `exec:java`?  
3. Что будет, если Ant-задача упадёт?

---

## **12. ServiceLoader: SPI реализация**

### ✅ **Задача**  
Реализовать SPI:  
- Интерфейс `Logger`  
- Две реализации  
- Загрузка через `ServiceLoader`

### 🛠 **Пример решения**  
`core/src/main/java/org/example/spi/Logger.java`:
```java
public interface Logger { void log(String msg); }
```

`core/src/main/resources/META-INF/services/org.example.spi.Logger`:
```
org.example.spi.impl.ConsoleLogger
org.example.spi.impl.FileLogger
```

`app/src/main/java/org/example/app/App.java`:
```java
ServiceLoader<Logger> loader = ServiceLoader.load(Logger.class);
loader.forEach(l -> l.log("SPI Works!"));
```

### 🔍 **Контроль**  
- При запуске `mvn exec:java` выводятся обе реализации

### ❓ **Каверзные вопросы**  
1. Почему файл должен лежать именно в `META-INF/services`?  
2. Что будет, если реализация не имеет публичного конструктора?  
3. Как отфильтровать реализации по условию?

---

## **13. Appassembler: Генерация скриптов запуска**

### ✅ **Задача**  
Создать скрипты `bin/run` и `bin/run.bat` для запуска приложения

### 🛠 **Пример решения**  
`app/pom.xml`:
```xml
<plugin>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>appassembler-maven-plugin</artifactId>
    <version>2.1.0</version>
    <configuration>
        <programs>
            <program>
                <mainClass>org.example.app.App</mainClass>
                <name>run</name>
            </program>
        </programs>
    </configuration>
    <executions>
        <execution>
            <phase>package</phase>
            <goals><goal>assemble</goal></goals>
        </execution>
    </executions>
</plugin>
```

**Команда**:  
```bash
mvn package  # Проверка: target/appassembler/bin/run
```

### 🔍 **Контроль**  
- Скрипты работают без `java -jar`

### ❓ **Каверзные вопросы**  
1. Как добавить JVM-опции в сгенерированный скрипт?  
2. Почему классы лежат в `lib/`, а не в корне JAR?  
3. Что будет, если `mainClass` указан неверно?

---

## **14. Fat JAR: Все зависимости в одном файле**

### ✅ **Задача**  
Собрать исполняемый JAR с зависимостями (включая `core`)

### 🛠 **Пример решения**  
`app/pom.xml`:
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-shade-plugin</artifactId>
    <version>3.5.0</version>
    <executions>
        <execution>
            <phase>package</phase>
            <goals><goal>shade</goal></goals>
            <configuration>
                <transformers>
                    <transformer 
                        implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                        <mainClass>org.example.app.App</mainClass>
                    </transformer>
                </transformers>
            </configuration>
        </execution>
    </executions>
</plugin>
```

**Команда**:  
```bash
mvn package  # Проверка: java -jar target/app-1.0.0.jar
```

### 🔍 **Контроль**  
- JAR весит >100 KB (есть зависимости)  
- Запускается без ошибок

### ❓ **Каверзные вопросы**  
1. Почему `ManifestResourceTransformer` обязателен?  
2. Что будет при конфликте `META-INF/services`?  
3. Как исключить транзитивную зависимость из Fat JAR?

---

## **15. Рекурсивная смена версий**

### ✅ **Задача**  
Изменить версию всех модулей с `1.0.0` на `2.0.0`

### 🛠 **Пример решения**  
```bash
mvn versions:set -DnewVersion=2.0.0
mvn versions:commit  # Удаляет backup-файлы
```

### 🔍 **Контроль**  
- Все `pom.xml` обновлены  
- Нет файлов `pom.xml.versionsBackup`

### ❓ **Каверзные вопросы**  
1. Что делает `versions:revert`?  
2. Как изменить только версию родителя?  
3. Почему `versions:set` не работает без `-D`?

---

## **16. Написание плагина: greet-maven-plugin**

### ✅ **Задача**  
Создать плагин, выводящий "Hello from plugin!"

### 🛠 **Пример решения**  
```bash
mvn archetype:generate \
  -DarchetypeGroupId=org.apache.maven.archetypes \
  -DarchetypeArtifactId=maven-archetype-mojo
```

`GreetMojo.java`:
```java
@Mojo(name = "say-hello")
public class GreetMojo extends AbstractMojo {
    public void execute() {
        getLog().info("Hello from plugin!");
    }
}
```

**Использование в `app/pom.xml`**:
```xml
<plugin>
    <groupId>org.example</groupId>
    <artifactId>greet-maven-plugin</artifactId>
    <version>1.0-SNAPSHOT</version>
    <executions>
        <execution>
            <phase>compile</phase>
            <goals><goal>say-hello</goal></goals>
        </execution>
    </executions>
</plugin>
```

**Команда**:  
```bash
mvn compile  # Проверка: вывод "Hello from plugin!"
```

### 🔍 **Контроль**  
- Плагин запускается в фазе `compile`

### ❓ **Каверзные вопросы**  
1. Как передать параметр в Mojo через `<configuration>`?  
2. Что будет при дублировании `@Mojo(name)`?  
3. Почему Mojo должен наследоваться от `AbstractMojo`?

---

## **17. Дерево зависимостей: Анализ и оптимизация**

### ✅ **Задача**  
Найти конфликты версий и устаревшие зависимости

### 🛠 **Пример решения**  
```bash
mvn dependency:tree -Dverbose
mvn versions:display-dependency-updates
```

**Пример вывода**:
```
[INFO] org.example:app:jar:1.0.0
[INFO] +- org.example:core:jar:1.0.0:compile
[INFO] |  \- commons-lang:commons-lang:jar:2.6:compile
[INFO] \- junit:junit:jar:4.13.2:test
```

### 🔍 **Контроль**  
- Вывод показывает транзитивные зависимости  
- Есть предупреждения о конфликтах

### ❓ **Каверзные вопросы**  
1. Как работает правило `nearest wins`?  
2. Почему `dependency:tree -Dverbose` показывает `omitted for conflict`?  
3. Как обновить только одну транзитивную зависимость?

---

## **18. Репозитории: Nexus, GitHub, GitLab**

### ✅ **Задача**  
Настроить деплой в:  
- Nexus  
- GitHub Packages  
- GitLab Registry

### 🛠 **Пример решения**

#### **Nexus**  
`settings.xml`:
```xml
<servers>
    <server>
        <id>nexus-releases</id>
        <username>admin</username>
        <password>{encrypted-pass}</password>
    </server>
</servers>
```

`pom.xml`:
```xml
<distributionManagement>
    <repository>
        <id>nexus-releases</id>
        <url>http://nexus:8081/repository/maven-releases/</url>
    </repository>
</distributionManagement>
```

#### **GitHub Packages**  
`settings.xml`:
```xml
<servers>
    <server>
        <id>github</id>
        <password>${env.GITHUB_TOKEN}</password>
    </server>
</servers>
```

`pom.xml`:
```xml
<distributionManagement>
    <repository>
        <id>github</id>
        <url>https://maven.pkg.github.com/username/repo</url>
    </repository>
</distributionManagement>
```

#### **GitLab**  
`.gitlab-ci.yml`:
```yaml
deploy:
  script:
    - mvn deploy -DaltDeploymentRepository=gitlab::default::https://gitlab.com/api/v4/projects/$CI_PROJECT_ID/packages/maven
```

### 🔍 **Контроль**  
- Артефакты появляются в UI Nexus/GitHub/GitLab

### ❓ **Каверзные вопросы**  
1. Почему GitHub требует `altDeploymentRepository`?  
2. Как GitLab использует `CI_JOB_TOKEN` без пароля?  
3. Что будет при несовпадении `groupId` и имени репозитория?

---

## **19. Безопасность: Шифрование паролей**

### ✅ **Задача**  
Зашифровать пароли и хранить `settings-security.xml` на USB

### 🛠 **Пример решения**  
```bash
# Шаг 1: Создать мастер-пароль
mvn --encrypt-master-password "usb-pass" > /media/usb/settings-security.xml

# Шаг 2: Зашифровать пароль
mvn --encrypt-password "real-pass"  # Выведет {encrypted-pass}
```

`settings.xml`:
```xml
<servers>
    <server>
        <id>nexus</id>
        <password>{encrypted-pass}</password>
    </server>
</servers>
```

### 🔍 **Контроль**  
- Деплой работает только при подключённом USB

### ❓ **Каверзные вопросы**  
1. Как работает шифрование без указания пути к `settings-security.xml`?  
2. Что будет при потере USB с `settings-security.xml`?  
3. Почему мастер-пароль нельзя хранить в Git?

---

## **20. Финальная проверка: Полный CI-сценарий**

### ✅ **Задача**  
Выполнить полный цикл:  
1. Анализ зависимостей  
2. Сборка с подписью  
3. Деплой в Nexus  
4. Генерация сайта

### 🛠 **Команда**  
```bash
mvn clean install site deploy -Dgpg.passphrase="pass"
```

### 🔍 **Контроль**  
- [ ] Все артефакты в Nexus  
- [ ] Подписанные JARы  
- [ ] Сайт в `target/site`  
- [ ] Дерево зависимостей без конфликтов

---

# 📚 **Чеклист для самопроверки**
| Тема | Выполнено | Каверзный вопрос решён |
|------|-----------|------------------------|
| Основы | ☐ | ☐ |
| Ресурсы и свойства | ☐ | ☐ |
| Multi-module | ☐ | ☐ |
| Деплой | ☐ | ☐ |
| Генерация версии из Git | ☐ | ☐ |
| Документация | ☐ | ☐ |
| Доп. артефакты | ☐ | ☐ |
| Подпись | ☐ | ☐ |
| Профили | ☐ | ☐ |
| Скрипты | ☐ | ☐ |
| SPI | ☐ | ☐ |
| Appassembler | ☐ | ☐ |
| Fat JAR | ☐ | ☐ |
| Смена версий | ☐ | ☐ |
| Плагин | ☐ | ☐ |
| Дерево зависимостей | ☐ | ☐ |
| Репозитории | ☐ | ☐ |
| Безопасность | ☐ | ☐ |

---

# 💡 **Советы по прохождению плана**
1. **Не пропускайте вопросы** — они выявляют поверхностное понимание
2. **Проверяйте каждый шаг** через `ls`, `unzip`, `javap`
3. **Используйте Docker** для тестирования Nexus:  
   `docker run -d -p 8081:8081 --name nexus sonatype/nexus3`
4. **Храните пароли только на USB** — никогда в Git
5. Для задачи **Генерация версии из Git**:
   - Убедитесь, что `.git` существует
   - Проверьте `git status` перед сборкой
   - Используйте `git describe --tags` для семантических версий

---

# 🌐 **Полезные ссылки**
- [Maven Resource Filtering](https://maven.apache.org/plugins/maven-resources-plugin/examples/filter.html)
- [git-commit-id-maven-plugin](https://github.com/git-commit-id/git-commit-id-maven-plugin)
- [Maven: The Complete Reference](https://www.sonatype.com/books/maven-the-definitive-guide)
- [Nexus Repository Manager Docs](https://help.sonatype.com/repomanager3)
- [GitHub Packages Maven Guide](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-apache-maven-registry)
- [GitLab Maven Repository Docs](https://docs.gitlab.com/ee/user/packages/maven_repository/)

---

Готов приступить к практике? Начните с **шага 1**, выполните задание и пришлите:  
1. Вывод `mvn -v`  
2. Содержимое `pom.xml`  
3. Ответ на первый каверзный вопрос  

Проверю и дам обратную связь! 🚀