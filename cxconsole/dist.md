Дистрибутив
======================

Дистрибутив поставляется в следующих видах

* compact - компактный набор
* portable-win32 - переносимый набор, с java (openjdk 32 bit windows)
* portable-win64 - переносимый набор, с java (openjdk 64 bit windows)
* portable-winany - переносимый набор, с java (openjdk 32+64 bit windows)

Структура
------------------

* **bin/** - Каталог с исполняемыми программами
	* **[cxconsole](key-features.md)** - Графическая консоль
	* **[jsr233script](jsr233launcher.md)** - Выполнение скриптов (jsr233)
	* **[cxgroovy](cxgroovylauncher.md)** - Выполнение groovy скриптов
* **doc/** - Каталог с документацией
* **lib/** - Каталог с jar/dll файлами
	* **dll/** - Каталог dll файлами
		* **win32/** - Каталог dll файлами для windows 32bit
		* **win64/** - Каталог dll файлами для windows 64bit
    * **jar/** - Каталог jar файлов
* **samples/** - Каталог с примерами
	* **jsr233script/** - Каталог с примерами скриптов (jsr233)
* **java/** - Каталог с java
	* **win32/** - 32bit версия java
	* **win64/** - 32bit версия java

Ссылки
--------------------

| Версия                    | сборка          | ссылка | зеркало
|---------------------------|-----------------|--------|-------
| 0.2.0-SNAPSHOT-2018-07-29 | compact         | [yandex](https://yadi.sk/d/qqJovQq73ZgwEQ) | [google](https://drive.google.com/open?id=1NFFZ8gcnsxfDwFUcpc9h8Znm7ocG2LMH)
| 0.2.0-SNAPSHOT-2018-07-29 | portable-win32  | [yandex](https://yadi.sk/d/gHhJ-NHU3ZgwV3) | [google](https://drive.google.com/open?id=1yOIYWbS-7Wk_HxiOiLKIL0-REd1DSvvm)
| 0.2.0-SNAPSHOT-2018-07-29 | portable-win64  | [yandex](https://yadi.sk/d/cQRRV9533ZgwWN) | [google](https://drive.google.com/open?id=13o3vnzJyfnX8frQEMv52HaqmBOYfoEsU)
| 0.2.0-SNAPSHOT-2018-07-29 | portable-winany | [yandex](https://yadi.sk/d/5LJAks5-3ZgwYB) | [google](https://drive.google.com/open?id=10QASvc6J_3H67LGsrMP-xJKf_hmFGGEu)

Контрольные ссуммы

| md5                              | file
|----------------------------------|-----------------------------------------------
| 8094b336b3d7be82b36c2d7b870d4b11 | compact-0.2.0-SNAPSHOT-2018-07-29.zip
| 5680c3863163ce5a6cf2ccf62a079fc9 | portable-win32-0.2.0-SNAPSHOT-2018-07-29.zip
| 9aebcf27b7dcb6df315783a190f00567 | portable-win64-0.2.0-SNAPSHOT-2018-07-29.zip
| a57718036866894f4c01ea80703191ae | portable-winany-0.2.0-SNAPSHOT-2018-07-29.zip
