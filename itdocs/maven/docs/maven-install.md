Установка maven
=================

На компьютере пользователя должна быть установлена JAVA 
и прописана переменная окружения JAVA_HOME до каталога java
 
Например так: `JAVA_HOME=C:\Program Files\Java\jdk1.8.0_251`
 <br> ![im](img/env-path-05.png)

1. Зайти на официальный сайт https://maven.apache.org/download.cgi
2. Скачать актуальную версию **Binary zip archive**
3. Распокавать в любой удобный каталог на рабочей машине <br> ![im](img/env-path-04.png)
4. Добавить в пути (PATH) путь до каталога _распакованный архив_\bin
   * Для ОС Windows 10+
     * Открыть окно **Учетные записи пользователей**
       * Выбрать пункт **Изменение переменных среды**  <br> ![im](img/env-path-01.png)
     * В появившимся окне **Переменные среды**
       * Выбрать переменную **Path** в списке **Переменные среды пользователя для** _XXXX_
       * Нажать кнопку **Изменить ...**  <br> ![im](img/env-path-02.png)
     * В Окне **Изменить переменную среды**
       * Нажать кнопку **Создать**
       * Добавить путь до каталога _распакованный архив_\bin
       * Нажать кнопку **ОК**  <br> ![im](img/env-path-03.png)
     * Закрыть окно **Переменные среды** нажав кнопку **ОК**
     * Если есть открытые терминалы (cmd.exe - командная строка), то перезапустить их, чтоб применились новые значения
5. Проверте работу maven <br>
  Выполните в командной строке `mvn -version`. Должно отобразиться примерно такой текст: <br> ![mvn](img/mvn-version-01.png)


После установки, переходите к дальнейшей [настройке репозитариев](maven-config.md).