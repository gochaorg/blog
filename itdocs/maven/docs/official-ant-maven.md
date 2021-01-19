Руководство по использованию Ant с Maven
========================================

В приведенном выше примере показано, как привязать сценарий муравья к фазе жизненного цикла. Вы можете добавить сценарий к каждой фазе жизненного цикла, продублировав выполнение / раздел и указав новую фазу.

```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <artifactId>my-test-app</artifactId>
    <groupId>my-test-group</groupId>
    <version>1.0-SNAPSHOT</version>
    <build>
    <plugins>
        <plugin>
        <artifactId>maven-antrun-plugin</artifactId>
        <version>1.7</version>
        <executions>
            <execution>
            <phase>generate-sources</phase>
            <configuration>
                <tasks>
    
                <!--
                    Place any ant task here. You can add anything
                    you can add between <target> and </target> in a
                    build.xml.
                -->
    
                </tasks>
            </configuration>
            <goals>
                <goal>run</goal>
            </goals>
            </execution>
        </executions>
        </plugin>
    </plugins>
    </build>
</project>
```

Таким образом, конкретный пример будет примерно таким:

```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <artifactId>my-test-app</artifactId>
    <groupId>my-test-group</groupId>
    <version>1.0-SNAPSHOT</version>
    <build>
    <plugins>
        <plugin>
        <artifactId>maven-antrun-plugin</artifactId>
        <version>1.7</version>
        <executions>
            <execution>
            <phase>generate-sources</phase>
            <configuration>
                <tasks>
                <exec
                    dir="${project.basedir}"
                    executable="${project.basedir}/src/main/sh/do-something.sh"
                    failonerror="true">
                    <arg line="arg1 arg2 arg3 arg4" />
                </exec>
                </tasks>
            </configuration>
            <goals>
                <goal>run</goal>
            </goals>
            </execution>
        </executions>
        </plugin>
    </plugins>
    </build>
</project>
```