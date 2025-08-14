### **Практический план освоения тестирования в Java**  
**Стек:** Maven, JUnit 5, Cucumber, Mockito, Allure  
**Особенности:**  
- Каждая тема включает **контрольное задание** с кодом, который вы напишете.  
- **Каверзные вопросы** для проверки глубины понимания.  
- **Контролируемый результат:** чёткие критерии успешного выполнения.  

---

## **Модуль 1: Настройка Maven-проекта**  
### **Тема:** Инициализация проекта, управление зависимостями  
#### **Контрольное задание**  
1. Создайте Maven-проект:  
   ```bash
   mvn archetype:generate -DgroupId=com.test -DartifactId=testing-workshop -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
   ```
2. Добавьте в `pom.xml` зависимости для **JUnit 5** и **Maven Surefire Plugin**:  
   ```xml
   <dependencies>
     <dependency>
       <groupId>org.junit.jupiter</groupId>
       <artifactId>junit-jupiter-api</artifactId>
       <version>5.9.0</version>
       <scope>test</scope>
     </dependency>
   </dependencies>
   <build>
     <plugins>
       <plugin>
         <groupId>org.apache.maven.plugins</groupId>
         <artifactId>maven-surefire-plugin</artifactId>
         <version>3.0.0</version>
       </plugin>
     </plugins>
   </build>
   ```
3. Удалите тестовый класс `AppTest.java` из `src/test/java`.  

#### **Проверка результата**  
- Выполните:  
  ```bash
  mvn clean test
  ```  
- **Ожидаемый вывод:**  
  ```text
  [INFO] Tests run: 0, Failures: 0
  [INFO] BUILD SUCCESS
  ```

#### **Контрольные вопросы**  
1. **Простой:** Почему зависимость JUnit указана с `<scope>test</scope>`?  
   **Ответ:** Чтобы зависимость не попала в production-сборку.  

2. **Каверзный:** Что произойдет, если удалить `maven-surefire-plugin` из `pom.xml`?  
   **Ответ:** Тесты перестанут запускаться через `mvn test`, так как Surefire отвечает за выполнение тестов.  

---

## **Модуль 2: Юнит-тесты с JUnit 5**  
### **Тема:** Аннотации, проверка результатов, жизненный цикл тестов  
#### **Исходный код**  
Добавьте в `src/main/java/com/test/MathUtils.java`:  
```java
package com.test;

public class MathUtils {
    public int multiply(int a, int b) {
        return a * b;
    }

    public double divide(int a, int b) {
        return (double) a / b;
    }
}
```

#### **Контрольное задание**  
1. Напишите тесты в `src/test/java/com/test/MathUtilsTest.java`:  
   ```java
   package com.test;

   import org.junit.jupiter.api.*;
   import static org.junit.jupiter.api.Assertions.*;

   class MathUtilsTest {
       private MathUtils math;

       @BeforeEach
       void setUp() {
           math = new MathUtils();
       }

       @Test
       void multiply_PositiveNumbers_ReturnsCorrectResult() {
           assertEquals(6, math.multiply(2, 3));
       }

       @Test
       void divide_ByZero_ThrowsArithmeticException() {
           assertThrows(ArithmeticException.class, () -> math.divide(5, 0));
       }
   }
   ```

#### **Проверка результата**  
- Запустите:  
  ```bash
  mvn test
  ```  
- **Ожидаемый вывод:**  
  ```text
  Tests run: 2, Failures: 0
  ```

#### **Контрольные вопросы**  
1. **Простой:** Зачем используется `@BeforeEach`?  
   **Ответ:** Для инициализации объектов перед каждым тестом.  

2. **Каверзный:** Что произойдет, если заменить `assertEquals(6, math.multiply(2, 3))` на `assertEquals(6.0, math.multiply(2, 3))`?  
   **Ответ:** Тест упадет, так как `assertEquals` для `double` требует указания дельты (погрешности). Нужно использовать `assertEquals(6.0, math.multiply(2, 3), 0.001)`.  

---

## **Модуль 3: Параметризованные тесты и мокирование**  
### **Тема:** Параметризация, Mockito для изоляции зависимостей  
#### **Исходный код**  
Добавьте в `src/main/java/com/test/UserService.java`:  
```java
package com.test;

public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean isUserActive(String userId) {
        User user = userRepository.findById(userId);
        return user != null && user.isActive();
    }
}

interface UserRepository {
    User findById(String id);
}

class User {
    private final boolean active;
    User(boolean active) { this.active = active; }
    boolean isActive() { return active; }
}
```

#### **Контрольное задание**  
1. Добавьте зависимость Mockito в `pom.xml`:  
   ```xml
   <dependency>
     <groupId>org.mockito</groupId>
     <artifactId>mockito-core</artifactId>
     <version>5.2.0</version>
     <scope>test</scope>
   </dependency>
   ```
2. Напишите тест с моком:  
   ```java
   import static org.mockito.Mockito.*;
   import org.junit.jupiter.params.ParameterizedTest;
   import org.junit.jupiter.params.provider.CsvSource;

   class UserServiceTest {
       @ParameterizedTest
       @CsvSource({
           "user1, true, true",
           "user2, false, false",
           "user3, null, false"
       })
       void isUserActive_CorrectBehavior(String userId, String isActive, boolean expected) {
           UserRepository repo = mock(UserRepository.class);
           when(repo.findById(userId)).thenReturn(
               "null".equals(isActive) ? null : new User(Boolean.parseBoolean(isActive))
           );
           UserService service = new UserService(repo);
           assertEquals(expected, service.isUserActive(userId));
       }
   }
   ```

#### **Проверка результата**  
- Запустите тесты:  
  ```bash
  mvn test
  ```  
- **Ожидаемый вывод:**  
  ```text
  Tests run: 3, Failures: 0
  ```

#### **Контрольные вопросы**  
1. **Простой:** Зачем используется `@CsvSource` в параметризованном тесте?  
   **Ответ:** Для передачи набора тестовых данных в формате CSV.  

2. **Каверзный:** Что произойдет, если убрать `when(repo.findById(userId)).thenReturn(...)`?  
   **Ответ:** Мок вернет `null`, и тест упадет с `NullPointerException` при вызове `user.isActive()`.  

---

## **Модуль 4: BDD с Cucumber (можно пропустить)**  
### **Тема:** Фичи, шаги, интеграция с JUnit  
#### **Контрольное задание**  
1. Добавьте зависимости в `pom.xml`:  
   ```xml
   <dependency>
     <groupId>io.cucumber</groupId>
     <artifactId>cucumber-java</artifactId>
     <version>7.11.1</version>
     <scope>test</scope>
   </dependency>
   <dependency>
     <groupId>io.cucumber</groupId>
     <artifactId>cucumber-junit-platform-engine</artifactId>
     <version>7.11.1</version>
     <scope>test</scope>
   </dependency>
   ```
2. Создайте `src/test/resources/features/calculator.feature`:  
   ```gherkin
   Feature: Calculator
     Scenario: Add two numbers
       Given Calculator is initialized
       When I add 5 and 3
       Then Result should be 8
   ```
3. Реализуйте шаги в `src/test/java/com/test/steps/CalculatorSteps.java`:  
   ```java
   package com.test.steps;

   import com.test.MathUtils;
   import io.cucumber.java.en.*;
   import static org.junit.jupiter.api.Assertions.*;

   public class CalculatorSteps {
       private MathUtils math = new MathUtils();
       private int result;

       @Given("Calculator is initialized")
       public void calculator_initialized() {
           // Заглушка для шага
       }

       @When("I add {int} and {int}")
       public void i_add_and(Integer a, Integer b) {
           result = math.multiply(a, b); // ОШИБКА: здесь должно быть сложение!
       }

       @Then("Result should be {int}")
       public void result_should_be(Integer expected) {
           assertEquals(expected, result);
       }
   }
   ```
4. Создайте класс запуска:  
   ```java
   package com.test;

   import io.cucumber.junit.platform.engine.Cucumber;

   @Cucumber
   public class RunCucumberTest {}
   ```

#### **Проверка результата**  
- Запустите тесты:  
  ```bash
  mvn test
  ```  
- **Ожидаемый вывод:**  
  ```text
  1 scenario (1 failed)
  3 steps (1 failed, 2 passed)
  ```

#### **Контрольные вопросы**  
1. **Простой:** Как Cucumber связывает шаги из `.feature`-файла с Java-методами?  
   **Ответ:** Через регулярные выражения в аннотациях (`@When`, `@Then`).  

2. **Каверзный:** Почему тест падает, несмотря на корректные данные в `.feature`-файле?  
   **Ответ:** В методе `i_add_and` используется `multiply` вместо `add` (намеренная ошибка).  

---

## **Модуль 5: Отладка и отчеты (можно пропустить)**  
### **Тема:** Allure Report, анализ результатов  
#### **Контрольное задание**  
1. Добавьте в `pom.xml`:  
   ```xml
   <plugin>
     <groupId>io.qameta.allure</groupId>
     <artifactId>allure-maven</artifactId>
     <version>5.2.0</version>
     <configuration>
       <reportVersion>2.24.0</reportVersion>
     </configuration>
   </plugin>
   ```
2. Добавьте аннотацию в тест Cucumber:  
   ```java
   @io.cucumber.java.After
   public void attachScreenshot(Scenario scenario) {
       if (scenario.isFailed()) {
           // Заглушка для скриншота
       }
   }
   ```
3. Сгенерируйте отчет:  
   ```bash
   mvn clean test allure:report
   allure serve target/site/allure-maven-plugin
   ```

#### **Проверка результата**  
- В браузере откроется отчет Allure с:  
  - Вкладкой **Behaviors** (сценарии Cucumber).  
  - Вкладкой **Failures** (падающий тест из Модуля 4).  

#### **Контрольные вопросы**  
1. **Простой:** Как в Allure отметить тест как **flaky** (нестабильный)?  
   **Ответ:** Добавить аннотацию `@Flaky` или отметить вручную в интерфейсе.  

2. **Каверзный:** Почему в отчете Allure не отображаются шаги Cucumber, если не указать `cucumber-junit-platform-engine`?  
   **Ответ:** Без этого движка Cucumber не интегрируется с JUnit 5, и Allure не получает данные о шагах.  

---

## **Итоговый чек-лист**  
После прохождения всех модулей вы сможете:  
✅ Настроить Maven-проект для тестирования.  
✅ Писать юнит-тесты с JUnit 5 и параметризацией.  
✅ Мокать зависимости с Mockito.  
✅ Описывать сценарии в стиле BDD через Cucumber.  
✅ Генерировать отчеты Allure и анализировать результаты.  

**Каверзный финальный вопрос:**  
> В тесте Cucumber шаг `When I add 5 and 3` использует метод `multiply`. Как автоматизировать проверку, что все шаги Cucumber связаны с корректной бизнес-логикой?  
> **Ответ:**  
> 1. Использовать **Cucumber Expressions** для строгой типизации параметров.  
> 2. Добавить тест, который проверяет, что все шаги в `.feature`-файлах покрыты реализованными методами (через `cucumber-plugin` в IDE или скрипт анализа).  
> 3. Настроить **CI**, чтобы сборка падала при наличии нереализованных шагов.