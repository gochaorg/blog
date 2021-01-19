// Пример подсчет хеша по частям

import xyz.cofe.common.Hash
import xyz.cofe.cbuffer.CFileBuffer
import xyz.cofe.fs.ByteSize

// Подсчитываемый файл
def file = new File( '/home/user/Загрузки/jdk-8u144-linux-x64.tar.gz' )
def blockSize = 1024*1024*16    // Размер хэш-блока
def buffSize = 1024*16          // Размер буфера чтения

if( !file.exists() ){           // Проверка наличия файла
	println "$file not exists"
	return
}

println "hash(s) of ${file.name} ${new ByteSize(file.length()).toStringRoundMin(2)}"
println "hash block size ${new ByteSize(blockSize)}"

// Создание файлового буфера
def fbuff = new CFileBuffer( file )

fbuff.fileLock()       // Блокирование файла
println "file locked"

def hash = new Hash()

long ptr = 0           // Указатель текущей позиции
Integer blockNum = 0   // Номер текущего блока

int wBNum = 4  // Кол-во цифр в номере блока
int wPos = 10  // Кол-во цифр в позиции

while( ptr < fbuff.size ){ // Читаем до конца файла
	Long beginIdx = ptr    // Начала блока
	Long endIdx = ptr + blockSize  // Конец блока
	if( endIdx > fbuff.size ){ // Последний блок усекается
		endIdx = fbuff.size    // до конца файла
	}
	ptr = endIdx
	blockNum++

	// Вычисление хэша
	byte[] hsh = hash.md5( fbuff, beginIdx, endIdx, buffSize )
	String hshStr = hash.toString( hsh )

	// Печать хэша
	print   "${blockNum.toString().padLeft(wBNum,'0')}: "
	print   "[ ${beginIdx.toString().padLeft(wPos,'0')} .. "
	print   "${endIdx.toString().padLeft(wPos,'0')} ) "
	println "$hshStr"
}

fbuff.fileUnlock()     // Разблокирование файла
println "file unlocked"