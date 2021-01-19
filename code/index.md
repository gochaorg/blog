Набор Java библиотек
=====================

Краткое описание
----------------

Библиотеки расположены на:
* [github-е](https://github.com/gochaorg/cofe.xyz)
* [maven-sonatype](https://oss.sonatype.org/#nexus-search;quick~cofe.xyz)
* [maven-central](https://mvnrepository.com/search?q=xyz.cofe)

Основные задачи к которым призавны решать библиотеки
* Библиотека **common**
	* Общие алгоритмы Обработка абстракций как коллекции map/set/list/tree/iterators
	* Работа с sql данными
	* Работа с http протоколом
	* Работа с файловой системой (обвертка на java.nio.file)
	* Межпроцессорное взаимодействие (sharedmem)
	* Обработака xml
	* Общие функции по работе с текстом
	* Функции преобразования типов данных
* Библиотека **gui.swing**
	* Набор java - swing компонентов
	* Отображение/редакатирование
		* табличных данных
		* древовидных данных
		* Свойств объекта (PropertySheet)
		* форматированного текста
		* Логгирование действий (java logging framework)

### docking-frames

Библиотеки docking-frames-_xxxx_ - являются частью проекта http://www.docking-frames.org/.

Оригинальный проект docking-frames не сожержит актуальных артифактов в репозитории maven central (на 2018-07-31),
по этому были пересобраны исходники (без изменения) docking-frames и помещены в maven central.

### winrun4j

Ситуация с проектом [winrun4j](http://winrun4j.sourceforge.net/) аналогична docking-frames. Его исходники были так же пересобраны исходники и помещены в maven central.

Текущая версия 0.2.0
--------------------

[javadoc](https://gochaorg.github.io/pubdocs/api/cofe.xyz/0.2.0-SNAPSHOT-2018-07-29/)

maven артефакты / библиотеки

### xyz.cofe:common:0.2.0
maven зависимость
```xml
<dependency>
	<groupId>xyz.cofe</groupId>
	<artifactId>common</artifactId>
	<version>0.2.0</version>
</dependency>
```

### xyz.cofe:sql-localds:0.2.0
maven зависимость
```xml
<dependency>
	<groupId>xyz.cofe</groupId>
	<artifactId>sql-localds</artifactId>
	<version>0.2.0</version>
</dependency>
```

### xyz.cofe:gui.swing:0.2.0
maven зависимость
```xml
<dependency>
	<groupId>xyz.cofe</groupId>
	<artifactId>gui.swing</artifactId>
	<version>0.2.0</version>
</dependency>
```

### xyz.cofe:docking-frames-core:1.1.2p20b
maven зависимость
```xml
<dependency>
	<groupId>xyz.cofe</groupId>
	<artifactId>docking-frames-core</artifactId>
	<version>1.1.2p20b</version>
</dependency>
```

### xyz.cofe:docking-frames-common:1.1.2p20b
maven зависимость
```xml
<dependency>
	<groupId>xyz.cofe</groupId>
	<artifactId>xyz.cofe:docking-frames-common</artifactId>
	<version>1.1.2p20b</version>
</dependency>
```

### xyz.cofe:docking-frames-ext-toolbar:1.1.2p20b
maven зависимость
```xml
<dependency>
	<groupId>xyz.cofe</groupId>
	<artifactId>docking-frames-ext-toolbar</artifactId>
	<version>1.1.2p20b</version>
</dependency>
```

### xyz.cofe:docking-frames-ext-toolbar-common:1.1.2p20b
maven зависимость
```xml
<dependency>
	<groupId>xyz.cofe</groupId>
	<artifactId>docking-frames-ext-toolbar-common</artifactId>
	<version>1.1.2p20b</version>
</dependency>
```

### xyz.cofe:winrun4j:0.4.5
maven зависимость
```xml
<dependency>
	<groupId>xyz.cofe</groupId>
	<artifactId>winrun4j</artifactId>
	<version>0.4.5</version>
</dependency>
```

### Пример pom.xml
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>xyz.cofe</groupId>
	<artifactId>sample</artifactId>
	<version>0.1-SNAPSHOT</version>
	<packaging>jar</packaging>

	<dependencies>
		<dependency>
			<groupId>xyz.cofe</groupId>
			<artifactId>common</artifactId>
			<version>0.2.0</version>
		</dependency>
		<dependency>
		  <groupId>xyz.cofe</groupId>
		  <artifactId>sql-localds</artifactId>
		  <version>0.2.0</version>
		</dependency>
		<dependency>
		  <groupId>xyz.cofe</groupId>
		  <artifactId>gui.swing</artifactId>
		  <version>0.2.0</version>
		</dependency>
		<dependency>
            <groupId>xyz.cofe</groupId>
            <artifactId>docking-frames-core</artifactId>
            <version>1.1.2p20b</version>
        </dependency>
        <dependency>
            <groupId>xyz.cofe</groupId>
            <artifactId>docking-frames-common</artifactId>
            <version>1.1.2p20b</version>
        </dependency>
        <dependency>
            <groupId>xyz.cofe</groupId>
            <artifactId>docking-frames-ext-toolbar</artifactId>
            <version>1.1.2p20b</version>
        </dependency>
        <dependency>
            <groupId>xyz.cofe</groupId>
            <artifactId>docking-frames-ext-toolbar-common</artifactId>
            <version>1.1.2p20b</version>
        </dependency>
        <dependency>
            <groupId>xyz.cofe</groupId>
            <artifactId>winrun4j</artifactId>
            <version>0.4.5</version>
        </dependency>
	</dependencies>
</project>
```

Предыдущие версии
-----------------

[Версия 0.1](0.1/index.md)