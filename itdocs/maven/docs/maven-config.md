Конфигурация maven
=============================

Все локальные артифакты и настройки maven храняться в домашнем каталоге пользователя: 
`C:\Users\user_name\.m2` <br> _Каталог C:\Users\user_name - может отличаться, в зависимости от настроек пользователя на рабочей машине_.

Настройка .m2/settings.xml
-------------------------
Создайте файл `settings.xml` в каталоге `.m2`, если он еще не создан.
Данный файл может содржать много настроек, но если у вас его нет, то можете взять из примера.

Данный файл описывает где расположены удаленные репозитории maven, а так же логины и пароли для доступа к ним.

Добавление логина/пароля от сервера
-----------------------------------

Добавьте раздлел `settings/servers/server`

```xml
<settings>
    ...
    <servers>
        ...
        <server>
            <username>jfrog_login</username>
            <password>password</password>
            <id>server_id1</id>
        </server>
        <server>
            <username>jfrog_login</username>
            <password>password</password>
            <id>server_id2</id>
        </server>
        ...
    </servers>
</settings>
```

* **id** - придумайте идентификатор сервера, этот идентификатор используется только в этом файле и файлах проекта maven - `pom.xml`
* **username**, **password** - логин и пароль от JFrog artifactory

###  Шифрование пароля

Maven поддерживает шифрование паролей сервера. Основным вариантом использования этого решения является

* несколько пользователей используют одну и ту же машину сборки (сервер, блок CI)
* некоторые пользователи имеют право развертывать артефакты Maven в репозиториях, некоторые нет
    * это относится к любым операциям сервера, требующим авторизации, а не только к развертыванию
* `settings.xml` используется пользователями совместно

Внедренное решение добавляет следующие возможности:

* авторизованные пользователи имеют дополнительный файл `settings-security.xml` в своей папке `${user.home}/.m2`
    * этот файл либо содержит зашифрованный **мастер-пароль**, используемый для шифрования других паролей
    * или он может содержать ссылку на другой файл, возможно, на съемном носителе - **relocation**
    * этот пароль сначала создается через CLI.
* записи сервера в `settings.xml` имеют зашифрованные пароли и / или парольные фразы хранилища ключей
    * это делается через CLI **после того, как** мастер-пароль был создан и сохранен в соответствующем месте
    
#### Как создать мастер-пароль

Используйте следующую командную строку:

    mvn --encrypt-master-password <password>
    
_Начиная с Maven 3.2.1 аргумент пароля больше не должен использоваться_

_В Maven до версии 3.2.1 вы должны указать пароль в командной строке в качестве аргумента, 
что означает, что вам может потребоваться экранировать свой пароль._

_Кроме того, обычно оболочка хранит полную историю введенных вами команд, поэтому любой, у кого есть доступ к вашему компьютеру, может восстановить пароль из истории оболочки._

_Начиная с Maven 3.2.1 пароль является необязательным аргументом. Если вы опустите пароль, вам будет предложено его ввести, что предотвратит все проблемы, упомянутые выше._

Эта команда создаст зашифрованную версию пароля, что-то вроде

    {jSMOWnoPFgsHVpMvz5VrIt5kRbzGpI8u+9EF1iFQyJQ=}
    
Сохраните этот пароль в папке `${user.home}/.m2/ settings-security.xml`
это должно выглядеть как

```xml
<settingsSecurity>
  <master>{jSMOWnoPFgsHVpMvz5VrIt5kRbzGpI8u+9EF1iFQyJQ=}</master>
</settingsSecurity>
```

Когда это будет сделано, вы можете начать шифрование существующих паролей сервера.

#### Как зашифровать пароли сервера

Вы должны использовать следующую командную строку:

    mvn --encrypt-password <password>
    
_Как и --encrypt-master-password, аргумент пароля больше не должен использоваться с Maven 3.2.1._

Эта команда создает его зашифрованную версию, что-то вроде

    {COQLCE6DU6GtcS5P=}

Скопируйте и вставьте его в раздел серверов вашего файла `settings.xml`. Это будет выглядеть так

```xml
<settings>
...
  <servers>
...
    <server>
      <id>my.server</id>
      <username>foo</username>
      <password>{COQLCE6DU6GtcS5P=}</password>
    </server>
...
  </servers>
...
</settings>
```

Обратите внимание, что пароль может содержать любую информацию за пределами фигурных скобок, поэтому следующее будет работать:

```xml
<settings>
...
  <servers>
...
    <server>
      <id>my.server</id>
      <username>foo</username>
      <password>Oleg reset this password on 2009-03-11, expires on 2009-04-11 {COQLCE6DU6GtcS5P=}</password>
    </server>
...
  </servers>
...
</settings>
```

Затем вы можете использовать, скажем, плагин развертывания, чтобы написать на этот сервер:

    mvn deploy:deploy-file -Durl=https://maven.corp.com/repo \
                           -DrepositoryId=my.server \
                           -Dfile=your-artifact-1.0.jar \
                           
#### Как сохранить мастер-пароль на съемном диске

Создайте мастер-пароль точно так, как описано выше, 
и сохраните его на съемном диске, например, в OSX, 
мой USB-накопитель монтируется как /Volumes/mySecureUsb, 
поэтому я сохраняю

```xml
<settingsSecurity>
  <master>{jSMOWnoPFgsHVpMvz5VrIt5kRbzGpI8u+9EF1iFQyJQ=}</master>
</settingsSecurity>
```

в файле /Volumes/mySecureUsb/secure/settings-security.xml

Затем я создаю $ {user.home} /. M2 / settings-security.xml со следующим содержимым:

```xml
<settingsSecurity>
  <relocation>/Volumes/mySecureUsb/secure/settings-security.xml</relocation>
</settingsSecurity>
```

Это гарантирует, что шифрование работает только тогда, когда USB-накопитель подключен к ОС. 
Это относится к случаю использования, 
когда только определенные люди имеют право развертывать и выдают эти устройства.

#### Экранирование фигурных скобок в пароле (начиная с Maven 2.2.0)

Иногда вы можете обнаружить, что ваш пароль (или его зашифрованная форма) содержит буквенное значение "{" или "}". Если вы добавили такой пароль в свой файл settings.xml как есть,
вы обнаружите, что Maven делает с ним странные вещи. В частности, Maven рассматривает все символы, предшествующие литералу '{', и все символы после литерала '}' как комментарии.
Очевидно, это не то поведение, которое вам нужно. Что вам действительно нужно, так это способ избежать использования фигурных скобок в вашем пароле.

Вы можете сделать это с помощью широко используемого escape-символа '\'. Если ваш пароль выглядит так:

    jSMOWnoPFgsHVpMvz5VrIt5kRbzGpI8u+{EF1iFQyJQ=
    
Тогда значение, которое вы должны добавить в свой файл settings.xml, будет выглядеть так:

    {jSMOWnoPFgsHVpMvz5VrIt5kRbzGpI8u+\{EF1iFQyJQ=}

Создайте/отредактируйте активный профиль
----------------------------------------

Создайте раздел `settings/profiles/profile`

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
        <activeProfile>profile-id-2</activeProfile>
  </activeProfiles>
</settings>
```

* **profile/id** - идентификатор профиля
* **activeProfiles/activeProfile** указывает на активацию указанного профиля по умолчанию

В активном профиле укажите репозитории
---------------------------------------

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
                    <url>http://10.1.18.18:8081/artifactory/repo_name</url>
                </repository>
                <repository>
                    <snapshots />
                    <id>server_id2</id>
                    <name>libs-snapshot</name>
                    <url>http://10.1.18.18:8081/artifactory/repo_name</url>
                </repository>
            </repositories>
        </profile>
        ...
    </profile>
</settings>
```

* **repository/id** - идентификатор сервера указанного в `settings/servers/server`
* **repository/name** - имя репозитория, может быть любое
* **repository/url** - ссылка на репозиторий. В случае JFrog artifactory ссылка будет вида http://адрес:порт/artifactory/имя_репозитория
* **snapshots/enabled** - указывает, надо ли искать snapshot сборки, в данном репозитории.

Пример .m2/settings.xml
------------------------

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd" xmlns="http://maven.apache.org/SETTINGS/1.1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <servers>
    <server>
      <username>jfrog_login</username>
      <password>password</password>
      <id>server_id1</id>
    </server>
    <server>
      <username>jfrog_login</username>
      <password>password</password>
      <id>server_id2</id>
    </server>
  </servers>
  <profiles>
    <profile>
      <repositories>
        <repository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>server_id1</id>
          <name>libs-release</name>
          <url>http://10.1.18.18:8081/artifactory/repo_name</url>
        </repository>
        <repository>
          <snapshots />
          <id>server_id2</id>
          <name>libs-snapshot</name>
          <url>http://10.1.18.18:8081/artifactory/repo_name</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>libs-release</name>
          <url>http://10.1.18.18:8081/artifactory/libs-release</url>
        </pluginRepository>
        <pluginRepository>
          <snapshots />
          <id>snapshots</id>
          <name>libs-snapshot</name>
          <url>http://10.1.18.18:8081/artifactory/libs-snapshot</url>
        </pluginRepository>
      </pluginRepositories>
      <id>artifactory</id>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>artifactory</activeProfile>
  </activeProfiles>
</settings>
```

После настройки maven переходим к [настройке проекта](pom.md)