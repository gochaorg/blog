Организация памяти
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
        Registers
        MMU
        TLB[Translation Lookaside Buffer]
        CPUCache
        WriteBuffer
        PrefetchBuffer
        ReorderBuffer[Reorder Buffer, ROB]
        TagRAM["Кэш тегов (Tag RAM)"]
    end

    DMA
    SouthBridge
    CPU <--> SystemBus <--> NorthBridge <--> RAM
    NorthBridge <--> DMA
    NorthBridge <--> GPU
    NorthBridge <--> SouthBridge
    NorthBridge --> |Контролирует L2,L3| CPUCache

    ROM[ROM, Bios, UEFI]
    IOBuffers

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
- 
