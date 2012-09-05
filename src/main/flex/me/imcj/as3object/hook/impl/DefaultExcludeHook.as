package me.imcj.as3object.hook.impl
{
    
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;

import me.imcj.as3object.ColumnMetadata;
import me.imcj.as3object.Table;
import me.imcj.as3object.hook.Hook;
    
public class DefaultExcludeHook extends HookImpl
{
    override public function execute ( data : Object ) : void
    {
        var table : Table = data["table"];
        var i : int = 0, size : int = table.type.extendsClasses.length;
        
        var columnMetadata : ColumnMetadata = new ColumnMetadata ( table.type, table.columns );
        filter ( table.type.fullName, columnMetadata );
        for ( ; i < size; i++ )
            filter ( table.type.extendsClasses[i], columnMetadata );
    }
    
    protected function filter ( typeName : String, columnMetadata : ColumnMetadata ) : void
    {
        switch ( typeName ) {
            case "flash.display::Sprite":
                excludeFieldsWithSprite ( columnMetadata );
                break;
            case "flash.display::DisplayObjectContainer":
                excludeFieldsWithDisplayObjectContainer ( columnMetadata );
                break;
            case "flash.display::InteractiveObject":
                excludeFieldsWithInteractiveObject ( columnMetadata );
                break;
            case "flash.display::DisplayObject":
                excludeFieldsWithDisplayObject ( columnMetadata );
                break;
            case "Object":
                excludeFieldsWithObject ( columnMetadata );
                break;
        }
    }
    
    protected function excludeFieldsWithSprite ( columnMetadta : ColumnMetadata ) : void
    {
        columnMetadta.excludeDeclaringType ( flash.display.Sprite );
    }
    
    protected function excludeFieldsWithDisplayObjectContainer( columnMetadta : ColumnMetadata ) : void
    {
        columnMetadta.excludeDeclaringType ( flash.display.DisplayObjectContainer );
    }
    
    protected function excludeFieldsWithInteractiveObject( columnMetadta : ColumnMetadata ) : void
    {
        columnMetadta.excludeDeclaringType ( flash.display.InteractiveObject );
    }
    
    protected function excludeFieldsWithDisplayObject( columnMetadta : ColumnMetadata ) : void
    {
        columnMetadta.excludeDeclaringType ( flash.display.DisplayObject );
        columnMetadta.includeProperty ( "alpha" );
        columnMetadta.includeProperty ( "height" );
        columnMetadta.includeProperty ( "name" );
        columnMetadta.includeProperty ( "rotation" );
        columnMetadta.includeProperty ( "width" );
        columnMetadta.includeProperty ( "x" );
        columnMetadta.includeProperty ( "y" );
        columnMetadta.includeProperty ( "z" );
    }
    
    protected function excludeFieldsWithObject( columnMetadta : ColumnMetadata ) : void
    {
        columnMetadta.excludeDeclaringType ( Object );
    }
}

}