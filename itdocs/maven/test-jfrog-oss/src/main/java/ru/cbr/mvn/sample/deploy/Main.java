package ru.cbr.mvn.sample.deploy;

public class Main {
    public static void main(String[] args){
        System.out.println("sample app");
        if( args!=null && args.length>0 ){
            System.out.println("args:");
            for( int i=0; i< args.length; i++ ){
                System.out.println("arg["+i+"]: "+args[i]);
            }
        }
    }
}
