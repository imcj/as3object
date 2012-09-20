package me.imcj.as3object.hook.impl
{
    
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;

import me.imcj.as3object.Table;
import me.imcj.as3object.hook.HookAction;
    
public class DefaultExcludeHook extends HookImpl
{
    override public function execute ( data : Object ) : HookAction
    {
        var table : Table = data["table"];
        var i : int = 0, size : int = table.type.extendsClasses.length;
        
        filter ( table.type.fullName, table );
        for ( ; i < size; i++ )
            filter ( table.type.extendsClasses[i], table );
        
        table.excludeWithType ( flash.display.BitmapData );

        return HookAction.nothing ( );
    }
    
    protected function filter ( typeName : String, table : Table ) : void
    {
        switch ( typeName ) {
            case "flash.display::Sprite":
                excludeFieldsWithSprite ( table );
                break;
            case "flash.display::DisplayObjectContainer":
                excludeFieldsWithDisplayObjectContainer ( table );
                break;
            case "flash.display::InteractiveObject":
                excludeFieldsWithInteractiveObject ( table );
                break;
            case "flash.display::DisplayObject":
                excludeFieldsWithDisplayObject ( table );
                break;
            case "Object":
                excludeFieldsWithObject ( table );
                break;
        }
    }
    
    protected function excludeFieldsWithSprite ( table : Table ) : void
    {
        table.excludeDeclaringType ( flash.display.Sprite );
    }
    
    protected function excludeFieldsWithDisplayObjectContainer( table : Table ) : void
    {
        table.excludeDeclaringType ( flash.display.DisplayObjectContainer );
    }
    
    protected function excludeFieldsWithInteractiveObject( table : Table ) : void
    {
        table.excludeDeclaringType ( flash.display.InteractiveObject );
    }
    
    protected function excludeFieldsWithDisplayObject( table : Table ) : void
    {
        table.excludeDeclaringType ( flash.display.DisplayObject );
        table.includeProperty ( "alpha" );
        table.includeProperty ( "height" );
        table.includeProperty ( "name" );
        table.includeProperty ( "rotation" );
        table.includeProperty ( "width" );
        table.includeProperty ( "x" );
        table.includeProperty ( "y" );
        table.includeProperty ( "z" );
    }
    
    protected function excludeFieldsWithObject( table : Table ) : void
    {
        table.excludeDeclaringType ( Object );
    }
}

}