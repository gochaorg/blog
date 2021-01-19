#########################
# Настройка FTP
#########################

echo "############################################"
echo "# Изменение vsftpd.conf"
echo "############################################"

# Изменение vsftpd.conf
echo "<?php
	\$file = file( '/etc/vsftpd.conf' );
	\$replacing = array(
		 array( 'ptrn' => '/^anonymous_enable=YES.*/is', 'replace' => \"anonymous_enable=NO\\n\" )
		,array( 'ptrn' => '/^#local_enable=YES.*/is',    'replace' => \"local_enable=YES\\n\" )
		,array( 'ptrn' => '/^#?\s*write_enable\b.*/is',  'replace' => \"write_enable=YES\\n\" )
		,array( 'ptrn' => '/^#?\s*local_umask\b.*/is',  'replace' => \"local_umask=022\\n\" )
		,array( 'ptrn' => '/^#?\s*anon_upload_enable\b.*/is',  'replace' => \"anon_upload_enable=NO\\n\" )
		,array( 'ptrn' => '/^#?\s*anon_mkdir_write_enable\b.*/is',  'replace' => \"anon_mkdir_write_enable=NO\\n\" )
		,array( 'ptrn' => '/^#?\s*chroot_local_user\b.*/is',  'replace' => \"chroot_local_user=YES\\n\" )
	);

	foreach( \$file as \$line )
	{
		\$matched = false;
		foreach( \$replacing as \$repl )
		{
			\$ptrn = \$repl['ptrn'];
			\$rtxt = \$repl['replace'];
			if( preg_match( \$ptrn, \$line, \$mm ) )
			{
				echo preg_replace( \$ptrn, \$rtxt, \$line );
				\$matched = true;
				break;
			}
		}
		if( \$matched )
		{
			continue;
		}else{
			echo \$line;
		}
	}
?>" >chng-ftp.php
php chng-ftp.php >newvsftp.conf
mv /etc/vsftpd.conf /etc/vsftpd.conf.old
cp newvsftp.conf /etc/vsftpd.conf

# Применение настроек
/etc/init.d/vsftpd restart

