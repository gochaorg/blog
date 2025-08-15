Карта для начала
=================================

```mermaid
flowchart TB

start((start)) --> pp

test1[Тестирование / JUnit]

pp[процедурное программирование]
pp --> oop1["ООП, простая 'база'"]
oop1 --> oop2
oop2 --> maven
oop1 --> gc --> errs
maven --> test1

ppc1@{ shape: braces, label: "Базовый синтаксис без ООП, <br> сборка приложения, <br> debug" } -.-> pp
oop1c1@{ shape: braces, label: "Классы, наследование, интерфейсы, <br> sealed <br> generics без ко-вариации" } -.-> oop1
pp -.-> | можно сразу писать тесты <br> разобраться только <br> с maven dependency, тестами| test1

oop1 --> errs

subgraph oop2["Углубленное освоение ООП и доп тем"]
  coll1[коллекции]
  gen1[Generics с Ко-вариациями]
  lambda1[Лямбды]
end

subgraph errs[ошибки и исключения]
  tcf[try, catch, finally]
  err_h[Иерархия ошибок]
  log[Логирование]
end

lambda1 --- tcf
log --- maven

subgraph maven
 m_dep[Зависимости]
 m_m[Модули]
 m_t[Тестирование]
 m_dist[Сборки дистрибутива]
 m_deploy[Поставка на сервер / Deploy]
 m_docs[Документирование]
end

subgraph gc[Garbage Collector]
  direction TB
  gc1[Создание и удаление объектов]
  gc2[Создание искусственной утечки памяти]
  gc3[Работа с различными типами ссылок]
  gc4[Эксперимент с finalize]
  gc5[Настройка параметров кучи]
  gc1 --> gc2 --> gc3 --> gc4 --> gc5
end

click pp "https://github.com/gochaorg/blog/blob/master/itdocs/learn-java/01-proc.md"
```