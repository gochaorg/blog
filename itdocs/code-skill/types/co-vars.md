Ко-вариантность и типы данных
=============================

Тема вариантов в программировании вызывает кучу сложностей в понимании,
по мне это проблема в том, что в качестве объяснения берут 
не всегда успешные метафоры - контейнеры.

Я надеюсь что может у меня получиться объяснить эту тему с другой стороны используя 
метафоры "присвоения" в разрезе лямбд.

Зачем вообще эта вариантность нужна ?
---------------------------------------

В целом без вариантности можно жить и спокойно программировать, 
это не такая уж архиважная тема, у нас есть множество 
примеров языков программирования в которых это качество не отображено.

Ко-вариантность это о типах данных и их контроле со стороны компиляторов.
И ровно с этого места надо откатиться и сказать о типах данных и зачем это нам нужно.

### Flashback к типам

Типы данных сами по себе тоже не являются сверхважной темой, 
есть языки в которых тип данных не особенно нужны, например ассемблер, brainfuck, РЕФАЛ.

В том же РЕФАЛ или ассемблере очень легко перепутать к кому типу относиться переменная,
и очень легко, например можно допустить что из одной строки я вычту другую строку, 
просто опечатка, никакого злого умысла.

В языках с поддержкой типов, компилятор увидел бы это опечатку и не дал бы мне 
скомпилировать программу, но... например JS

    > 'str-a' - 'str-b'
    NaN

JS (JavaScript) Спокойно этот код проглатывает, мне скажут что это **не баг, это фича**, ок, допустим, 
тогда я возьму Python

    >>> 'str-a' - 'str-b'
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: unsupported operand type(s) for -: 'str' and 'str'

Или Java

    jshell> "str-a" - "str-b"
    |  Error:
    |  bad operand types for binary operator '-'
    |    first type:  java.lang.String
    |    second type: java.lang.String
    |  "str-a" - "str-b"
    |  ^---------------^

То есть я клоню к тому, что считать багом или фичей - зависит от создателей языка.

А мне как пользователю например вообще без разницы на 
каком языке написана та или иная программа, мне важно чтоб она работала.

А как программисту, решающему задачу конкретного пользователя, я выберу тот язык, 
который будет удобен мне для решения задачи и я не хотел бы 
сильно заварчиваться на особенности языков, 
знать особенности работы с тем или иным типом данным.

Еще пример: может быть такой мой сценарий, допустим вчера я написал на Groovy вот такой код

    groovy> def fun1( a, b ){
    groovy>   return a - b
    groovy> }
    groovy> println 'fun1( 5, 2 )='+fun1( 5, 2 )
    groovy> println "fun1( 'aabc', 'b' )="+fun1( 'aabc', 'b' )
    groovy> println 'fun1( [1,2,3,4], [2,3] )='+fun1( [1,2,3,4], [2,3] )
    
    fun1( 5, 2 )=3
    fun1( 'aabc', 'b' )=aac
    fun1( [1,2,3,4], [2,3] )=[1, 4]

А сегодня так на JS в другом проекте

    > fun1 = function( a, b ){ return a - b }
    [Function: fun1]
    > fun1( 5, 2 )
    3
    > fun1( 'aabc', 'b' )
    NaN
    > fun1( [1,2,3,4], [2,3] )
    NaN

И вот таких не совпадений типов данных может быть много 
и мне действительно надо знать особенности того или иного языка. 

Окей, я понимаю, что я сейчас выдумываю на ходу разные проблемы - но это не значит,
что прям сейчас надо бросать известный вам язык 
и переходить на другой язык программирования.

Речь о типах данных
---------------------

Вариантность как и ко/контр вариантность - это речь о типах данных 
и их отношениях между собой.

Некоторые языки программирования создавались, чтобы избежать выше описанных проблем.

Один из способов избежать - это введение системы типов данных.

Вот пример на языке TypeScript

    function sub( x : number, y : number ) {
        return x - y;
    }
    
    console.log( sub(5,3) )

Этот код успешно скомпилируется в JS.

А вот этот 

```typescript
function sub( x : number, y : number ) {
    return x - y;
}

console.log( sub("aa","bb") )
```

Уже не скомпилируется - и это хорошо:

    > tsc ./index.ts
    index.ts:5:18 - error TS2345: Argument of type 'string' is not assignable 
      to parameter of type 'number'.
    
    5 console.log( sub("aa","bb") )
    ~~~~
    
    
    Found 1 error.

В примере выше функция `sub` требует принимать в качестве аргументов 
переменные определенного типа, не любые, а именно `number`.

Контроль за типы данных я возлагаю уже компилятору TypeScript (`tsc`).

Инвариантность
------------------

Рассмотрим пока понятие Инвариантность, согласно определению

_**Инвариа́нт** — это свойство некоторого класса (множества) математических объектов, 
остающееся неизменным при преобразованиях определённого типа._

*Пусть A — множество и G — множество отображений из A в A. 
Отображение f из множества A в множество B называется инвариантом для G, 
если для любых a ∈ A и g ∈ G выполняется тождество f(a)=f(g(a)).*

Очень невнятное для не посвященных определение, давай те чуть проще:

_**Инвариантность** - это такое качество операций над данными, 
при котором тип данных в передаваемых в функцию и возвращаемый тип является один и тем же._

Рассмотрим пример операции присвоения переменной, в JS допускается вот такой код

    > fun1 = function( a, b, c ){
    ... let r = b;
    ... if( a ) r = c;
    ... return r + r;
    ... }
    [Function: fun1]
    > fun1( 1==1, 2, 3 )
    6
    > fun1( 1==1, "aa", "b" )
    'bb'
    > fun1( 1==1, 3, "b" )
    'bb'
    > fun1( 1!=1, 3, "b" )
    6
    > fun1( 1!=1, {x:1}, "b" )
    '[object Object][object Object]'


В примере переменная r - может быть и типа string и number и объектом, 
со стороны интерпретатора сказать какого типа данных возвращает функция fun1 нельзя, 
пока не запустишь программу.

Так же нельзя сказать какого типа будет переменная r.
Тип результата и тип переменной r зависит от типов аргументов функции.

Переменная r по факту может иметь два разных типа:

- В конструкции `let r = b`, переменная r будет иметь такой же тип, как и переменная b.
- В конструкции `r = c`, переменная r будет иметь такой же тип, как и переменная c.

В целом, такое не определенное поведение может сказаться 
на последующей логике поведения программы негативно.

Можно наложить явным образом ограничения на вызов функции 
и проверять какого типа аргументы, например так:

    > fun1 = function( a, b, c ){
    ... if( typeof(b)!=='number' )throw "argument b not number";
    ... if( typeof(c)!=='number' )throw "argument c not number";
    ... let r = b;
    ... if( a ) r = c;
    ... return r + r;
    ... }
    [Function: fun1]
    > fun1( true, 1, 2 )
    4
    > fun1( true, 'aa', 3 )
    Thrown: 'argument b not number'

Это уже лучше, хоть об ошибке мы узнаем, во время выполнения, 
но она уже не приведет к негативным последствиям.

Другой же аспект, в том что операция +, - и др... 
при операциях над числами - возвращают числа - это и есть **инвариантность** (в широком смысле), 
а вот при над числами и строками или различными типами данных - 
результат уже менее предсказуем.

В языках со строгой типизацией операция конструкция `let r = b` 
и следующая за ней `r = c` не допустима, 
она может быть допустима если мы укажем типы аргументов.

Пример Typescript:

```javascript
function fun1( a:boolean, b:number, c:number ){
    let r = b;
    if( a ) r = c;
    return r + r;
}

function fun2( a:boolean, b:number, c:string ){
    let r = b;
    if( a ) r = c;
    return r + r;
}
```

И результат компиляции

    > tsc ./index.ts 
    index.ts:9:13 - error TS2322: Type 'string' is not assignable to type 'number'.
    
    9     if( a ) r = c;
    ~
    
    
    Found 1 error.

Здесь в ошибки говориться явно, что переменная типа `string` 
не может быть присвоена переменной типа `number`.

**Вариантность** - в компиляторах, это проверка допустимости присвоения
переменной одного типа значения другого типа.

**Инвариантность** - это такой случай, когда переменной одного типа присваивается
(другая или эта же) переменная этого же типа.

Теперь вернемся к строгому определению: `выполняется тождество f(a)=f(g(a))`

То есть допустим у нас есть функции TypeScript:

```javascript
function f(a:number) : number {
    return a+a;
}

function g(a:number) : number {
    return a;
}

console.log( f(1)===f(g(1)) )
```

Этот код - вот прям сторого соответствует определению.

В контексте программирования _Инвариантность_ - это не свойство значения функций, 
а соответствие типов данных, т.е. вот код ниже абсолютно валиден

```javascript
function f(a:number) : number {
    return a+a;
}

function g(a:number) : number {
    return a-1;
}

let r = f(1)
r = f(g(1))
```

а такой код

```javascript
function f(a:number) : number {
    return a+a;
}

function g(a:number) : string {
    return (a-1) + "";
}

let r = f(1)
r = f(g(1))
```

Уже невалиден (не корректен), так как:

- функция g возвращает тип string
- а функция f требует тип number в качестве аргумента

и вот такую ошибку обнаружит компилятор TypeScript.

Первый итог
----------------

**Вариантность** и другие ее формы, как например _Ин/Ко/Контр вариантность_ - 
это качество операции присвоения значения переменной 
или передачи аргументов в функцию, в которой проверяется 
типы данных передаваемых/принимаемых в функцию и переменную.
