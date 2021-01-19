Настроека проекта maven
=======================

Любой maven проект имеет премно следующую структуру:

* `pom.xml` - конфигурация сборки проекта
* `src/` - каталог с исходниками
  * `main/` - каталог основных исходников
    * `java/` - исходники
    * `resources/` - ресурсы
  * `test/` - каталог исходников тестов
    * `java/` - исходники
    * `resources/` - ресурсы
* `target/` - каталог в который будет собран проект

Минимальный pom.xml
-------------------

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.example</groupId>
    <artifactId>test-jfrog-oss</artifactId>
    <version>1.0-SNAPSHOT</version>

</project>
```

* **project/groupId** - идентификатор группы разработки (компания разработчик)
* **project/artifactId** - артифакт (наименование/код продукта)
* **project/version** - версия артифакта

Указание deploy репозиториев
----------------------------

После сборки артифакта, артифакт может быть загружен на сервер JFrog artifactory, для этого добавьте раздел `project/distributionManagement/repository`

```xml
<project>
    ...
    <distributionManagement>
        ...
        <repository>
            <id>server_id1</id>
            <name>3ec53f8980c2-releases</name>
            <url>http://10.1.18.18:8081/artifactory/repo_name</url>
        </repository>
        ...
        <snapshotRepository>
            <id>server_id2</id>
            <name>3ec53f8980c2-snapshots</name>
            <url>http://10.1.18.18:8081/artifactory/repo_name</url>
        </snapshotRepository>
        ...
    </distributionManagement>
    ...
</project>
```


* **repository** - описывает репозиторий, который содержит release сборки - т.е. сборки без суффикса `SNAPSHOT` в версии артифакта _project/version_.

  * **repository/id** - идентификатор репозитория, см [settings.xml/settings/servers/server](maven-config.md)
  * **repository/name** - любое имя
  * **repository/url** - ссылка на репозиторий
* **snapshotRepository** - описывает репозиторий, который содержит snapshot сборки - т.е. сборки с суффиксом `SNAPSHOT` в версии артифакта _project/version_.
  * **snapshotRepository/id** - идентификатор репозитория, см [settings.xml/settings/servers/server](maven-config.md)
  * **snapshotRepository/name** - любое имя
  * **snapshotRepository/url** - ссылка на репозиторий

Указание зависимостей
---------------------

Зависимости описываются в секциях `project/dependencies/dependency`

```xml
<project>
    ...
    <dependencies>
        ...
        <dependency>
            <groupId>org.example</groupId>
            <artifactId>test-jfrog-oss</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        ...
    </dependencies>
    ...
</project>
```

* **groupId, artifactId, version** - указывают на зависимые артифакты


Пример deploy
-------------

После настройки `pom.xml`, выполните `mvn deploy`

Вывод будет примерно таким
```
C:\Users\65kgp\code\test-jfrog-oss-parent>mvn deploy
[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Build Order:
[INFO]
[INFO] test-jfrog-oss
[INFO] test-jfrog-oss-parent
[INFO] test-jfrod-dep1
[INFO] ------------------------------------------------------------------------
[INFO] Building test-jfrog-oss 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
Downloading from central: http://10.1.18.18:8081/artifactory/libs-release/org/apache/maven/plugins/maven-deploy-plugin/2.7/maven-deploy-plugin-2.7.pom
Downloaded from central: http://10.1.18.18:8081/artifactory/libs-release/org/apache/maven/plugins/maven-deploy-plugin/2.7/maven-deploy-plugin-2.7.pom (5.6 kB at 9.3 kB/s)
Downloading from central: http://10.1.18.18:8081/artifactory/libs-release/org/apache/maven/plugins/maven-deploy-plugin/2.7/maven-deploy-plugin-2.7.jar
Downloaded from central: http://10.1.18.18:8081/artifactory/libs-release/org/apache/maven/plugins/maven-deploy-plugin/2.7/maven-deploy-plugin-2.7.jar (27 kB at 103 kB/s)
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ test-jfrog-oss ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ test-jfrog-oss ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ test-jfrog-oss ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory C:\Users\65kgp\code\test-jfrog-oss-parent\test-jfrog-oss\src\test\resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ test-jfrog-oss ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ test-jfrog-oss ---
[INFO]
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ test-jfrog-oss ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ test-jfrog-oss ---
[INFO] Installing C:\Users\65kgp\code\test-jfrog-oss-parent\test-jfrog-oss\target\test-jfrog-oss-1.0-SNAPSHOT.jar to C:\Users\65kgp\.m2\repository\org\example\test-jfrog-oss\1.0-SNAPSHOT\test-jfrog-oss-1.0-SNAPSHOT.jar
[INFO] Installing C:\Users\65kgp\code\test-jfrog-oss-parent\test-jfrog-oss\pom.xml to C:\Users\65kgp\.m2\repository\org\example\test-jfrog-oss\1.0-SNAPSHOT\test-jfrog-oss-1.0-SNAPSHOT.pom
[INFO]
[INFO] --- maven-deploy-plugin:2.7:deploy (default-deploy) @ test-jfrog-oss ---
Downloading from central: http://10.1.18.18:8081/artifactory/libs-release/org/codehaus/plexus/plexus-utils/1.5.6/plexus-utils-1.5.6.pom
Downloaded from central: http://10.1.18.18:8081/artifactory/libs-release/org/codehaus/plexus/plexus-utils/1.5.6/plexus-utils-1.5.6.pom (5.3 kB at 31 kB/s)
Downloading from central: http://10.1.18.18:8081/artifactory/libs-release/org/codehaus/plexus/plexus/1.0.12/plexus-1.0.12.pom
Downloaded from central: http://10.1.18.18:8081/artifactory/libs-release/org/codehaus/plexus/plexus/1.0.12/plexus-1.0.12.pom (9.3 kB at 52 kB/s)
Downloading from central: http://10.1.18.18:8081/artifactory/libs-release/org/codehaus/plexus/plexus-utils/1.5.6/plexus-utils-1.5.6.jar
Downloaded from central: http://10.1.18.18:8081/artifactory/libs-release/org/codehaus/plexus/plexus-utils/1.5.6/plexus-utils-1.5.6.jar (251 kB at 16 kB/s)
Downloading from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/1.0-SNAPSHOT/maven-metadata.xml
Downloaded from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/1.0-SNAPSHOT/maven-metadata.xml (769 B at 11 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/1.0-SNAPSHOT/test-jfrog-oss-1.0-20200818.221604-2.jar
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/1.0-SNAPSHOT/test-jfrog-oss-1.0-20200818.221604-2.jar (2.9 kB at 1.2 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/1.0-SNAPSHOT/test-jfrog-oss-1.0-20200818.221604-2.pom
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/1.0-SNAPSHOT/test-jfrog-oss-1.0-20200818.221604-2.pom (1.2 kB at 6.9 kB/s)
Downloading from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/maven-metadata.xml
Downloaded from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/maven-metadata.xml (372 B at 5.6 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/1.0-SNAPSHOT/maven-metadata.xml
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/1.0-SNAPSHOT/maven-metadata.xml (769 B at 4.6 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/maven-metadata.xml
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss/maven-metadata.xml (317 B at 1.8 kB/s)
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building test-jfrog-oss-parent 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ test-jfrog-oss-parent ---
[INFO] Installing C:\Users\65kgp\code\test-jfrog-oss-parent\pom.xml to C:\Users\65kgp\.m2\repository\org\example\test-jfrog-oss-parent\1.0-SNAPSHOT\test-jfrog-oss-parent-1.0-SNAPSHOT.pom
[INFO]
[INFO] --- maven-deploy-plugin:2.7:deploy (default-deploy) @ test-jfrog-oss-parent ---
Downloading from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/1.0-SNAPSHOT/maven-metadata.xml
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/1.0-SNAPSHOT/test-jfrog-oss-parent-1.0-20200818.221607-1.pom
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/1.0-SNAPSHOT/test-jfrog-oss-parent-1.0-20200818.221607-1.pom (1.4 kB at 3.1 kB/s)
Downloading from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/maven-metadata.xml
Downloaded from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/maven-metadata.xml (379 B at 5.4 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/1.0-SNAPSHOT/maven-metadata.xml
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/1.0-SNAPSHOT/maven-metadata.xml (605 B at 3.6 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/maven-metadata.xml
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrog-oss-parent/maven-metadata.xml (324 B at 1.9 kB/s)
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building test-jfrod-dep1 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ test-jfrod-dep1 ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ test-jfrod-dep1 ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ test-jfrod-dep1 ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory C:\Users\65kgp\code\test-jfrog-oss-parent\test-jfrod-dep1\src\test\resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ test-jfrod-dep1 ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ test-jfrod-dep1 ---
[INFO] No tests to run.
[INFO]
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ test-jfrod-dep1 ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ test-jfrod-dep1 ---
[INFO] Installing C:\Users\65kgp\code\test-jfrog-oss-parent\test-jfrod-dep1\target\test-jfrod-dep1-1.0-SNAPSHOT.jar to C:\Users\65kgp\.m2\repository\org\example\test-jfrod-dep1\1.0-SNAPSHOT\test-jfrod-dep1-1.0-SNAPSHOT.jar
[INFO] Installing C:\Users\65kgp\code\test-jfrog-oss-parent\test-jfrod-dep1\pom.xml to C:\Users\65kgp\.m2\repository\org\example\test-jfrod-dep1\1.0-SNAPSHOT\test-jfrod-dep1-1.0-SNAPSHOT.pom
[INFO]
[INFO] --- maven-deploy-plugin:2.7:deploy (default-deploy) @ test-jfrod-dep1 ---
Downloading from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/maven-metadata.xml
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/test-jfrod-dep1-1.0-20200818.221608-1.jar
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/test-jfrod-dep1-1.0-20200818.221608-1.jar (2.6 kB at 1.1 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/test-jfrod-dep1-1.0-20200818.221608-1.pom
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/test-jfrod-dep1-1.0-20200818.221608-1.pom (1.2 kB at 6.7 kB/s)
Downloading from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/maven-metadata.xml
Downloaded from rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/maven-metadata.xml (373 B at 5.4 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/maven-metadata.xml
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/maven-metadata.xml (770 B at 4.8 kB/s)
Uploading to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/maven-metadata.xml
Uploaded to rcr-65kgp-snapshots: http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/maven-metadata.xml (318 B at 1.8 kB/s)
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO]
[INFO] test-jfrog-oss ..................................... SUCCESS [ 26.819 s]
[INFO] test-jfrog-oss-parent .............................. SUCCESS [  0.918 s]
[INFO] test-jfrod-dep1 .................................... SUCCESS [  3.129 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 30.996 s
[INFO] Finished at: 2020-08-19T03:16:11+05:00
[INFO] Final Memory: 12M/54M
[INFO] ------------------------------------------------------------------------
```

* **maven-resources-plugin:2.6:resources** - компиляция/копирование ресурсов
* **maven-compiler-plugin:3.1:compile** - компиляция исходников
* **maven-resources-plugin:2.6:testResources** - компиляция/копирование ресурсов тестова
* **maven-compiler-plugin:3.1:testCompile** - компиляция тестов
* **maven-surefire-plugin:2.12.4:test** - выполнение тестов
* **maven-jar-plugin:2.4:jar** - сборка jar
* **maven-install-plugin:2.4:install** - установка jar в локальный репозиторий на рабочей машине

пример
```
Installing C:\Users\user\code\test-jfrog-oss-parent\test-jfrog-oss\target\test-jfrog-oss-1.0-SNAPSHOT.jar 
  to C:\Users\user\.m2\repository\org\example\test-jfrog-oss\1.0-SNAPSHOT\test-jfrog-oss-1.0-SNAPSHOT.jar
```

* **maven-deploy-plugin:2.7:deploy** - заливка артифакта на сервер JFrog

```
Uploading to rcr-65kgp-snapshots: 
  http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/test-jfrod-dep1-1.0-20200818.221608-1.jar
Uploaded to rcr-65kgp-snapshots: 
  http://10.1.18.18:8081/artifactory/kgp65-test/org/example/test-jfrod-dep1/1.0-SNAPSHOT/test-jfrod-dep1-1.0-20200818.221608-1.jar
  (2.6 kB at 1.1 kB/s)
```

Результат / успешность deploy

```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO]
[INFO] test-jfrog-oss ..................................... SUCCESS [ 26.819 s]
[INFO] test-jfrog-oss-parent .............................. SUCCESS [  0.918 s]
[INFO] test-jfrod-dep1 .................................... SUCCESS [  3.129 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
```