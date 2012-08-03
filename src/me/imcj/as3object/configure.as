package me.imcj.as3object
{
    public function configure ( ... args ) : void
    {
        var type : Class;
        var facade : Facade = Facade.instance;
        
        for each ( type in args ) {
            facade.getTable ( type );
        }
    }
}