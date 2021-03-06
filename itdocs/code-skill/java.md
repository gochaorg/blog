Язык Java
=============
- Что за файлы .java/.class/.jar/.war
- Что такое JEP/JSR
	- *JLS - Java Language Specification / Specification - это документ, который определяет (или определяет) что-то*
	- *JSR - Java Specification Requests. Официальные документы, описывающие предлагаемые спецификации и технологии для добавления на платформу Java. <br> Запрос - это заявление (письменное или устное) с просьбой о чем-то.* <br> *JSR - это документ, созданный как часть процесса сообщества Java (JCP), который устанавливает рамки для группы людей для разработки новой спецификации. Эти спецификации (AFAIK) всегда связаны с Java, но они часто касаются вещей, которые не будут базовыми технологиями Java SE или Java EE. Типичный предметный материал JSR - относительно зрелая технология; т.е. находится в состоянии, которое можно указать. (Если вы попытаетесь создать спецификацию слишком рано, то, как правило, получите плохую спецификацию. К этому могут привести и другие причины.)*
	- *JEP - JDK Enhancement Proposal. Proposal - Предложение - это заявление (письменное или устное), предлагающее что-то для рассмотрения.* <br> *JEP - это документ, в котором предлагается усовершенствовать базовую технологию Java. Это предложения, как правило, для улучшений, которые еще не готовы к определению. Как говорится в документе JEP-0, JEP могут требовать исследования новых (даже «дурацких») идей. Вообще говоря, прототипирование потребуется, чтобы разделить жизнеспособные и нежизнеспособные идеи и прояснить их до такой степени, чтобы можно было разработать спецификацию.*
		- *JEP предлагают и развивают экспериментальные идеи до такой степени, чтобы их можно было конкретизировать. Не все JEP реализуются.*
		- *JSR берут зрелые идеи (например, вытекающие из JEP) и создают новую спецификацию или модификации существующей спецификации. Не все JSR реализуются.*
		- *Спецификация - это обычный рабочий продукт JSR. (Другие включают исходный код интерфейсов и эталонные реализации.) JLS является примером спецификации. Другие включают спецификацию JVM, спецификации сервлетов и JSP, спецификации EJB и так далее.*
- Отличие примитивных типов от не примитивных
- Optional<?>
- try/catch/finally
	- обработка исключений
	- вложенные исключения
	- библиотеки для логгирования
	- скорость работы exception
	- try + resource
- switch
	- синтаксис для java 6
	- новшества java 7
	- новшества java 13 (switch expression)
- стек вызовов
	- что такое frame
	- как получить стек вызовов
- Базовые термины ООП
	- Что есть объект
	- Что есть класс
	- Что есть наследование
	- Что есть интерфейс
	- Что есть пакет
- Специфичные термины ООП/java
	- отличие enum от класса/интерфейса
	- что такое final class
	- интерфейс Iterable
	- интерфейс Stream
	- javadoc
	- record
	- JEP 360: запечатанные классы
- уровни доступа
	- 4 уровня доступа
	- файл module-info.java
- Соглашения о наименовании
	- имена классов, пакетов, методов, констант, интерфейсов
	- getter-ы и setter-ы в java (java beans)
- Объекты
	- Конструктор, блоки инициализации, статические блоки
	- вложенные классы
	- анонимные классы
- Интерфейсы
	- Базовые
	- default методы
	- private методы
	- статические методы
- Лямбды
	- что это
	- ссылки на конструкторы/методы
	- рекурсивные лямбды ?
- Типы
	- Что такое Generic тип
	- Пример/пояснение что есть ко/контр вариантность
	- Отличие Class от Type
	- Отличие Array от List
	- вывод типов
- Аннотации
	- Что это
	- В каких местах используются
	- Где храниться информация
