#!/bin/bash

# Создание пользователя webuser и пароля webuser

echo "#####################################################"
echo "# Создание пользователя webuser <- пароль webuser"
echo "#####################################################"

function check_exists_user()
{
	cat "/etc/passwd" | grep "^$1"
	local r=$?;
	return $r;
}

if ! ( check_exists_user "webuser" ) ; then
	echo "Создание пользователя"
	useradd -m webuser
	usermod -U webuser
else
	echo "Пользователь webuser уже существует"
	usermod -U webuser
fi

#[ ! ( check_exists_user "webuser" ) ] || useradd -m "webuser"
echo "Указание пароля \"webuser\""
echo "webuser:webuser" | chpasswd

usermod -U webuser
usermod -s `which bash` webuser
if [[ ! ( -d "/home/webuser" ) ]] ; then
	echo "Создание домашней директории"
	mkdir "/home/webuser"
	chown webuser "/home/webuser"
	chmod u+wx "/home/webuser"
	usermod -d "/home/webuser" webuser
else
	echo "Указание домашней директории /home/webuser"
	chown webuser "/home/webuser"
	chmod u+wx "/home/webuser"
	usermod -d "/home/webuser" webuser
fi

