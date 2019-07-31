
var msg = "hello world" // attach to module
console.log(msg);

var obj = new Object() ;
obj.func = function test( )
{
	console.log(msg)
}

obj.func() ;