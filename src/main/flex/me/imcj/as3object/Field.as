package me.imcj.as3object {
    
import org.as3commons.reflect.Type;

public class Field
{
    protected var _name : String;
    protected var _type : Type;
    protected var _metadata : Array;
    
    public var primary : Boolean = false;
    public var autoIncrement : Boolean = false;
    
    public var setMethod : String;
    public var getMethod : String;
    
    public function Field ( name : String, type : Type, metadata : Array )
    {
        _name = name;
        _type = type;
        _metadata = metadata;
    }
    
    public function get name ( ) : String
    {
        return _name;
    }

    public function get type():Type
    {
        return _type;
    }

    public function get metadata():Array
    {
        return _metadata;
    }
    
    public function clone ( ) : Field
    {
        var field : Field = new Field ( name, _type, _metadata );
        field.setMethod = setMethod;
        field.getMethod = getMethod;
        
        return field;
    }
}

}