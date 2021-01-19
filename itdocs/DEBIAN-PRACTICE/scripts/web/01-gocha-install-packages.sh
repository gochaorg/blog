#!/bin/bash
# Установка пакетов
echo "############################################"
echo "# Установка пакетов"
echo "############################################"

function check_install()
{
	echo "Проверка установлен или нет пакет \"$1\""
	dpkg-query -s $1 >/dev/null
	local r=$?
	if ! $r ; then
		echo "Пакет установлен"
		echo "Удаление пакета"
		apt-get -y --purge remove $1
		echo "Установка пакета"
		apt-get -y install $1
	else
		echo "Пакет не установлен, установка"
		apt-get -y install $1
	fi
}

#apt-get -y install vsftpd
#apt-get -y install apache2
#apt-get -y install libapache2-mod-php5
#apt-get -y install php5-mysql
#apt-get -y install mysql-server
#apt-get -y install php5 php5-cli

check_install vsftpd
check_install apache2
check_install libapache2-mod-php5
check_install php5-mysql
check_install mysql-server
check_install php5
check_install php5-cli
