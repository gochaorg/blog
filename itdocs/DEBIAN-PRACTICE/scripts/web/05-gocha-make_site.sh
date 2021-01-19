#!/bin/bash

echo "#############################################";
echo "# Создание каталога под сайт";
echo "# /home/webuser/site";
echo "#############################################";

mkdir "/home/webuser/site"
ln -s /home/webuser/site /var/www/site

echo "#############################################";
echo "# Создание файла readdb.php";
echo "#############################################";

echo "<html>
    <head>
       <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
       <title>read db</title>
    <head/>
    <body>
<?php
    /* Connecting, selecting database */
    \$link = mysql_connect(\"localhost\", \"mp3\", \"mp3\") or die(\"Could not connect\");
    echo \"Connected successfully\" ;
    mysql_select_db(\"mp3\") or die(\"Could not select database\");
    //mysql_query( \"set names 'utf8'\" ) or die( \"query set names failed\" );
    /* Performing SQL query */
    \$query = \"SELECT * FROM mp3\";
    \$result = mysql_query(\$query) or die(\"Query failed\");
    /* Printing results in HTML */
    echo \"<table border='1' width='100%'>\n\";
    for( \$col_idx=0; \$col_idx<mysql_num_fields(\$result); \$col_idx++ )
    {
       echo \"<td><b>\";
       echo htmlspecialchars(mysql_field_name(\$result,\$col_idx));
       echo \"</b></td>\";
    }
    while (\$line = mysql_fetch_array(\$result, MYSQL_ASSOC))
    {
       echo \"\t<tr>\n\" ;
         foreach (\$line as \$col_value)
         {
           echo \"\t\t<td>\";
           echo htmlspecialchars(\$col_value);
           echo \"</td>\n\";
         }
       echo \"\t</tr>\n\" ;
    }
    echo \"</table>\n\" ;
    /* Free resultset */
    /* Closing connection */
    mysql_close(\$link);
?>
    </body>
<html>" >readdb.php

mv "readdb.php" "/home/webuser/site/readdb.php"

chmod ugo+r "/home/webuser/site/readdb.php"
chmod ug+w "/home/webuser/site/readdb.php"
chmod o-w "/home/webuser/site/readdb.php"

chown webuser "/home/webuser/site/readdb.php"

echo "#############################################";
echo "# Рестарт apache";
echo "#############################################";
/etc/init.d/apache2 restart