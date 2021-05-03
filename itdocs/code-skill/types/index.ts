interface Shape {
    area():number
}

class Box implements Shape {
    width : number
    height : number
    constructor( w: number, h: number ){
        this.width = w;
        this.height = h;
    }
    area():number {
        return this.width * this.height
    }
}

class Circle implements Shape {
    radius : number
    constructor( r: number ){
        this.radius = r
    }
    area():number {
        return this.radius * this.radius * Math.PI
    }
}

class Foo {
}

const f1 : (number)=> boolean = a => true;
const f2 : (object)=> boolean = a => typeof(a)=='function';
const f3 : (any)=>boolean = f1;
const f4 : (number)=>boolean = f3;

const _f1 : (Box)=>boolean = a => true
const _f2 : (any)=>boolean = _f1
const _f3 : (Shape)=>boolean = _f1
