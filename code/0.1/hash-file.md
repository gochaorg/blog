Пример подсчета хэш блоков
==========================

```groovy
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

int wBNum = 4          // Кол-во цифр в номере блока
int wPos = 10          // Кол-во цифр в позиции

while( ptr < fbuff.size ){         // Читаем до конца файла
	Long beginIdx = ptr            // Начала блока
	Long endIdx = ptr + blockSize  // Конец блока
	if( endIdx > fbuff.size ){     // Последний блок усекается
		endIdx = fbuff.size        // до конца файла
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
```

Результат будет
---------------

    OUT> hash(s) of jdk-8u144-linux-x64.tar.gz 176.92mb
    OUT> hash block size 16mb
    OUT> file locked
    OUT> 0001: [ 0000000000 .. 0016777216 ) E256A9194654D12CFB7C69CE54DB0A4C
    OUT> 0002: [ 0016777216 .. 0033554432 ) 44F421CCE8C8E43D456CCACBBFC5B98D
    OUT> 0003: [ 0033554432 .. 0050331648 ) DC433F3279493222543D9FAD41A4A419
    OUT> 0004: [ 0050331648 .. 0067108864 ) 7EF2AD936AF4CD0B31FF40156E49ABDE
    OUT> 0005: [ 0067108864 .. 0083886080 ) 38316ACBCF92C28179233FBF409E65E2
    OUT> 0006: [ 0083886080 .. 0100663296 ) 3EC5C75763030E3A85ED344E1CA279E7
    OUT> 0007: [ 0100663296 .. 0117440512 ) AD7DE706CA2E41655D982578D85C5D9C
    OUT> 0008: [ 0117440512 .. 0134217728 ) 47D842D7C306E96E6E6ADE2C877A6DD4
    OUT> 0009: [ 0134217728 .. 0150994944 ) 5C341955F76A9A91583B8F3515F4CE8A
    OUT> 0010: [ 0150994944 .. 0167772160 ) 582F83E69B24721CB377B952AE87C303
    OUT> 0011: [ 0167772160 .. 0184549376 ) 18CC9E7F8AC5EA09B3D7548D7CC887CC
    OUT> 0012: [ 0184549376 .. 0185515842 ) 4CB41704330B0361583BB1F9DCF791C9
    OUT> file unlocked