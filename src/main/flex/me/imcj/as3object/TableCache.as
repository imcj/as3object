package me.imcj.as3object
{
    
import flash.utils.Dictionary;

import org.as3commons.reflect.Type;

public class TableCache
{
    protected var cache : Dictionary = new Dictionary ( true );
    public var factory : TableFactory;
    
    public function TableCache ( )
    {
    }
    
    public function has ( name : String ) : Boolean
    {
        return cache.hasOwnProperty ( name );
    }
    
    public function getWithName ( name : String ) : Table
    {
        if ( has ( name ) )
            return cache[name];
        else
            return cache[name] = factory.create ( name );
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