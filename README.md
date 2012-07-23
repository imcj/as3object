as3object
===

as3object提供一组API提供对POAO ( Plain Old ActionScript Objects )的持久化操作。  

## 使用
```
class Animal
{
    public var name : String;
    public var age  : int;
}
```

### 领域模型
=======
class Cat extends Animal
{
}

>>>>>>> 18f02186be10fa7c2e420a6e5babc86e9822081e
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