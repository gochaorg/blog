## 📚 Углубленный план обучения: Коллекции, Generics, Stream API  
*7 этапов с фокусом на деталях, каверзных вопросах и постепенным нарастанием сложности*

---

## 🌱 **Этап 1. Основы коллекций: Сырые типы и базовые операции**  
*Цель: понять структуру коллекций без generics, увидеть проблему типобезопасности*

---

### **Теория: Коллекции "как есть"**
- **Иерархия интерфейсов**: `Collection` → `List`/`Set` → реализации (`ArrayList`, `HashSet`)
- **Сырые типы (Raw Types)**:
  ```java
  List list = new ArrayList(); // Не используйте в реальном коде!
  list.add("String");
  list.add(123); // Компилируется, но опасно!
  String s = (String) list.get(1); // ClassCastException в runtime
  ```
- **Почему это плохо**: Ошибки проявляются только во время выполнения.

---

### **Задание: Коллекции без generics**
1. Создайте `ArrayList` без generics и добавьте в него строку, число и объект `Book`.  
2. Напишите цикл, выводящий тип каждого элемента через `getClass().getSimpleName()`.  
3. Попробуйте привести число к строке — поймайте `ClassCastException`.

#### **Критерии оценки**:
✅ Работа с сырыми типами без generics  
✅ Понимание, почему `list.add(123)` компилируется, но падает при касте  
✅ Объяснение, как generics предотвращают такие ошибки

#### **Каверзный вопрос**:
```java
List list = new ArrayList();
list.add("Hello");
String s = list.get(0); // Почему НЕ нужно приведение типов в Java 5+?
```
[*Ответ*](05-oop-advanced-with-answers.md)

**Ссылки**:  
- [Collections Tutorial (Oracle)](https://docs.oracle.com/javase/tutorial/collections/)  
- https://javarush.com/groups/posts/2308-korotko-o-glavnom---java-collections-framework
- https://skillbox.ru/media/code/gotovimsya_k_sobesedovaniyu_chto_nuzhno_znat_o_kollektsiyakh_v_java/
- https://struchkov.dev/blog/ru/java-collection-framework/

---

## 🔤 **Этап 2. Введение в Generics: Типобезопасность и базовые ограничения**  
*Цель: освоить синтаксис generics и понять их преимущества*

---

### **Теория: Generics 101**
- **Обобщённые классы/методы**:
  ```java
  class Box<T> { private T item; }
  Box<String> stringBox = new Box<>();
  ```
- **Ограничения**:  
  - Нельзя создать `new T()`  
  - Нельзя использовать `instanceof T`  
  - Стирание типов: `Box<String>` и `Box<Integer>` одинаковы для JVM

---

### **Задание: Типобезопасный контейнер**
1. Реализуйте класс `SafeBox<T>` с методами `set(T item)` и `T get()`.  
2. Создайте `SafeBox<String>` и попробуйте передать в него `Integer` — объясните ошибку.  
3. Напишите статический метод `<T> T firstElement(List<T> list)`.

#### **Критерии оценки**:
✅ Корректная реализация generics в `SafeBox`  
✅ Понимание ошибки компиляции при передаче неверного типа  
✅ Статический метод работает с любым типом `T`

#### **Каверзный вопрос**:
```java
List<String> strings = new ArrayList<>();
List<Object> objects = strings; // Почему ошибка компиляции?
```
[*Ответ*](05-oop-advanced-with-answers.md)

**Ссылки**:  
- Пришел, увидел, обобщил: погружаемся в Java Generics https://habr.com/ru/companies/sberbank/articles/416413/
- Java Generics https://javarush.com/groups/posts/2310-dzheneriki-na-kotikakh
- Обобщения (Generics) https://metanit.com/java/tutorial/3.11.php

---

## 🌿 **Этап 3. Wildcards: Ковариантность и контравариантность**  
*Цель: глубокое понимание `? extends T` и `? super T`*

---

### **Теория: PECS и Wildcards**
- **Ковариантность (`? extends T`)** → **Producer**:  
  ```java
  void printNumbers(List<? extends Number> list) {
      Number n = list.get(0); // OK
      list.add(5); // Ошибка компиляции!
  }
  ```
- **Контравариантность (`? super T`)** → **Consumer**:  
  ```java
  void addIntegers(List<? super Integer> list) {
      list.add(10); // OK
      Integer i = (Integer) list.get(0); // Нужно приведение типов
  }
  ```
- **Правило PECS (Producer Extends, Consumer Super)**

---

### **Задание: Практика с Wildcards**
1. Реализуйте метод:
   ```java
   public static double sum(List<? extends Number> numbers)
   ```
2. Создайте `List<Integer>` и передайте его в метод `sum()`.  
3. Попробуйте добавить `Double` в `List<? extends Number>` — объясните ошибку.  
4. Реализуйте метод `void addNumbers(List<? super Integer> dest)`.

#### **Критерии оценки**:
✅ Корректное использование `? extends` и `? super`  
✅ Объяснение ошибки при добавлении в `List<? extends T>`  
✅ Понимание, почему `List<Object>` допустим для `List<? super Integer>`

#### **Каверзные вопросы**:
1. **Почему это не компилируется?**
   ```java
   List<Number> numbers = new ArrayList<Integer>(); // Ошибка!
   ```
   [*Ответ*](05-oop-advanced-with-answers.md)

2. **Что вернёт `list.get(0)` для `List<? super Integer>`?**
   [*Ответ*](05-oop-advanced-with-answers.md)

3. **Можно ли создать `new ArrayList<? extends Number>()`?**
   [*Ответ*](05-oop-advanced-with-answers.md)

**Ссылки**:  
- Пришел, увидел, обобщил: погружаемся в Java Generics https://habr.com/ru/companies/sberbank/articles/416413/

---

## ⚡ **Этап 4. Лямбды: От анонимных классов к функциональному стилю**  
*Цель: плавный переход от ООП к функциональному программированию*

---

### **Теория: Лямбды шаг за шагом**
- **Эволюция кода**:
  ```java
  // 1. Анонимный класс
  Comparator<String> c1 = new Comparator<String>() {
      public int compare(String a, String b) { return a.length() - b.length(); }
  };
  
  // 2. Лямбда
  Comparator<String> c2 = (a, b) -> a.length() - b.length();
  
  // 3. Метод-референс
  Comparator<String> c3 = Comparator.comparingInt(String::length);
  ```
- **Функциональные интерфейсы**:  
  `Predicate<T>`, `Function<T, R>`, `Consumer<T>`, `Supplier<T>`

**Ссылки**:  
- https://struchkov.dev/blog/ru/lambda-expression-java/

---

### **Задание: Лямбды в действии**
1. Перепишите анонимный класс `Comparator` для сортировки строк по длине через лямбду.  
2. Реализуйте `Predicate<String>` для фильтрации строк, начинающихся с "A".  
3. Используйте `Function<Integer, String>` для преобразования чисел в строки с префиксом.

#### **Критерии оценки**:
✅ Все анонимные классы заменены лямбдами  
✅ Корректное использование `Predicate`, `Function`  
✅ Понимание, когда уместны метод-референсы (`::`)

#### **Каверзный вопрос**:
```java
int x = 5;
Runnable r = () -> x = 10; // Почему ошибка компиляции?
```
[*Ответ*](05-oop-advanced-with-answers.md)

---

## 🌊 **Этап 5. Stream API: Промежуточные операции**  
*Цель: освоить фильтрацию, преобразование и сортировку данных*

**Теория на 5 и 6 этап:**
- https://struchkov.dev/blog/ru/java-stream-api/

---

### **Теория: Промежуточные операции**
- **Ленивые операции** (выполняются только при терминальной операции):  
  `filter()`, `map()`, `flatMap()`, `distinct()`, `sorted()`, `peek()`
- **Пример**:
  ```java
  List<String> result = list.stream()
      .filter(s -> s.length() > 3)
      .map(String::toUpperCase)
      .sorted()
      .collect(Collectors.toList());
  ```

---

### **Задание: Фильтрация и преобразование**
1. Отфильтруйте список имён, оставив только те, что начинаются с гласной.  
2. Преобразуйте список чисел в их квадраты через `map()`.  
3. Удалите дубликаты из списка строк через `distinct()`.  
4. Отсортируйте книги по году издания через `sorted(Comparator.comparing(Book::getYear))`.

#### **Критерии оценки**:
✅ Корректное использование `filter`, `map`, `distinct`, `sorted`  
✅ Лямбды вместо анонимных классов  
✅ Понимание ленивости промежуточных операций

#### **Каверзный вопрос**:
```java
Stream.of("a", "b", "c")
    .map(s -> {
        System.out.println(s);
        return s.toUpperCase();
    });
// Почему ничего не выводится в консоль?
```
[*Ответ*](05-oop-advanced-with-answers.md)

---

## 🎯 **Этап 6. Stream API: Терминальные операции и коллекторы**  
*Цель: освоить агрегацию данных и сложные преобразования*

**Теория на 5 и 6 этап:**
- https://struchkov.dev/blog/ru/java-stream-api/

---

### **Теория: Терминальные операции**
- **Операции для агрегации**:  
  `collect()`, `reduce()`, `count()`, `max()`, `min()`, `anyMatch()`
- **Коллекторы (Collectors)**:  
  `toList()`, `toMap()`, `groupingBy()`, `partitioningBy()`
- **Пример группировки**:
  ```java
  Map<Integer, List<Book>> byYear = books.stream()
      .collect(Collectors.groupingBy(Book::getYear));
  ```

---

### **Задание: Агрегация данных**
1. Найдите самую длинную строку в списке через `stream().max(Comparator.comparingInt(String::length))`.  
2. Сгруппируйте список книг по году издания через `groupingBy()`.  
3. Разделите список чисел на чётные/нечётные через `partitioningBy()`.  
4. Посчитайте общее количество символов во всех строках через `mapToInt(String::length).sum()`.

#### **Критерии оценки**:
✅ Корректное использование `max`, `groupingBy`, `partitioningBy`  
✅ Оптимизация через `mapToInt()` вместо `map().reduce()`  
✅ Понимание разницы между `reduce()` и `collect()`

#### **Каверзный вопрос**:
```java
List<Integer> numbers = Arrays.asList(1, 2, 3);
int sum = numbers.stream().reduce(0, (a, b) -> a + b);
// Как работает reduce? Что такое identity-значение?
```
[*Ответ*](05-oop-advanced-with-answers.md)

---

## 🧩 **Этап 7. Итоговое задание: Управление библиотекой с интеграцией всех тем**  

---

### **Задание: Продвинутая библиотека книг**
Реализуйте систему с использованием:
1. **Generics и Wildcards**:  
   - Класс `Book<T extends Content>` (где `Content` — интерфейс с методом `int getLength()`).  
   - Метод `void importBooks(List<? extends Book<?>> source, List<? super Book<TextContent>> dest)`.  
2. **Stream API**:  
   - Фильтрация книг по автору и минимальной длине контента.  
   - Группировка книг по жанру через `Collectors.groupingBy()`.  
   - Поиск самой длинной книги через `stream().max(Comparator.comparingInt(b -> b.getContent().getLength()))`.  
3. **Особенности коллекций**:  
   - Сравнение производительности `ArrayList` vs `LinkedList` при 10 000 операциях добавления.  
   - Реализация потокобезопасного кэша через `ConcurrentHashMap`.

---

### **Критерии оценки**:
✅ **Generics**:  
   - Использованы bounded types (`T extends Content`) и wildcards по правилу PECS.  
   - Нет ошибок при работе с `List<? super Book<TextContent>>`.  
✅ **Stream API**:  
   - Сложные операции через `groupingBy()`, `partitioningBy()`, `max()`.  
   - Оптимизация через специализированные методы (`mapToInt()`, `mapToDouble()`).  
✅ **Коллекции**:  
   - Обоснованное сравнение `ArrayList` vs `LinkedList`.  
   - Понимание thread-safety в `ConcurrentHashMap`.  
✅ **Типобезопасность**:  
   - Нет сырых типов, unchecked casts, предупреждений компилятора.

---

### **Каверзные вопросы (итоговые)**:
1. **Почему это не компилируется?**
   ```java
   List<Book<TextContent>> texts = new ArrayList<>();
   List<Book<?>> books = texts;
   books.add(new Book<ImageContent>()); // Ошибка!
   ```
   [*Ответ*](05-oop-advanced-with-answers.md)

2. **Как исправить метод, чтобы он принимал `List<? extends Book<?>>` и добавлял книги?**
   [*Ответ*](05-oop-advanced-with-answers.md)

3. **Почему `ConcurrentHashMap` не блокирует всю таблицу при записи?**
   [*Ответ*](05-oop-advanced-with-answers.md)

4. **Что вернёт `stream().findAny()` в однопоточном режиме?**
   [*Ответ*](05-oop-advanced-with-answers.md)

5. **Почему `list.stream().forEach(System.out::println)` не гарантирует порядок вывода?**
   [*Ответ*](05-oop-advanced-with-answers.md)

---

## 📅 График изучения
| Этап | Тема | Время |
|------|------|-------|
| **1** | Сырые типы и базовые коллекции | 2 дня |
| **2** | Generics: основы и ограничения | 2 дня |
| **3** | Wildcards: ковариантность и контравариантность | 3 дня |
| **4** | Лямбды: от анонимных классов к функциональному стилю | 2 дня |
| **5** | Stream API: промежуточные операции | 3 дня |
| **6** | Stream API: терминальные операции и коллекторы | 3 дня |
| **7** | Итоговое задание | 5 дней |

---

## 💡 Советы для глубокого усвоения
1. **Для wildcards** рисуйте схему:  
   - `? extends T` → "Я могу брать элементы как `T`, но не могу класть ничего кроме `null`".  
   - `? super T` → "Я могу класть `T`, но брать могу только как `Object`".
   
2. **Проверяйте понимание generics через компилятор**:  
   ```java
   List<? extends Number> ext = new ArrayList<Integer>();
   List<? super Integer> sup = new ArrayList<Number>();
   ext = sup; // Почему ошибка?
   ```

3. **Для Stream API** тренируйтесь переписывать циклы:  
   ```java
   // Было
   for (String s : list) {
       if (s.length() > 5) System.out.println(s);
   }
   // Стало
   list.stream().filter(s -> s.length() > 5).forEach(System.out::println);
   ```

---

✅ **Итог**: Если вы можете объяснить, почему `List<String>` ≠ `List<Object>`, как работает `Collectors.groupingBy()`, и ответить на все каверзные вопросы — вы готовы к собеседованию на Java-разработчика!