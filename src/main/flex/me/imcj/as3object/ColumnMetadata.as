package me.imcj.as3object {
import me.imcj.as3object.core.Dict;
import me.imcj.as3object.core.DictIterator;

import org.as3commons.reflect.Type;

public class ColumnMetadata
{
    protected var columns:Dict;
    protected var copy : Dict;
    protected var type:Type;
    
    protected var queue : Array;
    
    static public var cache : Dict = new Dict ( );
    
    public function ColumnMetadata ( type : Type, columns : Dict )
    {
        this.type = type;
        this.columns = columns;
        this.copy = columns.clone ();
        this.queue = new Array ( );
        
        queue = new Array ( );
    }
    
    public function excludeDeclaringType ( type : Class ) : void
    {
        var column : Column;
        var declaringType : Type = Type.forClass ( type );
        var iter : DictIterator = copy.createIterator ( );
        while ( iter.hasNext ) {
            column = Column ( iter.next () );
            if ( column == null || declaringType.getField ( column.name ) == null )
                continue;
            if ( declaringType.getField ( column.name ).declaringType.fullName == declaringType.fullName )
                excludeField ( column.name );
        }
    }
    
    public function excludeProperty ( property : String ) : void
    {
        excludeField ( property );
    }
    
    public function excludeField ( field : String ) : void
    {
        if ( columns.has ( field ) )
            columns.remove ( field );
    }
    
    public function includeDeclaringType ( type : Class ) : void
    {
        var column : Column;
        var declaringType : Type = Type.forClass ( type );
        var iter : DictIterator = copy.createIterator ( );
        while ( iter.hasNext ) {
            column = Column ( iter.next () );
            if ( declaringType.getField ( column.name ).declaringType.fullName == declaringType.fullName )
                includeField ( column.name );
        }
    }
    
    public function includeProperty ( property : String ) : void
    {
        includeField ( property );
    }
    
    public function includeField ( field : String ) : void
    {
        if ( ! columns.has ( field ) && copy.has ( field ) )
            columns.add ( field, copy.get ( field ) );
    }
    
    public function clear ( ) : void
    {
        copy.removeAll ( );
    }
}
}

class QueueObject {
    public var flag : String;
    public var object : Object;
    
    static public const EXCLUDE : String = "EXCLUDE";
    static public const INCLUDE : String = "INCLUDE";
    
    public function QueueObject ( flag : String, object : Object )
    {
        this.flag = flag;
        this.object = object;
    }
}