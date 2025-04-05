Языки программирования, структурное разделение теории по языкам
====================================================================

Любой язык программирования можно уложить в обхем виде так,

В явном или не явном виде присуствуют эти понятия в любом языке, если отсуствуют, то стоит задаться вопросом, а как в рамках языка и сообщества, жти вопросы решаются.

```mermaid
flowchart LR

L["Some language"]
L-->G[Grammar]
L-->T["Type system"]
G-->Lex[Lexems]
G-->Syntax
G-->Semantic
T-->DT[Dynamic typing]
T-->ST[Static typing]
DynSt_Ty[Dynamic + Static typing]
DT -.-> DynSt_Ty
ST -.-> DynSt_Ty
Semantic --> | Check type in Compile time | ST
RT[Run Time]
RT --> RAM --> GC
T --- |some types use gc| GC
L --> Tools
Tools --> IDE
Tools --> Debug
Tools --> DeCompile
Tools --> Documentations
Tools --> Build --> Compiler
Build --> Package 
Package --> DownloadPKG
Package --> UploadPKG
Build -.- Documentations
Syntax --> SynSplitFiles["splitting source code to differect files"]
Syntax --> SynVars["variables"]
Syntax --> Flow["Flow execution"]
Syntax --> IO["I/O send/recieve some data"]
IO --> RWVars["read/write variables"]
IO --> CallFn["call functions & accept results"]
RWVars -.-> AsyncIO
CallFn -.-> AsyncIO
Flow --> Condition["any branch of execution: if / match / switch"]
Flow --> Cycles
Cycles --> PrimitiveCycles
Cycles --> Recusion
SynVars --> DeclVars
DeclVars --- Allocations
SynVars --> AssignVars
AssignVars --- Allocations
T --- |starting app, load lib, etc ...| RT
RAM --> RamHeap
RAM --> RamStack
GC --- RamHeap
GC --- RamStack
RT --> TH[Multi Threading]
Lex --> PrimitiveTypes
Flow --> FunCall
FunCall -.- Recusion
FunCall -.- IO
FunCall -.- SynVars
SynSplitFiles --- Build
Syntax --> Scope
Syntax --> Decl
Decl --> SynVars
Scope --> Decl
Decl --> Fun
FunCall --- Fun
ST ==> |control avaiblity| Flow
Decl --> CustomTypes
CustomTypes --- |Fun as type| Fun
TH --- GC
TH ==> |locks| Flow
GC ==> |locks| Flow
Flow --> SynVars
TH --- AsyncIO

```

- Стрелками показано либо влияние, либо деление
- Без стрелок - наличие прямой связи, или косвенной (пунктир)
- Жирные стрелки - наиболее "топкие" места для новичков, по сколько для них, это обычно кажуться простыми, но как они работают, не знают, и по факту являются магией, а потом ловят ошибки

- [TypeSystem](https://ru.wikipedia.org/wiki/%D0%A1%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D0%B0_%D1%82%D0%B8%D0%BF%D0%BE%D0%B2)
  - [Dynamic typing](https://ru.wikipedia.org/wiki/%D0%94%D0%B8%D0%BD%D0%B0%D0%BC%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F_%D1%82%D0%B8%D0%BF%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F)
  - [Static typing](https://ru.wikipedia.org/wiki/%D0%A1%D1%82%D0%B0%D1%82%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F_%D1%82%D0%B8%D0%BF%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F)
  - [Run time](https://ru.wikipedia.org/wiki/%D0%A1%D1%80%D0%B5%D0%B4%D0%B0_%D0%B2%D1%8B%D0%BF%D0%BE%D0%BB%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F)
- [Grammar](https://ru.wikipedia.org/wiki/%D0%A4%D0%BE%D1%80%D0%BC%D0%B0%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F_%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B0%D1%82%D0%B8%D0%BA%D0%B0)
- [Tools](https://tproger.ru/articles/ot-novichka-k-profi--5-klyuchevyh-instrumentov-dlya-kazhdogo-razrabotchika)
