Работа с HTTP
==============

maven
-----

```xml
<dependency>
  <groupId>xyz.cofe</groupId>
  <artifactId>http-base</artifactId>
  <version>0.1</version>
</dependency>
```

Отправка синхронного GET запроса
--------------------------------

```groovy
import xyz.cofe.http.*

def http = new HttpClient()
def req = http.createRequest( 'http://cofe.xyz/' )
req.async = false

def res = req.createResponse()
res.start()

println res.text
```

Асинхронный запрос
------------------

```groovy
import xyz.cofe.http.*
import java.net.URL

def http = new HttpClient()

// Указываем таймауты
http.connectTimeout = 5 * 1000
http.readTimeout = 10 * 1000

// Указываем клиента
http.userAgent = 'sample agent'

// Кодировка по умолчанию
http.defaultCharset = java.nio.charset.Charset.forName( 'UTF-8' )

def req = http.createRequest( 'http://cofe.xyz/' )

// Запрос асинхронный
req.async = true

// Следовать перенаправлениям
req.followRedirect = true

// Тип запроса
req.method = 'GET'

// Максимальное кол-во загружаемых байтов
req.maxDownloadSize = (long)(128 * 1024)

def res = req.createResponse()

// Подписчик на события
res.addListener new HttpListenerAdapter(){
	protected void responseProgress( HttpResponse.ProgressEvent ev, HttpResponse resp ){
		println "progress $resp.downloadedSize / $resp.httpHeaders.contentLength"
	}
	
	protected void responseStateChanged(
		HttpResponse.StateChangedEvent event,
		HttpResponse response,
		HttpResponse.State oldState, 
		HttpResponse.State newState )
	{
		println "state changed $oldState -> $newState"
	}

	protected void responseRedirect(HttpResponse.RedirectEvent event, HttpResponse response, URL from, URL to){
		println "redirect $from -> $to"
	}

	protected void responseFinished(HttpResponse.StateChangedEvent event, HttpResponse response) {
		println "finished"
	}
}

// Выполняем запрос
res.start()

// Ожидаем завершения
res.waitForFinished()

println "Errors count: ${res.errors.size()}"
res.errors.eachWithIndex { err, erri ->
	println "error $erri $err"
}

println "Status $res.statusCode $res.statusMessage"

println "Response header:"
res.httpHeaders.multiMap.each { key, vals ->
	if( vals.size()==1 ){
		println "$key: ${vals[0]}"
	}else{
		println "$key:"
		vals.each { println "  $it" }
	}
}

println "Text:\n\n$res.text"
```