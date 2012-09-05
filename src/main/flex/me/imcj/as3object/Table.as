package me.imcj.as3object {
    
import me.imcj.as3object.core.Dict;
import me.imcj.as3object.core.DictIterator;
import me.imcj.as3object.core.KeyValue;

import mx.core.ClassFactory;

import org.as3commons.reflect.Type;

public class Table
{
    protected var _columns     : Dict;
    protected var _name       : String;
	protected var _type       : Type;
    
	public var primaryKey : Column;
    
    public var ddl : DDL;
    public var dml : DML;
    
    protected var _oneToManyColumns : Array = new Array ( );
    protected var tableCache:TableCache;
    
    static public var _id : int = 0;
    public var id : int;
	
    protected var _isHierarchical : Boolean;
    
    public function Table ( type : Type, tableCache : TableCache )
    {
        _id ++;
        id = _id;
		_type      = type
        _name      = _type.name;
        this.tableCache = tableCache;
        
        var superClass : String;
        _isHierarchical = false;
        for each ( superClass in type.extendsClasses ) {
            if ( superClass == "me.imcj.as3object::AS3ObjectHierachical" ) {
                _isHierarchical = true;
                break;
            }
        }
    }
    
    protected function hasInterface ( interfaces : Array, type : String ) : Boolean
    {
        var i : int = 0, size : int = interfaces.length;
        for ( ; i < size; i++ )
            if ( interfaces[i] == type )
                return true;
        return false;
    }
    
    public function addField ( column : Column ) : Column
    {
        _columns.add ( column.name, column );
        return column;
    }
    
    public function getColumn ( fieldName : String ) : Column
    {
        return Column ( _columns.get ( fieldName ) );
    }
    
    public function get oneToManyColumns ( ) : Array
    {
        return _oneToManyColumns;
    }
    
    public function hasColumn ( column : String ) : Boolean
    {
        return _columns.has ( column );
    }
    
    public function get columns ( ) : Dict
    {
        return _columns;
    }
    
    public function set columns ( value : Dict ) : void
    {
        _columns = value;
//        _oneToManyColumns = new Array ( );
//        
//        var column : Column;
//        var iter : DictIterator = _columns.createIterator ( );
//        while ( iter.hasNext ) {
//            column = Column ( iter.next ( ) );
//            
//            if ( column.type.name == "ArrayCollection" )
//                _oneToManyColumns[_oneToManyColumns.length] = column;
//        }
    }
    
    public function get type() : Type
    {
        return _type;
    }
    
    public function getPrimary ( object : Object ) : KeyValue
    {
        if ( null == primaryKey )
            throw new NotFoundPrimaryError ( );
        
        return new KeyValue ( primaryKey.name, primaryKey.getValue ( object ) );
    }
    
    public function getPrimaryWithRelation ( column : Column, object : Object ) : String
    {
        var relationTable : Table = tableCache.getWithType ( column.type.clazz );
        var relation : Object;
        if ( ! object.hasOwnProperty ( column.name ) )
            return null;
        
        relation = object[column.name];
        if ( null == relation )
            return null;
        
        return relationTable.getPrimaryValue ( relation );
    }
    
    public function getPrimaryValue ( object : Object ) : String
    {
        if ( null == primaryKey )
            throw new NotFoundPrimaryError ( );
        
        var value : Object = primaryKey.getValue ( object );
        if ( value is String )
            return value as String;
        else if ( value is int || value is uint || value is Number )
            if ( 0 == value )
                return null;
        else
            return value.toString ( );
        
        return null;
    }

    public function get name():String
    {
        return _name;
    }
    
    public function createInstance ( result : Object ) : Object
    {
        var factory : ClassFactory = new ClassFactory ( type.clazz );
        var instance : Object = factory.newInstance ( );
        
        
        var iter : DictIterator = columns.createIterator ( );
        var column : Column;
        while ( iter.hasNext ) {
            column = Column ( iter.next ( ) );
            column.setValue ( instance, result );
        }
        
        return instance;
    }
    
    public function get isHierarchical ( ) : Boolean
    {
        return _isHierarchical;
    }

}
}