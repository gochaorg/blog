collection
==========

Основные функции

* Списками (List)
	* с уведомлениями о измении (Издатели/Подписчики/События)
	* Синхронизация по объекту `synchronized`
	* Синхронизация по блокировке `Lock`
* Картами (Map)
	* с уведомлениями о измении (Издатели/Подписчики/События)
	* Синхронизация по объекту `synchronized`
	* Синхронизация по блокировке `Lock`
	* Карта типов с поддержкой ко-вариации типов данных `ClassMap`
	* Карты со строками
		* С поддеержкой регистро независимыми ключами
		* C префиксами
    * С записью в несколько карт `UnionMap`
* Множество (Set)
	* с уведомлениями о измении (Издатели/Подписчики/События)
	* Синхронизация по объекту `synchronized`
	* Синхронизация по блокировке `Lock`
	* Упорядоченное множество типов `ClassSet`
* Графы
	* Однонаправленные
	* Многонаправленные
	* Прослушивание измений графа (Издатели/Подписчики/События)
* Деревья
	* Уведомлениями о измении (Издатели/Подписчики/События)
	* Проталкивание событий вверх по дереву `popup()`
* Функциональные интерфейсы
* Итераторы `Iterable<T>/Iterator<T>`
	* Пуcтой итератор
	* Одиночный итератор
	* Последовательность итераторов
	* Итератор с фильтром
	* Конвертор - итератор
	* Итератор по дереву
	* Реверс итератор
	* Итератор без повторений
	* Итератор с "вычитанием"

maven
-----
    <dependency>
      <groupId>xyz.cofe</groupId>
      <artifactId>collection</artifactId>
      <version>0.2</version>
    </dependency>