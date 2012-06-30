as3object
===

# as3object
as3object是一个提供一组操作对象的API，特性包括：ORM和AOP。

## How to use
```
class Animal
{
    public var name : String;
    public var age  : int;
}

[Store]
class Cat
{
}
```
### 传说中不贫血的模型
```
var mycat : Cat = new Cat ( );
mycat.name = "2B";
mycat.age = 2;
mycat.save ( );

Cat.findOne ( eq ( "name", "2B" ) )
<Cat "2B">

Cat.findOne ( eq ( mycat ) )
<Cat "2B">

Cat.find ( )
[ <Cat "2B">, <Cat "Xiao Hua"> ]

Cat.find ( ge ( "age", 1 ) )
[ <Cat "2B"> ]

Cat.find ( and ( ge ( "age", 1 ), eq ( "name" , "2B" ) ) )
[ <Cat "2B"> ]
```

### 领域模型
```
var mycat : Cat = new Cat ( );
mycat.name = "2B";
mycat.age = 2;

Repository.add ( mycat );

Repository.findOne ( Cat, eq ( "name", "2B" ) )
<Cat "2B">

Repository.findOne ( Cat, eq ( mycat ) )
<Cat "2B">

Repository.find ( )
[ <Cat "2B">, <Cat "Xiao Hua"> ]

Repository.find ( ge ( "age", 1 ) )
[ <Cat "2B"> ]

Repository.find ( and ( ge ( "age", 1 ), eq ( "name" , "2B" ) ) )
[ <Cat "2B"> ]

class CustomExpress extends Express
{
    function CustomExpress ( )
    {
        addExpress ( and ( ge ( "age", 1 ), eq ( "name" , "2B" ) ) );
    }
}

Repository.find ( new CustomExpress ( ) )
[ <Cat "2B"> ]

```