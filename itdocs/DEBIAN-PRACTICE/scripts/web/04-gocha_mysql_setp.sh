echo "############################################"
echo "Создание СУБД mysql/mp3"
echo "create database mp3;
use mp3;
CREATE TABLE mp3 (
	id int(11) NOT NULL,
	author varchar(250) NOT NULL,
	album varchar(250) NOT NULL,
	title varchar(250) NOT NULL,
	link text NOT NULL,
	PRIMARY KEY (id)
);
INSERT INTO mp3 (id, author, album, title, link) VALUES (105,'Игорь Федоров','Модель Для Сборки','Маленькие Заленые Нечеловечки', 'http://10.1.16.164/mds/rasskazi/024-Igor_Fedorov-Malenkie_zalenye_nechelovechki.mp3');
INSERT INTO mp3 (id, author, album, title, link) VALUES (106,'Юрий Никитин','Модель Для Сборки','Последний День Отпуска','http://10.1.16.164/mds/rasskazi/038Yurii_Nikitin-Poslednii_den_otpuska.mp3');
INSERT INTO mp3 (id, author, album, title, link) VALUES (107,'Василий Шукшин','Модель Для Сборки','До Третьих Петухов','http://10.1.16.164/mds/rasskazi/014Vasilii_Shukshin-Do_tretih_petuhov.mp3');
grant all privileges on mp3.* to 'mp3'@'%' identified by 'mp3';
exit" >sql

mysql -u root <sql

echo "<?php
	\$lines = file('/etc/mysql/my.cnf');
	foreach( \$lines as \$line )
	{
		if( preg_match( '/.*?bind-address.*/is', \$line ) )
		{
			echo \"bind-address = 0.0.0.0\n\";
		}else{
			echo \$line;
		}
	}
?>" >ch-my-cnf.php

php ch-my-cnf.php >_my.cnf
mv /etc/mysql/my.cnf my.cnf.old
cp _my.cnf /etc/mysql/my.cnf

# Применение настроек
/etc/init.d/mysql restart

