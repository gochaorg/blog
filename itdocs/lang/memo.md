Организация памяти - базовые концепты
================================

Как организована память в совменных ОС, и современных языках программирования - как это инженерно решено
и как это влияет на написание стабильных программ - оооочень большая тема

```mermaid
flowchart TD

subgraph S[Схематехника]
  SLogic[Булева логика на транзисторах]  
  SBit["Бит памяти <br> RS/D Триггер"]
  SRegister[Регистр]
  SDecoder["(Де)Кодеры <br> (Де)Шифраторы"]
  SArifmetic[Сумматор]
  DRAM
  SRAM
  DDR
  SBit -.-> DRAM -.-> DDR
  SBit -.-> SRAM
  SLogic --> SBit --> SRegister --> SDecoder --> SArifmetic
end

subgraph StateMache[State machine]
    subgraph BlackBox[Автомат]
        SMInput[Входные данные]
        SMOutput[Выходные данные]
        SMState[Состояние]
        SMCode[Некий код]
    end

    BlackBox --> SMFinitive["(Бес)Конечные"]
    BlackBox --> SMDeterm["(Не)Детерменированные"]
end

SMState <--> SBit
SMCode <--> SArifmetic

StateMache --> |Любой язык программирования - это конечный автомат| SomeLanguage[Некий язык]

    subgraph TurnMachine
        TurningMachine[Машина тюринга]
        BrainFuck
        FonNaiman[Фон Найман архитектура]

        TurningMachine --> BrainFuck
        TurningMachine --> FonNaiman
    end


subgraph ComputerArch[Архитектура компютера]
    SystemBus[Системная шина]

    subgraph CPU
    end

    DMA
    SouthBridge
    CPU <--> SystemBus <--> NorthBridge <--> RAM
    NorthBridge <--> DMA
    NorthBridge <--> GPU
    NorthBridge <--> SouthBridge

end

ComputerArch --> |Теоритическая основа для понимания| StateMache
ComputerArch --> |Инженерное решение| S
```

- [Базавая схематехника, логика](https://codeby.school/blog/informacionnaya-bezopasnost/proektiruem-svoy-kompyuter-nachalo)
- [Элементарная ячейка памяти](https://codeby.school/blog/informacionnaya-bezopasnost/elementarnaya-yacheyka-pamyati-proektiruem-svoy-kompyuter-chast-2)
- [Регистр](https://codeby.school/blog/informacionnaya-bezopasnost/registr-proektiruem-svoy-kompyuter-chast-3)
- [Декодер и оперативная память](https://codeby.school/blog/informacionnaya-bezopasnost/dekoder-i-operativnaya-pamyat-proektiruem-svoy-kompyuter-chast-4)
- [Дешифратор](https://ru.wikipedia.org/wiki/%D0%94%D0%B5%D1%88%D0%B8%D1%84%D1%80%D0%B0%D1%82%D0%BE%D1%80)
- [Декодеры и кодеры](https://course-cst.narod.ru/lec_page12.html)
- [Арифметико-логическое устройство — Проектируем свой компьютер](https://codeby.school/blog/informacionnaya-bezopasnost/arifmetiko-logicheskoe-ustroystvo-proektiruem-svoy-kompyuter-chast-5)

Как это может быть полезно, для программиста

- Машина Тюринга, Конечные автоматы - с этим вы постоянно будете иметь дело, элементарное знание терминов прям сильно облегчат проектирование программ
- СхемаТехника - по большей части программисту не особо нужна, но элементарное знание железа, поможет правильно проектировать те же сервера, СхемаТехника выполняет роль граммонтности, как знание чем римские цифры отличаются от арабских

Архитектура компютера
======================

Архитектура компютера - тут вопрос уже интереснее, в зависимости от вашей роли на проекте и решаемых задач

```mermaid
graph TD
    subgraph CPU ["CPU (Центральный процессор)"]
        Fetch["Fetch (Выборка инструкций)"]
        Decode["Decode (Декодирование инструкций)"]
        InstQueue["Instruction Queue (Очередь инструкций)"]
        Sched["Scheduler (Планировщик команд)"]
        ALU["ALU (Арифметико-логическое устройство)"]
        FPU["FPU (Модуль с плавающей точкой)"]
        Branch["Branch Predictor (Предсказатель переходов)"]
        Reorder["Reorder Buffer (Буфер переупорядочивания)"]
        Regs["Регистры"]
        Buffers["Buffers (Буферы чтения/записи)"]
        CacheL1["L1 Cache"]
        CacheL2["L2 Cache"]
        CacheL3["L3 Cache"]
        MMU["MMU (Блок управления памятью)"]
    end

    Fetch -->|"Получает инструкции из кеша L1"| CacheL1
    CacheL1 -->|"?"| CacheL2
    CacheL2 -->|"?"| CacheL3
    Fetch -->|"Подаёт инструкции в Decode"| Decode
    Decode -->|"Разбирает инструкцию и отправляет в очередь"| InstQueue
    InstQueue -->|"Передаёт задачи планировщику"| Sched
    Sched -->|"Направляет команды в ALU"| ALU
    Sched -->|"Направляет команды в FPU (если требуется)"| FPU
    Sched -->|"Связывается с предсказателем переходов"| Branch
    ALU -->|"Запись результатов в регистры"| Regs
    FPU -->|"Запись результатов в регистры"| Regs
    Regs -->|"Обратная связь к ALU/FPU"| ALU
    Regs -->|"?"| FPU
    ALU -->|"Результаты попадают в Reorder Buffer"| Reorder
    FPU -->|"?"| Reorder
    Reorder -->|"Завершённые инструкции возвращаются в правильном порядке"| Buffers
    Buffers -->|"Передача данных/адресов в MMU"| MMU
    MMU -->|"?"| CacheL1

    DMA["DMA (Прямой доступ к памяти)"]
    NB["NorthBridge (Северный мост)"]
    SB["SouthBridge (Южный мост)"]
    RAM["ОЗУ (Оперативная память)"]
    GPU["GPU (Видеокарта)"]
    Storage["Хранилище (SSD/HDD)"]
    IO["Периферия (USB, аудио и пр.)"]
    PCI["Шина PCI/PCIe"]
    BIOS["BIOS/UEFI"]
    Clock["Тактовый генератор"]

    CPU --> NB
    MMU --> RAM
    DMA --> RAM
    DMA --> NB
    NB --> RAM
    NB --> GPU
    NB --> CPU
    NB --> SB
    SB --> IO
    SB --> Storage
    SB --> BIOS
    SB --> PCI
    SB --> Clock

    GPU -->|через| PCI
    Storage -->|может быть через| PCI

    BIOS --> CPU
```
- Знание, что находиться вне процессора (CPU), BIOS/SSD/... это элементарная граммотность как пользователя компютера
- Знание что внутри CPU, и как оно устроено и связано с внешним - напрямую связано с 2мя разделами: HighLoad и MultiThreading


Организация памяти процесса
==============================

![image](https://github.com/user-attachments/assets/bdb26091-70c7-4ec7-a977-b73f1c63f99e)

```mermaid
graph LR

subgraph Proc1
    Code1["Код (.text)"]
    Data1["Данные (.data)"]
    BSS1["Неинициализированные переменные (.bss)"]
    ROData1["Статические константы (строки, таблицы)"]
    DynData1["Данные для связывания DLL/SO и кода"]
    EnterExit1["Указатели на функции аля Start/Stop"]
    subgraph ProcRTRAM1["Память процесса 1"]
        Heap1[Heap]
        Stack1[Stack]
        mmap1a["mmap(Lib1)"]
        mmap1b["mmap(some file)"]
    end
end

subgraph Proc2
    subgraph ProcRTRAM2["Память процесса 2"]
        Heap2[Heap]
        Stack2[Stack]
        mmap2a["mmap(Lib1)"]
        mmap2b["mmap(some file)"]
    end
end


subgraph Lib1
direction LR
    Code3["Код (.text)"]
    Data3["Данные (.data)"]
    BSS3["Неинициализированные переменные (.bss)"]
    ROData3["Статические константы (строки, таблицы)"]
    DynData3["Данные для связывания DLL/SO и кода"]
    EnterExit3["Указатели на функции аля Start/Stop"]
end

mmap1a <---> mmap2a
mmap1b <---> mmap2b
mmap1a --> Lib1
mmap2a --> Lib1
```
