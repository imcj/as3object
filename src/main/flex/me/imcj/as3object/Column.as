package me.imcj.as3object {
    
import me.imcj.as3object.core.KeyValue;
import me.imcj.as3object.type.Type;

import org.as3commons.reflect.Metadata;
import org.as3commons.reflect.MetadataArgument;
import org.as3commons.reflect.MetadataContainer;
import org.as3commons.reflect.Type;

public class Column
{
    protected var _name : String;
    protected var _type : org.as3commons.reflect.Type;
    protected var _metadataContainer : MetadataContainer;
    protected var table : Table;
    protected var mapping : Mapping;
    
    public var primary : Boolean = false;
    public var autoIncrement : Boolean = false;
    
    public var setMethod : String;
    public var getMethod : String;
    
    protected var as3objectType : me.imcj.as3object.type.Type;
    
    public function Column ( name : String, type : org.as3commons.reflect.Type, metadata : MetadataContainer, table : Table )
    {
        _name = name;
        _type = type;
        _metadataContainer = metadata;
        this.table = table;
        
        mapping = Mapping.instance;
        isPrimary ( );

        as3objectType = mapping.getAS3ObjectType ( type.fullName );
    }
    
    protected function isPrimary():void
    {
        var found : Boolean;
        var metadata : Metadata;
        var metadatas : Array = _metadataContainer.getMetadata ( "Primary" );
        var autoIncrmentArgument : MetadataArgument;
        
        if ( metadatas ) {
            metadata = metadatas[0];
            
            primary = true;
            autoIncrmentArgument = metadata.getArgument ( "autoIncrement" );
            if ( autoIncrmentArgument )
                if ( autoIncrmentArgument == false )
                    primary = false;
        } else if ( ! metadatas && "id" == name )
            primary = autoIncrement = true;
    }
    
    public function get name ( ) : String
    {
        return _name;
    }

    public function get type():org.as3commons.reflect.Type
    {
        return _type;
    }
    
    public function getSqlValue ( instance : Object ) : String
    {
        if ( isForeign )
            return table.getPrimaryWithRelation ( this, instance );
        
        return as3objectType.objectToString ( this, getValue ( instance ) );
//        if ( v is String )
//            return v as String;
//        // else if ( null == v && mappedType )
//        else if ( type.name == "Boolean" )
//            return v ? "1" : "0";
//        else if ( null == v && v is String )
//            return "";
//        else if ( null == v && isNotBaseDataType ( ) )
//            return 'NULL';
//        else if ( v is Number )
//            if ( isNaN ( Number ( v ) ) )
//                return 'NULL';
//        else if ( 0 == v || null == v )
//            return "NULL";
//        else
//            return v.toString ( );
    }
    
    public function getValue ( instance : Object ) : Object
    {
        var v : Object;
        
        if ( ! getMethod && ! setMethod ) {
            v = instance[name];
        } else if ( getMethod && setMethod ) {
            v = instance[getMethod] ( );
        }
        
        return v;
    }
    
    public function setValue ( instance : Object, result : Object ) : void
    {
        if ( ! getMethod && ! setMethod ) {
            instance[name] = result[name];
        } else if ( getMethod && setMethod ) {
            instance[setMethod] ( result[name] );
        }
    }
    
    public function get metadata() : MetadataContainer
    {
        return _metadataContainer;
    }
	
	public function get isForeign ( ) : Boolean
	{
        if ( as3objectType == null )
            return true;
		return false;
	}
	
    // isCollection
	public function get isOneToMany ( ) : Boolean
	{
        switch ( type.fullName )
        {
            case "Array":
            case "mx.collections::ArrayCollection":
                return true;
            default:
                return false;
        }
		return false;
	}
    
    public function get sqlName ( ) : String
    {
        if ( isForeign )
            return name + "_id";
        
        return name;
    }
    
    public function get sqlType ( ) : String
    {
        return mapping.getColumnTypeWithType ( type.fullName );
        
        return null;
    }
    
    public function isNotBaseDataType():Boolean
    {
        switch ( type.name ) {
            case "String":
            case "Number":
            case "Boolean":
            case "Date":
            case "int":
            case "Object":
                return false;
            case "Array":
            case "ArrayCollection":
                return true;
            default:
                if ( type.fullName.indexOf ( "." ) < 0 )
                    throw new Error ( "Not implement." );
                return true;
        }
        return true;
    }
    
    public function clone ( ) : Column
    {
        var column : Column = new Column ( name, _type, _metadataContainer, this.table );
        column.setMethod = setMethod;
        column.getMethod = getMethod;
        
        return column;
    }
}

}