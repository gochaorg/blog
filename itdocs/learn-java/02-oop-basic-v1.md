### **Практический план обучения ООП в Java: "Система управления библиотекой"**  
**Цель**: Изучить ООП через рефакторинг проекта — от простых классов до sealed-иерархий с generics.  
**Особенности**:  
- Все задания — часть **единого проекта**, усложняющегося с каждой темой.  
- **Минимум теории**: только практическое применение паттернов.  
- **Контролируемый результат**: для каждого задания есть четкий тест-кейс.  
- **Опора на предыдущие темы**: каждая новая задача использует результаты прошлых.  

---

### **1. Классы и объекты: Создание базовых сущностей**  
**Цель**: Освоить инкапсуляцию и валидацию данных.  
**Задания**:  
1. Создайте класс `Book` с полями:  
   ```java
   public class Book {
       private String title;
       private String author;
       private String isbn;
       
       public Book(String title, String author, String isbn) {
           // Валидация: ISBN в формате "123-456-789"
           if (!isbn.matches("\\d{3}-\\d{3}-\\d{3}")) {
               throw new IllegalArgumentException("Неверный формат ISBN");
           }
           this.title = title;
           this.author = author;
           this.isbn = isbn;
       }
   }
   ```  
2. Напишите метод `isValidIsbn(String isbn)`, возвращающий `true` для корректных ISBN.  
3. Создайте 3 объекта `Book`:  
   - Валидный (`"123-456-789"`) → работает.  
   - Невалидный (`"12-345-678"`) → ошибка при создании.  
   - Невалидный (`"ABC-456-789"`) → ошибка при создании.  

**Контрольные вопросы**:  
- ❓ Почему поле `isbn` объявлено как `private`? Что сломается, если сделать его `public`?  
- ❓ Как изменится поведение, если убрать `throw` и оставить пустой конструктор?  

**Ссылки**:  
- [Classes and Objects (Oracle)](https://docs.oracle.com/javase/tutorial/java/javaOO/classes.html)  

**Пример решения**:  
```java
public class Book {
    private final String title;
    private final String author;
    private final String isbn;

    public Book(String title, String author, String isbn) {
        if (!isValidIsbn(isbn)) {
            throw new IllegalArgumentException("ISBN должен быть в формате XXX-XXX-XXX");
        }
        this.title = title;
        this.author = author;
        this.isbn = isbn;
    }

    public static boolean isValidIsbn(String isbn) {
        return isbn != null && isbn.matches("\\d{3}-\\d{3}-\\d{3}");
    }
}

// Проверка
public class Main {
    public static void main(String[] args) {
        System.out.println(Book.isValidIsbn("123-456-789")); // true
        System.out.println(Book.isValidIsbn("12-345-678"));  // false
        new Book("Java", "Gosling", "ABC-456-789"); // Исключение
    }
}
```

---

### **2. Наследование: Добавление типов книг**  
**Цель**: Расширить функционал через наследование, избежать дублирования.  
**Задания** (опираются на `Book` из п.1):  
1. Создайте иерархию:  
   ```java
   public class PrintedBook extends Book {
       private int pages;
       
       public PrintedBook(String title, String author, String isbn, int pages) {
           super(title, author, isbn);
           this.pages = pages;
       }
   }
   
   public class ElectronicBook extends Book {
       private String format; // "PDF", "EPUB"
       
       public ElectronicBook(String title, String author, String isbn, String format) {
           super(title, author, isbn);
           this.format = format;
       }
   }
   ```  
2. Переопределите метод `toString()` в подклассах для вывода специфичной информации.  
3. Создайте массив `Book[]` из `PrintedBook` и `ElectronicBook`, выведите все элементы.  

**Контрольные вопросы**:  
- ❓ Почему `ElectronicBook` не может иметь поле `pages`? Как это исправить без дублирования кода?  
- ❓ Что произойдет, если вызвать `new Book(...)` для создания `ElectronicBook`?  

**Ссылки**:  
- [Inheritance (Oracle)](https://docs.oracle.com/javase/tutorial/java/IandI/subclasses.html)  

**Пример решения**:  
```java
public class PrintedBook extends Book {
    private final int pages;

    public PrintedBook(String title, String author, String isbn, int pages) {
        super(title, author, isbn);
        this.pages = pages;
    }

    @Override
    public String toString() {
        return super.toString() + " [Pages: " + pages + "]";
    }
}

// Проверка
Book[] books = {
    new PrintedBook("Java", "Gosling", "123-456-789", 300),
    new ElectronicBook("Python", "Rossum", "234-567-890", "PDF")
};
for (Book book : books) {
    System.out.println(book); // Вызовет переопределенный toString()
}
```

---

### **3. Абстрактные классы и интерфейсы: Устранение дублирования**  
**Цель**: Вынести общую логику в абстрактный класс и интерфейс.  
**Задания** (опираются на п.2):  
1. Создайте:  
   ```java
   public interface Borrowable {
       boolean isAvailable();
       void borrow();
   }
   
   public abstract class LibraryItem {
       private String title;
       private boolean available = true;
       
       public LibraryItem(String title) {
           this.title = title;
       }
       
       public abstract String getIdentifier(); // Например, ISBN или URL
   }
   ```  
2. Перепишите `Book` так, чтобы он наследовал `LibraryItem` и реализовывал `Borrowable`.  
3. Добавьте метод `validateItem(LibraryItem item)`, проверяющий:  
   - Для книг: корректность ISBN (как в п.1).  
   - Для электронных книг: допустимый формат (как в п.2).  

**Контрольные вопросы**:  
- ❓ Почему `getIdentifier()` объявлен как `abstract`? Что произойдет, если убрать `abstract`?  
- ❓ Как добавить метод `returnItem()` в `Borrowable`, не ломая существующий код?  

**Ссылки**:  
- [Abstract Classes (Oracle)](https://docs.oracle.com/javase/tutorial/java/IandI/abstract.html)  

**Пример решения**:  
```java
public abstract class LibraryItem implements Borrowable {
    private String title;
    private boolean available = true;

    public LibraryItem(String title) {
        this.title = title;
    }

    public abstract String getIdentifier();

    @Override
    public boolean isAvailable() {
        return available;
    }

    @Override
    public void borrow() {
        if (!available) throw new IllegalStateException("Недоступно");
        available = false;
    }
}

public class Book extends LibraryItem {
    private final String isbn;

    public Book(String title, String author, String isbn) {
        super(title);
        if (!Book.isValidIsbn(isbn)) {
            throw new IllegalArgumentException();
        }
        this.isbn = isbn;
    }

    @Override
    public String getIdentifier() {
        return isbn;
    }
}
```

---

### **4. Инкапсуляция и геттеры/сеттеры: Контроль доступа**  
**Цель**: Ограничить прямой доступ к полям через методы.  
**Задания** (опираются на `LibraryItem` из п.3):  
1. Добавьте в `LibraryItem`:  
   - Приватное поле `id` (автоинкремент).  
   - Геттер `getId()`, сеттер запрещен.  
2. В `Book` добавьте:  
   - Приватное поле `publicationYear` с валидацией (от 1800 до текущего года).  
   - Сеттер `setPublicationYear(int year)`, выбрасывающий исключение при ошибке.  
3. Напишите тест:  
   ```java
   Book book = new Book("Java", "Gosling", "123-456-789");
   book.setPublicationYear(2025); // OK
   book.setPublicationYear(1700); // Ошибка
   ```  

**Контрольные вопросы**:  
- ❓ Почему `id` нельзя сделать `public final`? Как это нарушит инкапсуляцию?  
- ❓ Как обработать ошибку в сеттере без `throw`? Почему это плохо?  

**Ссылки**:  
- [Encapsulation (Oracle)](https://docs.oracle.com/javase/tutorial/java/javaOO/encapsulation.html)  

**Пример решения**:  
```java
public abstract class LibraryItem {
    private static int nextId = 1;
    private final int id;
    private String title;

    public LibraryItem(String title) {
        this.id = nextId++;
        this.title = title;
    }

    public int getId() {
        return id;
    }
}

public class Book extends LibraryItem {
    private int publicationYear;

    public void setPublicationYear(int year) {
        if (year < 1800 || year > 2025) {
            throw new IllegalArgumentException("Год должен быть между 1800 и 2025");
        }
        this.publicationYear = year;
    }
}
```

---

### **5. Records: Упрощение immutable-классов**  
**Цель**: Заменить boilerplate-код на records.  
**Задания** (опираются на `Book` из п.4):  
1. Перепишите `Book` как record:  
   ```java
   public record Book(String title, String author, String isbn, int publicationYear) {
       public Book {
           if (!isValidIsbn(isbn)) {
               throw new IllegalArgumentException("Неверный ISBN");
           }
           if (publicationYear < 1800 || publicationYear > 2025) {
               throw new IllegalArgumentException("Год вне диапазона");
           }
       }
   }
   ```  
2. Убедитесь, что:  
   - `Book` больше не имеет сеттеров (неизменяемость).  
   - Валидация работает как в п.4.  
3. Добавьте record `User(String name, String email)` с валидацией email.  

**Контрольные вопросы**:  
- ❓ Почему record не может иметь приватных полей? Как это влияет на инкапсуляцию?  
- ❓ Что произойдет при попытке изменить `publicationYear` после создания объекта?  

**Ссылки**:  
- [Records (Oracle)](https://docs.oracle.com/en/java/javase/16/language/records.html)  

**Пример решения**:  
```java
public record Book(String title, String author, String isbn, int publicationYear) {
    public Book {
        if (!isbn.matches("\\d{3}-\\d{3}-\\d{3}")) {
            throw new IllegalArgumentException("ISBN");
        }
        if (publicationYear < 1800 || publicationYear > 2025) {
            throw new IllegalArgumentException("Год");
        }
    }
}

// Проверка
Book validBook = new Book("Java", "Gosling", "123-456-789", 2020);
Book invalidBook = new Book("Bad", "Author", "12-345-678", 2020); // Исключение
```

---

### **6. Sealed Classes: Контроль иерархии типов**  
**Цель**: Ограничить наследование классов.  
**Задания** (опираются на records из п.5):  
1. Создайте sealed-иерархию:  
   ```java
   public sealed interface LibraryItem permits Book, ElectronicBook, Magazine {}
   
   public record Book(...) implements LibraryItem {}
   public record ElectronicBook(String format, ...) implements LibraryItem {}
   public record Magazine(int issueNumber, ...) implements LibraryItem {}
   ```  
2. Добавьте класс `Newspaper`, не указанный в `permits` → убедитесь в ошибке компиляции.  
3. Напишите метод:  
   ```java
   public String getItemType(LibraryItem item) {
       return switch (item) {
           case Book b -> "Книга: " + b.title();
           case ElectronicBook e -> "Электронная книга: " + e.format();
           case Magazine m -> "Журнал: " + m.issueNumber();
       };
   }
   ```  

**Контрольные вопросы**:  
- ❓ Почему sealed-классы безопаснее открытого наследования?  
- ❓ Что произойдет, если добавить новый тип в `permits` без обновления `switch`?  

**Ссылки**:  
- [Sealed Classes (Oracle)](https://docs.oracle.com/en/java/javase/17/language/sealed-classes-and-interfaces.html)  

**Пример решения**:  
```java
public sealed interface LibraryItem permits Book, ElectronicBook {}

public record Book(String title, String isbn) implements LibraryItem {
    public Book {
        if (!isbn.matches("\\d{3}-\\d{3}-\\d{3}")) {
            throw new IllegalArgumentException("ISBN");
        }
    }
}

// Ошибка компиляции:
// public class Newspaper implements LibraryItem {} // Не разрешен в permits
```

---

### **7. Generics: Типобезопасность для коллекций**  
**Цель**: Сделать систему гибкой для новых типов.  
**Задания** (опираются на sealed-иерархию из п.6):  
1. Добавьте generics в `Library`:  
   ```java
   public class Library<T extends LibraryItem> {
       private List<T> items = new ArrayList<>();
       
       public void addItem(T item) {
           items.add(item);
       }
       
       public List<T> findByTitle(String title) {
           return items.stream()
               .filter(item -> item.title().equals(title))
               .toList();
       }
   }
   ```  
2. Создайте:  
   - `Library<Book>` для книг.  
   - `Library<ElectronicBook>` для электронных книг.  
3. Убедитесь, что `library.addItem(new Magazine(...))` не компилируется.  

**Контрольные вопросы**:  
- ❓ Почему `T extends LibraryItem`? Что сломается без этого ограничения?  
- ❓ Как добавить метод `getFirstItem()`, возвращающий `T`?  

**Ссылки**:  
- [Generics (Oracle)](https://docs.oracle.com/javase/tutorial/java/generics/)  

**Пример решения**:  
```java
Library<Book> bookLibrary = new Library<>();
bookLibrary.addItem(new Book("Java", "123-456-789", 2020));
bookLibrary.addItem(new Book("Python", "234-567-890", 2021));

// Ошибка компиляции:
// bookLibrary.addItem(new ElectronicBook("PDF", "JS", "345-678-901", 2022));
```

---

### **8. Итоговый проект: Полная система управления библиотекой**  
**Цель**: Объединить все навыки в рабочем приложении.  

#### **План решения и обоснование**  
1. **Sealed-иерархия типов** (п.6):  
   ```java
   public sealed interface LibraryItem permits Book, ElectronicBook, Magazine {}
   public record Book(String title, String isbn, int year) implements LibraryItem {}
   ```  
   *Обоснование*: Гарантирует, что новые типы нельзя добавить случайно (как в п.6).  

2. **Generics для коллекций** (п.7):  
   ```java
   public class Library<T extends LibraryItem> {
       private final List<T> items;
       // Методы для поиска и управления
   }
   ```  
   *Обоснование*: Позволяет создавать специализированные библиотеки (только книги, только журналы).  

3. **Records с валидацией** (п.5):  
   ```java
   public record Book(...) implements LibraryItem {
       public Book {
           // Валидация из п.1 и п.4
       }
   }
   ```  
   *Обоснование*: Убирает boilerplate, сохраняя неизменяемость и безопасность.  

4. **Обработка через switch + pattern matching** (п.6):  
   ```java
   public String processItem(LibraryItem item) {
       return switch (item) {
           case Book b -> "Книга: " + b.title();
           case ElectronicBook e -> "Формат: " + e.format();
           case Magazine m -> "Номер: " + m.issueNumber();
       };
   }
   ```  
   *Обоснование*: Компилятор проверит обработку всех типов (как в п.6).  

#### **Критерии проверки**  
- При добавлении невалидного ISBN возникает исключение (как в п.1).  
- `Library<Book>` принимает только книги (как в п.7).  
- Метод `processItem()` обрабатывает все типы из sealed-иерархии (как в п.6).  

#### **Каверзные вопросы**  
- ❓ Что произойдет, если добавить `case default -> "Неизвестно";` в `switch`?  
  *Ответ*: Код скомпилируется, но компилятор предупредит, что обработка не полная (поскольку sealed гарантирует известные типы).  
- ❓ Почему `Library<LibraryItem>` менее безопасен, чем `Library<Book>`?  
  *Ответ*: Разрешает добавлять любые типы (журналы, газеты), нарушая типобезопасность (п.7).  

---

### **Почему это работает**  
1. **Последовательность**:  
   - Валидация ISBN (п.1) → валидация в records (п.5) → обработка ошибок в итоговом проекте.  
   - Наследование (п.2) → sealed-иерархия (п.6) → типобезопасная обработка через `switch`.  

2. **Контролируемый результат**:  
   - Для каждой темы есть **конкретный тест-кейс** (например, `new Book("Bad", "12-345-678", 2020)` → ошибка).  
   - Итоговый проект проверяет **практическое применение всех паттернов** (records + sealed + generics).  

3. **Минимум теории**:  
   - Records и sealed объясняются через **конкретные примеры** (без углубления в JVM).  
   - Generics вводятся только для решения задачи типобезопасности (п.7).  

