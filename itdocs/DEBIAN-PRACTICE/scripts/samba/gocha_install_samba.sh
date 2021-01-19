#!/bin/bash
########################
# Установка SAMBA
########################
# Как автоматом вводить Рабочаю группу не понятно

#1) Указать рабочаю группу WORKGROUP"
#2) Указать НЕТ"
apt-get --force-yes -y install samba samba-doc smbclient

########################
# /etc/samba/smb.conf
########################

# Изменение /etc/samba/smb.conf
# Внести в [global]
# dos charset = 866"
# unix charset = utf-8"
#display charset = 1251"
#client code page = 1251"

#Изменить в [global]"
#security = user

#Изменить в [homes]"
##read only = no" # DEBIAN 5
#writable = yes" # DEBIAN 4
#create mask = 0775"
#directory mask = 0755"

nano /etc/samba/smb.conf

#############################
# SAMBA USERS
#############################
groupadd smb-user
useradd --gid smb-user director
useradd --gid smb-user bux
useradd --gid smb-user postavka
useradd --gid smb-user prodaga
useradd --gid smb-user suser


#Укажите пароль SMB для пользователя director"
smbpasswd -a director

#Укажите пароль SMB для пользователя bux"
smbpasswd -a  bux

#Укажите пароль SMB для пользователя postavka"
smbpasswd -a  postavka

#Укажите пароль SMB для пользователя prodaga"
smbpasswd -a  prodaga

#Укажите пароль SMB для пользователя suser"
smbpasswd -a  suser


##########################
# Настройка ресурсов
##########################
mkdir /home/samba
mkdir /home/samba/director
mkdir /home/samba/bookkeeper
mkdir /home/samba/deliveries
mkdir /home/samba/sales
mkdir /home/samba/docs
mkdir /home/samba/common

chgrp -v smb-user /home/samba/*
chmod -v g+w /home/samba/*

echo '
[director]
    path = /home/samba/director
    read only = no
    guest ok = no
    directory mask = 0775
    create mask = 0774
    valid users = director
    write list = director
[bookkeeper]
    path = /home/samba/bookkeeper
    read only = no
    guest ok = no
    directory mask = 0775
    create mask = 0774
    valid users = director, bux 
    write list = bux
    read list = director
[deliveries]
    path = /home/samba/deliveries
    read only = no
    guest ok = no
    directory mask = 0775
    create mask = 0774
    valid users = director, postavka
    write list = director, postavka
[sales]
    path = /home/samba/sales
    read only = no
    guest ok = no
    directory mask = 0775
    create mask = 0774
    valid users = director, postavka, prodaga
    write list = director, prodaga
    read list = postavka
[docs]
    path = /home/samba/docs
    read only = no
    guest ok = no
    directory mask = 0775
    create mask = 0774
    valid users = director, bux, postavka, prodaga, suser
    write list = director, postavka, prodaga
    read list = bux, suser
[common]
    path = /home/samba/common
    read only = no
    guest ok = no
    directory mask = 0775
    create mask = 0774
    valid users = director, bux, postavka, prodaga, suser
    write list = director, bux, postavka, prodaga, suser
' >> /etc/samba/smb.conf

/etc/init.d/samba restart
