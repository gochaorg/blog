Презентации
=============================
* Введение в систему сборки Apache Maven [pdf](01-intro.pdf), [odp](01-intro.odp)
* Создание дистрибутива средствами maven [pdf](02-distr.pdf), [odp](02-distr.odp)

Статьи
=============================

Введение в maven
----------------

* [Maven — зачем?](https://habr.com/ru/post/78252/)
* [Краткое знакомство с Maven](https://tproger.ru/articles/maven-short-intro/)
* [Вторая жизнь вместе с Maven](https://habr.com/ru/post/126966/) _фазы maven_
* [Поднимаем собственный Maven репозиторий Nexus на OpenShift](https://habr.com/ru/post/145936/)
* [Интеграционные тесты с Maven, JUnit и Spring](https://habr.com/ru/post/146984/)
* [Как ускорить сборку с Maven](https://habr.com/ru/post/304164/)
* [Maven, где мои артефакты? Еще одна статья про управление зависимостями](https://habr.com/ru/post/339902/)
* [Идеальный мавен. Часть 1](https://habr.com/ru/post/343550/)
* [Идеальный мавен. Часть 2: структура проекта](https://habr.com/ru/post/344480/)

Для удаленного репозитория JFrog Artifactory
--------------------------------------------

Перед использованием remote repo, необходимо выполнить несколько действий

1. [Настроить сервер JFrog Artifactory](docs/configure-jfrog-artifactory.md)
2. [Установить maven](docs/maven-install.md)
3. [Настроить maven](docs/maven-config.md)
4. [Настроить проект (pom.xml)](docs/pom.md)

Версионность в maven и релизы
------------------------------

* [Как работают номера версий в Maven](docs/artifact-versions.md)
* [Как эффективно использовать SNAPSHOT](docs/maven-snapshots.md)
* [Maven и управление релизами](docs/maven-releases.md)
* [Хранение и вывод версии в java-проекте](https://habr.com/ru/post/119466/)
* [Проблемы релиз-менеджмента maven проектов при CI подходе к разработке ПО](https://habr.com/ru/post/160145/)
* [Как мы делали сборки](https://habr.com/ru/post/154779/)
* [Девять кругов автоматизированного тестирования](https://habr.com/ru/post/168451/)
* [Разрешение конфликтов в транзитивных зависимостях — Хороший, Плохой, Злой](https://habr.com/ru/company/jugru/blog/191246/)
* [Релизим проект на Java с Maven на новый лад](https://habr.com/ru/post/424425/)
* [Опыт использования flatten-maven-plugin для упрощения версионирования в maven-проектах](https://habr.com/ru/company/1c/blog/449172/)
* [Опыт перевода Maven-проекта на Multi-Release Jar: уже можно, но ещё сложно](https://habr.com/ru/post/472312/)
* [Семантика средств разрешения зависимостей](https://habr.com/ru/company/oleg-bunin/blog/474106/)


Трюки
--------------

* [Модуляризация в JavaSE без OSGI и Jigsaw](https://habr.com/ru/post/317578/)
* [Как с помощью maven работать с библиотеками, которых в maven нет](https://habr.com/ru/company/lanit/blog/323008/)
* [Отображение разработчикам статуса контроля качества исходного кода в SonarQube](https://habr.com/ru/post/486904/)
* [Maven плагин для JPackage из Java 14](https://habr.com/ru/post/496850/)
* [CASE 1 - Использование SNAPSHOT](docs/case-snapshot.md)


Google переводы официальной документации
---------------------------------------

* [Настройка Maven](docs/official-configuring-maven.md)
* [Настройка для воспроизводимых сборок](docs/official-configuring-for-reproducible-builds.md)
* [Руководство по использованию Ant с Maven](docs/official-ant-maven.md)
* [Руководство по загрузке классов Maven](docs/official-maven-classloaders.md)
* [Использование зеркал для репозиториев](docs/official-mirror-settings.md)
* [Строительство для разных сред](docs/official-building-for-different-environments.md)
* [Настройка прокси](docs/official-configure-proxy.md)
* [Введение в профили сборки](docs/official-introduction-to-build-profiles.md)
* [Руководство по работе с несколькими модулями](docs/official-working-with-multiple-modules.md)