jsr233launcher
==============

Программа для запуска скриптов (на выполнение) из командной строки.
Поддерживаются те скрипты, которые соответствуют спецификаии JSR233[^JSR233] и добавлены в Java Classpath[^classpath]

Использование
-------------

Синтаксис запуска скрипта на выполнение

	jsr233script [<опции>] <файл_сценария> [параметры]

### Опции

* **-lang** _language_ <br>
     Указывает язык сценария, см. `-list engines`

* **-engine** _script_engine_ <br>
     Указывает движок языка сценария, см. `-list engines`

* **-charset** _charset_ <br>
  **-cs** _charset_ <br>
    Указывает кодировку файла сценария, см. `-list charsets`

* **-list engines** <br>
    Отображает доступные языки сценариев engines/languages

* **-list charsets** <br>
    Отображает доступные кодировки

* **-cl** _classloader_file_ <br>
    Создает загрузчик классов из указанного файла. см примеры.

* **-clbase** _classloader_base_directory_ <br>
	Указывает базовый каталог для загрузчика классов.

* **-tg** _thread_group_name_ <br>
	Указывает имя группы потоков/тредов, в которой исполняется сценарий.

* **-tn** _thread_name_ <br>
    Указывает имя потока/треда, в котором исполняется сценарий.

Примеры
-------

### Пример запуска JavaScript

0) Подготовте окружение для работы

В ос linux, откройте терминал и выполните команду

```bash
export PATH=<CXHOME>/bin:$PATH
```

Где `<CXHOME>` - путь до каталога установки


1) Создайте файл sample01.js со следующим содержанием:

```javascript
print( 'Sample using JavaScript (nashorn 1.8) in cxconsole' );

var curdir = new java.io.File('.');
for each (var el in curdir.listFiles()) {
	print( el )
}
```

2) выполните следующую команду

```bash
jsr233script sample01.js
```

Данный скрипт выведет содержание текущего каталога

### -list engines

Опция `-list engines` выводит список доступных языков в виде таблицы

```bash
jsr233script -list engines
```

| Language | Lang ver | Engine name | Eng. version | Extensions | Mime | Names |
|--------|--------|
| ECMAScript | ECMA - 262 Edition 5.1 | Oracle Nashorn | 1.8.0_162 | js | application/javascript, application/ecmascript, text/javascript, text/ecmascript | nashorn, Nashorn, js, JS, JavaScript, javascript, ECMAScript, ecmascript |
| Groovy | 2.4.15 | Groovy Scripting Engine | 2.0 | groovy | application/x-groovy | groovy, Groovy |

Список доступных языки можно расширить доустановив файлы jar с поддержкой JSR233 в каталог `<CXHOME>/lib`

### Classloader

Classloader - это java-объект который загружает необходимые классы в текущую java virtual machine.

Существуют несколько видов [загрузчиков классов](https://habrahabr.ru/post/103830/), загрузчики классов используются для различных целий - добавление нового API или сторонних библиотек, или еще для чего либо.

В данной случаи возможно без написания специального Java кода, создать Classloader из XML файла.

Пример:

```xml
<UrlClassLoaderBuilder parentCL="Inherit">
    <FileEntry>/home/home/lib1.jar</FileEntry>
    <FileEntry>lib2.jar</FileEntry>
    <UrlEntry>http://site.com/lib3.jar</UrlEntry>
</UrlClassLoaderBuilder>
```
`ClassLoaderBuilder` - это Java интерфейс для создания загрузчика классов, а `UrlClassLoaderBuilder` - одна из его реализаций.

Так в этом файле указывается `UrlClassLoaderBuilder` в качестве строителя загрузчика классов.

`FileEntry` - Указывает путь до скомпилированных Java классов. Путь может быть относительным.
`UrlEntry` - Указывает на http/https адрес скомпилированных Java классов.

#### Указание расположения Classloader

**Вариант 1**

Classloader из командной строки указывается параметром `-cl` _classloader_file_.

```bash
jsr233script -cl file.classloader ...
```

**Вариант 2**

Можно рядом с файлом сценария расположить файл classloader:

```bash
$ ls -la
-rw-rw-r-- 1 user user   4105 апр 11 13:30 sample02.groovy
-rw-rw-r-- 1 user user    110 апр 11 13:15 sample02.groovy.classloader
```

Так при запуске `jsr233script sample02.groovy` проверяется наличие `sample02.groovy.classloader` и если такой находится, то будет он использоваться.

#### Порядок "разрешения" полного пути для FileEntry

1. Если явно указана параметр `-clbase` _classloader_base_directory_, то будет испольоваться переданное значение параметра
2. Если указан параметр `-cl` _classloader_file_ или _classloader_file_ указан относительно файл скрипта, то относительно самого файла _classloader_file_

[^classpath]: Classpath - перменная среды/параметр java.exe указывающий на расположение скомпилированных классов java. см. https://en.wikipedia.org/wiki/Classpath_(Java).

[^JSR233]: Спецификация [JSR233](https://jcp.org/en/jsr/detail?id=233) определяет как реализовывать тот или иной язык для Java платформы. Что бы добавить поддержку языка (например [Python](http://www.jython.org/)) - необходимо скопировать соответ. jar файлы в каталог `<CXHOME>/lib`