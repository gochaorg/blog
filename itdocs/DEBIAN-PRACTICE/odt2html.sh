#!/bin/bash

function help()
{
	echo "help"
	echo "  odt2html odt_file output_dir" 
}

function check_dir()
{
	# Второй параметр
	# Является каталог, который можно записывать
	[ \( -d "$1" \) -a \( ! \( -w "$1" \) \) ] && echo "can't write $1" && exit 1
	[ \( ! \( -d "$1" \) \) -a \( -e "$1" \) ] && echo "$1 is not directory" && exit 1

	# Если нет такого каталога, то пытаемся его создать
	if ! [[ -d "$1" ]] && ! [[ -e "$1" ]] ; then
	  echo "try make dir \"${1}\""
	  mkdir "$1"
	  res=$?
	  if [[ "${res}" != "0" ]] ; then
	  	echo "can't create directory \"${1}\""
	  	exit 1
	  fi
	  echo "directory \"${1}\" created"
	fi
}

# Проверка первго параметра
# Присуствет ?
[ "$1" = "" ] && help && exit 1;

# Можно читать ?
[ ! -r "$1" ] && echo "can't read $1" && exit 1

inputfile="$1"
outdir="$2"
tmpdir="$2-odt-tmp"
outfile=`basename "${inputfile}" .odt`
outfile="${outdir}/${outfile}.html"

check_dir "${outdir}"
check_dir "${tmpdir}"

echo "unzip file \"${inputfile}\""
unzip -o "${inputfile}" -d "${tmpdir}"
res=$?
if [[ "${res}" != "0" ]] ; then
	echo "can't unzip \"${inputfile}\" to \"${tmpdir}\""
	exit 1
fi
echo "unzipped"

echo "convert \"${tmpdir}/content.xml\" to ${outfile}"
xsltproc "oo2html.xslt" "${tmpdir}/content.xml" > "${outfile}"
res=$?
if [[ "${res}" != "0" ]] ; then
	echo "can't convert \"${tmpdir}/content.xml\" to \"${outfile}\""
	exit 1
fi

#rm -rf "${tmpdir}"

