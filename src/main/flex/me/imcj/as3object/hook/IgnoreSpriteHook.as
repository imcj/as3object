package me.imcj.as3object.hook
{
    
import me.imcj.as3object.Table;
    
public class IgnoreSpriteHook implements Hook
{
    public function execute ( data : Object ) : void
    {
        var table : Table = data["table"];
        var i : int = 0, size : int = table.type.extendsClasses.length;
        var extendsClass : String;
        var found : Boolean = false;
        for ( ; i < size; i++ ) {
            extendsClass = table.type.extendsClasses[i];
            if ( extendsClass == "flash.display::Sprite" )
                found = true;
            
            if ( found )
                ignoreType ( table, extendsClass );
        }
    }
    
    protected function ignoreType ( table : Table, type : String ) : void
    {
    }
}

}