as3object
===

1. 提供一组操作数据库的API
2. 可以导出数据到XML


## 使用
```
class Animal
{
    public var name : String;
    public var age  : int;
}

class Cat extends Animal { }

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
[ <Cat "2B"> ]0

```