package me.imcj.as3object
{
import flash.utils.Dictionary;

import me.imcj.as3object.fixture.Cat;

public class PropertyChangedCache
{
    protected var cache : Dictionary;
    protected var tableCache : TableCache;
    
    public var interval : uint;
    
    public function PropertyChangedCache ( interval : uint = 0 )
    {
        cache = new Dictionary ( true );
    }
    
    public function push ( object : Object, property : String ) : void
    {
        var table : Table = tableCache.getWithObject ( object );
        var primary : String;
        var id : String;
        var queue : Array;
        
        if ( ! table )
            throw new Error ( "error" ); // TODO exception
        
        if ( ! table.primaryKey )
            throw new Error ( "primary missing" ); // TODO exception
        
        primary = table.primaryKey.name;
        
        id = table.getPrimaryValue ( object );
        id += "_" + table.type.name;
        
        if ( ! cache.hasOwnProperty ( id ) )
            queue = cache[id] = new Array ( );
        else
            queue = cache[id];
        
        queue.push ( new PropertyChangeQueue ( object, property ) );
    }
}
}