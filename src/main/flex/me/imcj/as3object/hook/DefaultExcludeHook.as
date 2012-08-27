package me.imcj.as3object.hook
{
    
import me.imcj.as3object.Table;
    
public class DefaultExcludeHook implements Hook
{
    public function execute ( data : Object ) : void
    {
        var table : Table = data["table"];
        var i : int = 0, size : int = table.type.extendsClasses.length;
        var extendsClass : String;
        
        var isASprite : Boolean;
        
        for ( ; i < size; i++ ) {
            extendsClass = table.type.extendsClasses[i];
            
            isASprite = extendsClass == "flash.display::Sprite";
            if ( isASprite ) {
            
                excludeFieldsWithSprite ( table );
                excludeFieldsWIthDisplayObjectContainer ( table );
                excludeFieldsWIthDisplayObject ( table );
                excludeFieldsWIthInteractiveObject ( table );
                excludeFieldsWIthObject ( table );
            }
        }
    }
    
    protected function excludeFieldsWithSprite ( table : Table ) : void
    {
    }
    
    protected function excludeFieldsWIthDisplayObjectContainer(table:Table):void
    {
    }
    
    protected function excludeFieldsWIthDisplayObject(table:Table):void
    {
    }
    
    protected function excludeFieldsWIthInteractiveObject(table:Table):void
    {
    }
    
    protected function excludeFieldsWIthObject(table:Table):void
    {
    }
}

}