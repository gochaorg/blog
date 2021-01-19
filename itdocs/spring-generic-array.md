spring generic array - bad idea
==================================

Имеем базовый класс

```java
public class Controller<E, ID extends Number & Serializable, R extends SomeRepository<E, ID>> {
  ...
  public @ResponseBody
    Object genList(
        @Autowired @Nullable Principal principal,
        @RequestBody List<ID> ids
    ) {
      ...
    }
  
    public @ResponseBody
    Object getArray(
        @Autowired @Nullable Principal principal,
        @RequestBody ID[] ids
    ) {
    }
  ...
}
```

Производный класс
```java
@RequestMapping(value = "/child")
public class ChildController extends Controller<Row, Long, RowRepo> { ... }
```

Так вот в экземпляре `ChildController` 

* метод `genList` аргмент `ids` будет иметь тип `List<Long>` и при передаче JSON `[ 123 ]` первый элемент будет типа **Long**
* метод `getArray` аргмент `ids` будет иметь тип `Number[]` и при передаче JSON `[ 123 ]` первый элемент будет типа **Integer**

spring boot 2.1.0
