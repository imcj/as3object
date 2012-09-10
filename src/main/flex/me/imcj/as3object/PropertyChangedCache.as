package me.imcj.as3object
{
import flash.utils.Dictionary;

import me.imcj.as3object.core.Dict;
import me.imcj.as3object.core.Key;
import me.imcj.as3object.core.KeyValue;

public class PropertyChangedCache
{
    protected var cache : TableCache;
    protected var properties : Dict;
    
    public function PropertyChangedCache ( cache : TableCache )
    {
        this.cache = cache;
        properties = new Dict ( );
    }
    
    public function push ( object : Object, property : String ) : void
    {
        var table : Table = cache.getWithObject ( object );
        var primary : KeyValue;
        var queue : Dict;
        
        if ( ! table )
            throw new Error ( "error" ); // TODO exception
        
        primary = table.getPrimary ( object );
        
        addObject ( table.name, primary, object );
        queue = getChangedProperties ( table.name, primary );
        queue.add ( property, null );
    }
    
    public function getChangedProperties ( tableName : String, primary : KeyValue ) : Dict
    {
        var queue : Dict;
        var propertiesKey : String = "property_" + tableName + "_" + primary.value;
        if ( ! properties.has ( propertiesKey ) ) {
            queue = new Dict ( );
            properties.add ( propertiesKey, queue );
        } else
            queue = properties.get ( propertiesKey ) as Dict;
        
        return queue;
    }
    
    public function addObject ( tableName : String, primary : KeyValue, object : Object ) : void
    {
        var objectKey : String = "object_" + tableName + "_" + primary.value;
        if ( ! properties.hasOwnProperty ( objectKey ) )
            properties.add ( objectKey, object );
    }
    
    public function getObject ( tableName : String, primary : KeyValue ) : Object
    {
        var objectKey : String = "object_" + tableName + "_" + primary.value;
        return properties.get ( objectKey );
    }
    
    public function getUpdaterWithObject ( object : Object ) : Object
    {
        var table : Table = cache.getWithObject ( object );
        return getUpdaterWithPrimary ( table, table.getPrimary ( object ) );
    }
    
    public function getUpdaterWithPrimary ( table : Table, key : KeyValue ) : Object
    {
        var changedProperties : Array = getChangedProperties ( table.name, key ).keys;
        var object : Object = getObject ( table.name, key );
        var updater : Object = new Object ( );
        var changedProperty : String;
        
        for each ( changedProperty in changedProperties )
            updater[changedProperty] = table.getColumn ( changedProperty ).getValue ( object );
            
        return updater;
    }
}
}