package xyz.cofe.sample.inv

object App {
  def strCmp(a:String):Boolean = a.contains("1")
  def intCmp(a:Int):Boolean = a==1
  def anyCmp(a:Any):Boolean = true

  def main(args:Array[String]):Unit = {
    println("hello")

    val cmp1 : (String)=>Boolean = App.strCmp;
    val cmp2 : (String)=>Boolean = App.anyCmp
    val cmp3 : (Any)=>Boolean = App.anyCmp
    val cmp4 : (Any)=>Boolean = App.strCmp
  }
}
