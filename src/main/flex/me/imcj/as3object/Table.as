package me.imcj.as3object {
    
import me.imcj.as3object.core.Dict;
import me.imcj.as3object.core.DictIterator;
import me.imcj.as3object.core.KeyValue;

import mx.core.ClassFactory;

import org.as3commons.reflect.Type;

public class Table
{
    protected var _name       : String;
	protected var _type       : Type;
    
	public var primaryKey : Column;
    
    public var ddl : DDL;
    public var dml : DML;
    
    protected var _columns   : Dict = new Dict ( );
    protected var _base      : Dict = new Dict ( );
    protected var _oneToMany : Dict = new Dict ( );
    protected var _foreign   : Dict = new Dict ( );
    protected var _source    : Dict = new Dict ( );
    
    protected var tableCache : TableCache;
    
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
        
        for each ( superClass in type.interfaces ) {
            if ( superClass == "mx.controls.treeClasses.ITreeDataDescriptor" ) {
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
    
    public function addColumn ( column : Column ) : Column
    {
        if ( column.primary )
            primaryKey = column;
        
        getDict ( column ).add ( column.name, column );
        
        _source.add ( column.name, column );
        return column;
    }
    
    public function addColumnOfSource ( column : String ) : Column
    {
        if ( ! hasColumn ( column ) )
            if ( _source.has ( column ) )
                return addColumn ( _source.get ( column ) as Column );
            else
                return null;
        else
            return getColumn ( column );    
    }
    
    public function removeColumn ( column : Column ) : Column
    {
        getDict ( column ).remove ( column.name );
        _columns.remove ( column.name );
        
        return column;
    }
    
    public function removeColumnWithName ( columnName : String ) : Column
    {
        var column : Column = getColumn ( columnName );
        getDict ( column ).remove ( columnName );
        _columns.remove ( columnName );
        
        return column;
    }
    
    protected function getDict ( column : Column ) : Dict
    {
        var dict : Dict;
        switch ( column.sqlType ) {
            case "Foreign":
                dict = _foreign;
                break;
            case "OneToMany":
                dict = _oneToMany;
                break;
            default:
                dict = _columns;
        }
        
        return dict;
    }
    
    public function getColumn ( fieldName : String ) : Column
    {
        var column : Column = _columns.get ( fieldName ) as Column;
        return column;
    }
    
    public function hasColumn ( column : String ) : Boolean
    {
        return _columns.has ( column );
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
        
        // not exists primary
        if ( ! object.hasOwnProperty ( column.name ) )
            return null;
        
        relation = object[column.name];
        if ( null == relation )
            return 'NULL';
        
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
        
        eachAllColumn ( function ( column : Column ) : void
        {
            column.setValue ( instance, result );
        } );
        
        return instance;
    }
    
    public function get isHierarchical ( ) : Boolean
    {
        return _isHierarchical;
    }
    
    public function addOneToMany ( value : Column ) : void
    {
        _oneToMany.add ( value.name, value );
    }
    
    public function removeOneToMany ( value : Column ) : void
    {
        _oneToMany.remove ( value.name );
    }
    
    public function getOneToManyWithName ( value : String ) : Column
    {
        return _oneToMany.get ( value ) as Column;;
    }
    
    public function getOneToMany ( value : String ) : Column
    {
        return getOneToManyWithName ( value );
    }
    
    public function findColumnsWithOneToMany ( func : Function ) : void
    {
        _oneToMany.forEach ( function ( kv : KeyValue ) : void
            {
                func ( Column ( kv.value ) );
            } );
    }
    
    public function addForeign ( value : Column ) : void
    {
        _foreign.add ( value.name, value );
    }
    
    public function removeForeign ( value : Column ) : void
    {
        _foreign.remove ( value.name );
    }
    
    public function getForeignWithName ( value : String ) : Column
    {
        return _foreign.get ( value ) as Column;
    }
    
    public function getForeign ( value : String ) : Column
    {
        return getForeignWithName ( value );
    }
    
    public function eachForeign ( func : Function ) : void
    {
        _foreign.forEach ( function ( kv : KeyValue ) : void
        {
            func ( Column ( kv.value ) );
        } );
    }
    
    public function eachAllColumn ( func : Function ) : void
    {
        _columns.merge ( _foreign ).forEach ( function ( kv : KeyValue ) : void
        {
            func ( Column ( kv.value ) );
        } );
    }
    
    protected function eachSource ( func : Function ) : void
    {
        _source.merge ( _foreign ).forEach ( function ( kv : KeyValue ) : void
        {
            func ( Column ( kv.value ) );
        } );
    }
    
    public function excludeDeclaringType ( type : Class ) : void
    {
        var declaringType : Type = Type.forClass ( type );
        eachAllColumn ( function ( column : Column ) : void
        {
            try {
                if ( declaringType.getField ( column.name ).declaringType.fullName == declaringType.fullName )
                    excludeField ( column.name );
            } catch ( error : TypeError ) { }
        } );
    }
    
    public function excludeWithType ( type : Class ) : void
    {
        var as3commonType : Type = Type.forClass ( type );
        
        eachAllColumn ( function ( column : Column ) : void
        {
            if ( as3commonType.fullName == column.type.fullName )
                removeColumn ( column );
        } );
    }
    
    public function excludeProperty ( property : String ) : void
    {
        excludeField ( property );
    }
    
    public function excludeField ( field : String ) : void
    {
        if ( hasColumn ( field ) )
            removeColumnWithName ( field );
    }
    
    public function includeDeclaringType ( type : Class ) : void
    {
        var declaringType : Type = Type.forClass ( type );
        eachSource ( function ( column : Column ) : void {
            try {
                if ( declaringType.getField ( column.name ).declaringType.fullName == declaringType.fullName )
                    includeField ( column.name );
            } catch ( error : TypeError ) {}
        } );
    }
    
    public function includeProperty ( property : String ) : void
    {
        includeField ( property );
    }
    
    public function includeField ( field : String ) : void
    {
        addColumnOfSource ( field );
    }
}
}