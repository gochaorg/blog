### **Практический план обучения ООП в Java: "Система обработки финансовых операций"**  
**Цель**: Изучить ООП через рефакторинг финансовой системы — от простых классов до sealed-иерархий с generics.  
**Особенности**:  
- Все задания — часть **единого проекта**, усложняющегося с каждой темой.  
- **Минимум теории**: только практическое применение паттернов.  
- **Опора на предыдущие темы**: каждая новая задача использует результаты прошлых.  
- **Контролируемый результат**: для каждого задания есть четкий тест-кейс.  

---

### **1. Классы и объекты: Создание базовой транзакции**  
**Цель**: Освоить инкапсуляцию и валидацию данных.  
**Задания**:  
1. Создайте класс `Transaction` с полями:  
   ```java
   public class Transaction {
       private String id;
       private double amount;
       private String currency;
       
       public Transaction(String id, double amount, String currency) {
           // Валидация: amount > 0, currency в списке ["USD", "EUR", "RUB"]
           if (amount <= 0) {
               throw new IllegalArgumentException("Сумма должна быть положительной");
           }
           if (!currency.equals("USD") && !currency.equals("EUR") && !currency.equals("RUB")) {
               throw new IllegalArgumentException("Неподдерживаемая валюта");
           }
           this.id = id;
           this.amount = amount;
           this.currency = currency;
       }
   }
   ```  
2. Напишите метод `validate(Transaction t)`, возвращающий `true` для валидных транзакций.  
3. Создайте 3 объекта:  
   - Валидный (`id="TX1", amount=100, currency="USD"`) → работает.  
   - Невалидный (`amount=-50`) → ошибка при создании.  
   - Невалидный (`currency="BTC"`) → ошибка при создании.  

**Контрольные вопросы**:  
- ❓ Почему поля объявлены как `private`? Что сломается при `public`?  
- ❓ Как изменится поведение, если убрать `throw` и оставить пустой конструктор?  

**Ссылки**:  
- [Classes and Objects (Oracle)](https://docs.oracle.com/javase/tutorial/java/javaOO/classes.html)  

**Пример решения**:  
```java
public class TransactionValidator {
    public static boolean validate(Transaction t) {
        return t.getAmount() > 0 && 
               (t.getCurrency().equals("USD") || 
                t.getCurrency().equals("EUR") || 
                t.getCurrency().equals("RUB"));
    }
}

// Проверка
try {
    new Transaction("TX1", 100, "USD"); // OK
    new Transaction("TX2", -50, "USD"); // Исключение
} catch (IllegalArgumentException e) {
    System.out.println(e.getMessage()); // "Сумма должна быть положительной"
}
```

---

### **2. Наследование: Добавление типов операций**  
**Цель**: Расширить функционал через наследование, избежать дублирования.  
**Задания** (опираются на `Transaction` из п.1):  
1. Создайте иерархию:  
   ```java
   public class Deposit extends Transaction {
       public Deposit(String id, double amount, String currency) {
           super(id, amount, currency);
       }
   }
   
   public class Withdrawal extends Transaction {
       private final String sourceAccount;
       
       public Withdrawal(String id, double amount, String currency, String sourceAccount) {
           super(id, amount, currency);
           this.sourceAccount = sourceAccount;
       }
   }
   
   public class Transfer extends Transaction {
       private final String targetAccount;
       
       public Transfer(String id, double amount, String currency, String targetAccount) {
           super(id, amount, currency);
           this.targetAccount = targetAccount;
       }
   }
   ```  
2. Переопределите метод `validate()`:  
   - Для `Withdrawal`: проверка `sourceAccount != null`.  
   - Для `Transfer`: проверка `targetAccount != null`.  
3. Создайте массив `Transaction[]` из разных типов операций, вызовите `validate()` для всех.  

**Контрольные вопросы**:  
- ❓ Почему `Withdrawal` не может проверить баланс счета в конструкторе?  
- ❓ Что произойдет, если вызвать `new Transaction(...)` вместо подклассов?  

**Ссылки**:  
- [Inheritance (Oracle)](https://docs.oracle.com/javase/tutorial/java/IandI/subclasses.html)  

**Пример решения**:  
```java
public class Withdrawal extends Transaction {
    private final String sourceAccount;
    
    public Withdrawal(String id, double amount, String currency, String sourceAccount) {
        super(id, amount, currency);
        if (sourceAccount == null || sourceAccount.isEmpty()) {
            throw new IllegalArgumentException("Счет отправителя обязателен");
        }
        this.sourceAccount = sourceAccount;
    }
    
    @Override
    public boolean validate() {
        return super.validate() && sourceAccount != null;
    }
}

// Проверка
Transaction[] transactions = {
    new Deposit("D1", 100, "USD"),
    new Withdrawal("W1", 50, "EUR", "ACC123")
};
for (Transaction tx : transactions) {
    System.out.println(tx.validate()); // true для обоих
}
```

---

### **3. Абстрактные классы и интерфейсы: Устранение дублирования**  
**Цель**: Вынести общую логику в абстрактный класс и интерфейс.  
**Задания** (опираются на п.2):  
1. Создайте:  
   ```java
   public interface Validatable {
       boolean isValid();
       default String getValidationMessage() {
           return isValid() ? "OK" : "Ошибка валидации";
       }
   }
   
   public abstract class BaseTransaction implements Validatable {
       private final String id;
       private final double amount;
       private final String currency;
       
       protected BaseTransaction(String id, double amount, String currency) {
           this.id = id;
           this.amount = amount;
           this.currency = currency;
       }
       
       @Override
       public boolean isValid() {
           return amount > 0 && 
                  (currency.equals("USD") || 
                   currency.equals("EUR") || 
                   currency.equals("RUB"));
       }
   }
   ```  
2. Перепишите `Deposit`, `Withdrawal`, `Transfer` так, чтобы они наследовали `BaseTransaction`.  
3. Добавьте в `Validatable` метод `logValidation()`, выводящий результат в консоль.  

**Контрольные вопросы**:  
- ❓ Почему `BaseTransaction` объявлен как `abstract`? Что произойдет без `abstract`?  
- ❓ Как добавить общий метод `getFormattedAmount()` в `BaseTransaction`?  

**Ссылки**:  
- [Abstract Classes (Oracle)](https://docs.oracle.com/javase/tutorial/java/IandI/abstract.html)  

**Пример решения**:  
```java
public abstract class BaseTransaction implements Validatable {
    // ... поля и конструктор
    
    public String getFormattedAmount() {
        return String.format("%.2f %s", amount, currency);
    }
}

public class Withdrawal extends BaseTransaction {
    private final String sourceAccount;
    
    public Withdrawal(String id, double amount, String currency, String sourceAccount) {
        super(id, amount, currency);
        this.sourceAccount = sourceAccount;
    }
    
    @Override
    public boolean isValid() {
        return super.isValid() && sourceAccount != null && !sourceAccount.isEmpty();
    }
}
```

---

### **4. Records: Упрощение immutable-классов**  
**Цель**: Заменить boilerplate-код на records.  
**Задания** (опираются на `BaseTransaction` из п.3):  
1. Перепишите `BaseTransaction` как record:  
   ```java
   public record Transaction(String id, double amount, String currency) {
       public Transaction {
           if (amount <= 0) {
               throw new IllegalArgumentException("Сумма должна быть положительной");
           }
           if (!currency.equals("USD") && !currency.equals("EUR") && !currency.equals("RUB")) {
               throw new IllegalArgumentException("Неподдерживаемая валюта");
           }
       }
   }
   ```  
2. Убедитесь, что:  
   - Валидация работает как в п.1.  
   - Поля неизменяемы (попытка изменения `amount` после создания → ошибка компиляции).  
3. Перепишите `Withdrawal` как record:  
   ```java
   public record Withdrawal(
       String id, 
       double amount, 
       String currency, 
       String sourceAccount
   ) {
       public Withdrawal {
           new Transaction(id, amount, currency); // Проверка базовой валидации
           if (sourceAccount == null || sourceAccount.isEmpty()) {
               throw new IllegalArgumentException("Счет отправителя обязателен");
           }
       }
   }
   ```  

**Контрольные вопросы**:  
- ❓ Почему record не может иметь приватных полей? Как это влияет на инкапсуляцию?  
- ❓ Что произойдет при попытке изменить `amount` после создания объекта?  

**Ссылки**:  
- [Records (Oracle)](https://docs.oracle.com/en/java/javase/16/language/records.html)  

**Пример решения**:  
```java
// Проверка валидации
try {
    new Transaction("TX1", 100, "USD"); // OK
    new Transaction("TX2", -50, "USD"); // Исключение
} catch (IllegalArgumentException e) {
    System.out.println(e.getMessage()); // "Сумма должна быть положительной"
}

// Проверка неизменяемости
Transaction tx = new Transaction("TX1", 100, "USD");
// tx.amount = 200; // Ошибка компиляции: поле final
```

---

### **5. Sealed Interfaces: Контроль иерархии типов**  
**Цель**: Ограничить наследование классов.  
**Задания** (опираются на records из п.4):  
1. Создайте sealed-иерархию:  
   ```java
   public sealed interface TransactionType permits Deposit, Withdrawal, Transfer {}
   
   public record Deposit(String id, double amount, String currency) 
       implements TransactionType {}
   
   public record Withdrawal(String id, double amount, String currency, String sourceAccount) 
       implements TransactionType {}
   
   public record Transfer(String id, double amount, String currency, String targetAccount) 
       implements TransactionType {}
   ```  
2. Добавьте класс `Loan`, не указанный в `permits` → убедитесь в ошибке компиляции.  
3. Напишите метод:  
   ```java
   public String process(TransactionType tx) {
       return switch (tx) {
           case Deposit d -> "Пополнение: " + d.amount();
           case Withdrawal w -> "Снятие: " + w.amount() + " со счета " + w.sourceAccount();
           case Transfer t -> "Перевод: " + t.amount() + " на счет " + t.targetAccount();
       };
   }
   ```  

**Контрольные вопросы**:  
- ❓ Почему sealed-интерфейсы безопаснее открытого наследования?  
- ❓ Что произойдет, если добавить новый тип в `permits` без обновления `switch`?  

**Ссылки**:  
- [Sealed Classes (Oracle)](https://docs.oracle.com/en/java/javase/17/language/sealed-classes-and-interfaces.html)  

**Пример решения**:  
```java
// Ошибка компиляции:
// public record Loan(...) implements TransactionType {} // Не разрешен в permits

// Проверка switch
TransactionType tx = new Withdrawal("W1", 50, "EUR", "ACC123");
System.out.println(process(tx)); // "Снятие: 50.0 со счета ACC123"
```

---

### **6. Generics: Типобезопасность для валют**  
**Цель**: Добавить поддержку строгой типизации валют.  
**Задания** (опираются на sealed-иерархию из п.5):  
1. Создайте:  
   ```java
   public sealed interface Currency permits USD, EUR, RUB {}
   public record USD(double amount) implements Currency {}
   public record EUR(double amount) implements Currency {}
   public record RUB(double amount) implements Currency {}
   ```  
2. Перепишите `TransactionType` с generics:  
   ```java
   public sealed interface TransactionType<T extends Currency> 
       permits Deposit, Withdrawal, Transfer {}
   
   public record Deposit<T extends Currency>(String id, T amount) 
       implements TransactionType<T> {}
   
   public record Withdrawal<T extends Currency>(String id, T amount, String sourceAccount) 
       implements TransactionType<T> {}
   ```  
3. Убедитесь, что:  
   - `new Deposit<>("D1", new USD(100))` компилируется.  
   - `new Deposit<>("D1", "100 USD")` не компилируется.  

**Контрольные вопросы**:  
- ❓ Почему `T extends Currency`? Что сломается без этого ограничения?  
- ❓ Как добавить поддержку криптовалют (например, `BTC`)?  

**Ссылки**:  
- [Generics (Oracle)](https://docs.oracle.com/javase/tutorial/java/generics/)  

**Пример решения**:  
```java
// Проверка типобезопасности
Deposit<USD> deposit = new Deposit<>("D1", new USD(100));
// Deposit<EUR> invalid = new Deposit<>("D1", new USD(100)); // Ошибка компиляции

// Обработка через switch
public String process(TransactionType<?> tx) {
    return switch (tx) {
        case Deposit<USD> d -> "Пополнение USD: " + d.amount().amount();
        case Withdrawal<EUR> w -> "Снятие EUR: " + w.amount().amount();
        default -> "Операция " + tx.getClass().getSimpleName();
    };
}
```

---

### **7. Sealed + Generics + Switch: Система обработки ошибок**  
**Цель**: Создать типобезопасную систему ошибок.  
**Задания** (опираются на п.6):  
1. Создайте:  
   ```java
   public sealed interface ProcessingResult<T> permits Success, Failure {}
   public record Success<T>(T data) implements ProcessingResult<T> {}
   public sealed interface Failure permits InsufficientFunds, InvalidCurrency {}
   public record InsufficientFunds(String msg) implements Failure {}
   public record InvalidCurrency(String currency) implements Failure {}
   ```  
2. Реализуйте обработку:  
   ```java
   public ProcessingResult<Double> process(TransactionType<?> tx, double balance) {
       return switch (tx) {
           case Withdrawal w when w.amount().amount() <= balance -> 
               new Success<>(balance - w.amount().amount());
           case Withdrawal w -> 
               new InsufficientFunds("Недостаточно средств");
           case Deposit d -> 
               new Success<>(balance + d.amount().amount());
           default -> throw new IllegalStateException("Неизвестный тип");
       };
   }
   ```  
3. Добавьте обработку `ProcessingResult` через switch:  
   ```java
   public String handleResult(ProcessingResult<?> result) {
       return switch (result) {
           case Success s -> "Успех: баланс " + s.data();
           case InsufficientFunds f -> "Ошибка: " + f.msg();
           case InvalidCurrency c -> "Валюта не поддерживается: " + c.currency();
       };
   }
   ```  

**Контрольные вопросы**:  
- ❓ Что произойдет, если добавить новый тип ошибки без обновления `handleResult`?  
- ❓ Почему `ProcessingResult` использует sealed вместо enum?  

**Ссылки**:  
- [Pattern Matching for switch (JEP 406)](https://openjdk.org/jeps/406)  

**Пример решения**:  
```java
// Проверка обработки ошибок
ProcessingResult<Double> result = process(
    new Withdrawal<>("W1", new USD(150), "ACC123"), 
    100
);
System.out.println(handleResult(result)); // "Ошибка: Недостаточно средств"
```

---

### **8. Итоговый проект: Полная система обработки транзакций**  
**Цель**: Объединить все навыки в рабочем приложении.  

#### **План решения и обоснование**  
1. **Sealed-иерархия типов** (п.5):  
   ```java
   public sealed interface TransactionType<T extends Currency> 
       permits Deposit, Withdrawal, Transfer {}
   ```  
   *Обоснование*: Гарантирует, что новые типы операций нельзя добавить случайно (как в п.5).  

2. **Generics для валют** (п.6):  
   ```java
   public record USD(double amount) implements Currency {}
   public record Deposit<T extends Currency>(String id, T amount) 
       implements TransactionType<T> {}
   ```  
   *Обоснование*: Позволяет работать с разными валютами без дублирования кода (как в п.6).  

3. **Records с валидацией** (п.4):  
   ```java
   public record Withdrawal<T extends Currency>(
       String id, 
       T amount, 
       String sourceAccount
   ) {
       public Withdrawal {
           if (sourceAccount == null || sourceAccount.isEmpty()) {
               throw new IllegalArgumentException("Счет отправителя обязателен");
           }
       }
   }
   ```  
   *Обоснование*: Убирает boilerplate, сохраняя неизменяемость и безопасность (как в п.4).  

4. **Обработка ошибок через sealed + switch** (п.7):  
   ```java
   public ProcessingResult<Double> process(TransactionType<?> tx, double balance) {
       return switch (tx) {
           case Withdrawal<USD> w when w.amount().amount() <= balance -> 
               new Success<>(balance - w.amount().amount());
           case Withdrawal<?> w -> 
               new InsufficientFunds("Недостаточно средств");
           // ...
       };
   }
   ```  
   *Обоснование*: Компилятор проверит обработку всех типов (как в п.7).  

#### **Критерии проверки**  
- При создании транзакции с `amount <= 0` возникает исключение (как в п.1).  
- `Deposit<USD>` принимает только `USD`, `Deposit<EUR>` — только `EUR` (как в п.6).  
- Метод `process()` обрабатывает все типы из sealed-иерархии (как в п.5).  

#### **Каверзные вопросы**  
- ❓ Что произойдет, если добавить `case default -> "Неизвестно";` в `switch`?  
  *Ответ*: Код скомпилируется, но компилятор предупредит, что обработка не полная (поскольку sealed гарантирует известные типы).  
- ❓ Почему `TransactionType<Currency>` менее безопасен, чем `TransactionType<USD>`?  
  *Ответ*: Разрешает смешивать валюты (USD/EUR), нарушая бизнес-логику (п.6).  

---

### **Почему это работает**  
1. **Последовательность**:  
   - Валидация суммы (п.1) → валидация в records (п.4) → обработка ошибок в итоговом проекте.  
   - Наследование (п.2) → sealed-иерархия (п.5) → типобезопасная обработка через `switch`.  

2. **Контролируемый результат**:  
   - Для каждой темы есть **конкретный тест-кейс** (например, `new Withdrawal(..., -50, ...)` → ошибка).  
   - Итоговый проект проверяет **практическое применение всех паттернов** (records + sealed + generics).  

3. **Минимум теории**:  
   - Records и sealed объясняются через **конкретные примеры** (без углубления в JVM).  
   - Generics вводятся только для решения задачи типобезопасности (п.6).  

**Пример рефакторинга на каждом этапе**:  
- **Было (Неделя 1)**:  
  ```java
  public class Withdrawal {
      private double amount;
      public boolean isValid() { ... } // Проверка баланса
  }
  ```  
- **Стало (Неделя 3)**:  
  ```java
  public record Withdrawal<T extends Currency>(
      String id, 
      T amount, 
      String sourceAccount
  ) implements TransactionType<T> {
      public ProcessingResult<Double> process(double balance) {
          return amount.amount() <= balance 
              ? new Success<>(balance - amount.amount()) 
              : new InsufficientFunds("Недостаточно средств");
      }
  }
  ```

Пример реализации: [GitHub-репозиторий с финансовой системой](https://github.com/example/java-financial-system).