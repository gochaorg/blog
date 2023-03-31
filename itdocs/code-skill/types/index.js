"use strict";
var Box = /** @class */ (function () {
    function Box(w, h) {
        this.width = w;
        this.height = h;
    }
    Box.prototype.area = function () {
        return this.width * this.height;
    };
    return Box;
}());
var Circle = /** @class */ (function () {
    function Circle(r) {
        this.radius = r;
    }
    Circle.prototype.area = function () {
        return this.radius * this.radius * Math.PI;
    };
    return Circle;
}());
var Foo = /** @class */ (function () {
    function Foo() {
    }
    return Foo;
}());
var f1 = function (a) { return true; };
var f2 = function (a) { return typeof (a) == 'function'; };
var f3 = f1;
var f4 = f3;
var _f1 = function (a) { return true; };
var _f2 = _f1;
var _f3 = _f1;
