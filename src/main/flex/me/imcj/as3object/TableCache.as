package me.imcj.as3object
{
    
import me.imcj.as3object.core.Dict;

import org.as3commons.reflect.Type;

public class TableCache extends Dict
{
    public var factory : TableFactory;
    
    public function TableCache ( )
    {
    }
    
    public function getWithName ( name : String ) : Table
    {
        var table : Table;
        if ( has ( name ) )
            return get ( name ) as Table;
        else {
            table = factory.create ( name );
            add ( name, table );
            return table;
        }
    }
    
    public function getWithObject ( object : Object ) : Table
    {
        return getWithName ( Type.forInstance ( object ).fullName );
    }
    
    public function getWithType ( type : Class ) : Table
    {
        return getWithName ( Type.forClass ( type ).fullName );
    }
}

}