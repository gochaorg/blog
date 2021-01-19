cxgroovy
========

cxgroovy - это модуль [Groovy](http://groovy-lang.org/) для [cxconsole](key-features.md), и одноименный bash/bat скрипт для запуска groovy скриптов.

cxgroovy поставляется вместе с cxconsole и расположен `<cxconsole>/bin/cxgroovy`

Использование в терминале/командной строке
------------------------------------------

**cxgroovy** предназначен для выполнения groovy скриптов.

**cxgroovy.bat**, **cxgroovy.sh** написан с учетом, что распакованный [дистрибутив cxconsole](dist.md) может находится в любом месте файловой системы.

При запуске
* определяет свое расположение
* определяет расположение java
* определяет располодение библиотек (jar/dll)
* конструирует параметры запуска java (classpath/librarypath/...)
* запускает java.exe с необходимыми параметрами для выполнения скрипта

Запуск файла скрипта groovy

	cxgroovy [<опции>] <файл_сценария> [параметры скрипта]

Запуск скрипта groovy используя pipe

	cat <файл_сценария> | cxgroovy [<опции>] -- [параметры скрипта]

### Опции

* **-?** <br>
  **/?** <br>
  **--help** отображает справку

*  **-cs** _charset_ <br>
    Указывает кодировку файла сценария, см. `-list charsets`

* **-list charsets** <br>
    Отображает доступные кодировки

* **-e** _groovy_code_ <br>
    Выполняет groovy код переданный как параметр

* **-conf** _cxgroovy_config_file_ <br>
	Указывает файл конфигурации cxgroovy

* **-basedir** _basedir_ <br>
	Указывает базовый каталог для относительных путей

### Файл конфигурации cxgroovy

Файл cxgroovy содержит описание дополнительных java библиотек (jar), а так же расположение исходных файлов groovy.

Данный может быть указан явно с использованием параметра `-conf <cxgroovy_conf>` или не явно: когда указан файл сценария (например script1.groovy), ищется одноименный файл с расширением cxgroovy (например script.groovy.cxgroovy)

Файл представляет из себя xml разметку, пример:

```xml
<CXGroovyConf>
    <GCompilerConf 
        scriptBaseClass="xyz.cofe.adm.MsSqlAdmBase"
        sourceEncoding="UTF-8"
        targetDirectory="cache/bin/classes"
        minimumRecompilationInterval="15000"
        recompileGroovySource="false">
		<imports>
			<ImportClass   className="pkg.clsname"></ImportClass>
			<ImportClass   className="pkg.clsname2" alias="alias2" />
			<ImportPackage packageName="pkg"></ImportPackage>
			<ImportField   className="pkg.clsname3" fieldName="field1" />
			<ImportField   className="pkg.clsname3" fieldName="field2" alias="alias3" />
			<ImportFields  className="pkg" />
		</imports>
    </GCompilerConf>
	<GroovyClassLoaderBuilder parentCL="Inherit" shouldRecompile="false">
		<GCompilerConf 
            sourceEncoding="UTF-8"
            targetDirectory="cache/bin/classes"
            minimumRecompilationInterval="15000"
            recompileGroovySource="true"
			defaultScriptExtension="groovy"
			debug="false"
			verbose="true"
			/>
		<classpathEntries>
            <FileEntry>lib/jfreechart/jcommon-1.0.23.jar</FileEntry>
            <FileEntry>lib/jfreechart/jfreechart-1.0.19.jar</FileEntry>
            <FileEntry>src/mssql</FileEntry>
        </classpathEntries>
	</GroovyClassLoaderBuilder>
</CXGroovyConf>
```

* CXGroovyConf - является общий контейнером для xml, все вложенные тэги и атрибуты не являются обязательными
* GCompilerConf - указывает параметры компиляции groovy скриптов
	* @scriptBaseClass` - [базовый класс](http://docs.groovy-lang.org/latest/html/gapi/groovy/transform/BaseScript.html) для файла сценария
	* @sourceEncoding - кодировка исходников
	* @targetDirectory - куда помещать скопилированные исходники
	* @minimumRecompilationInterval - интервал в милисикундах, спустя который перекомпилировать исходники
	* @recompileGroovySource = true/false - перекомпилировать исходники
	* @debug
	* @verbose
	* @defaultScriptExtension
* imports - Указывает какие классы/функции импортировать в скрипт имплицитно
* GroovyClassLoaderBuilder - указывает расположение java библиотек и исходников которые добовляются в classpath
	* @parentCL - указывает наследовать или нет родительский classpath (библиотеки/классы cxconsole/lib/*.jar)
		* @parentCL="Inherit"
		* @parentCL="System"
	* @shouldRecompile = true/false
* classpathEntries - Указывает расположение jar библиотек / исходников Groovy
* FileEntry - Указывает расположение jar библиотеки / каталога исходников в файловой системе
* UrlEntry - Указывает расположение jar библиотеки в интернете (http://адрес_до_jar)

