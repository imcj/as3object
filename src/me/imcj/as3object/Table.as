package me.imcj.as3object
{
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.expression.Expression;
    import me.imcj.as3object.field.Field;
    import me.imcj.as3object.sqlite.field.*;
    
    import org.as3commons.reflect.Type;

    public class Table
    {
        protected var _data       : Object;
        protected var _fields     : Dict;
        protected var _name       : String;
        protected var _package    : String;
        protected var _shortName  : String;
		protected var _sql        : SQL;
		protected var _type       : Type;
		protected var _primaryKey : Field;
		
        public function Table ( type : Object = null )
        {
			var fullName : Array;
			var field    : Field;
			
            _fields    = new Dict ( );
			_type      = type is Class ? Type.forClass ( Class ( type ) ) : Type.forClass ( Class ( getDefinitionByName ( getQualifiedClassName ( type ) ) ) );
            _name      = getQualifiedClassName ( type );
            fullName   = _name.split ( "::" );
            _shortName = fullName[1];
            _package   = fullName[0];
        }
        
        
        public function addField ( field : Field ) : Field
        {
            if ( field.primaryKey )
                _primaryKey = field;
            
            _fields.add ( field.name, field );
            return field;
        }
        
        public function getField ( fieldName : String ) : Field
        {
            return Field ( _fields[fieldName] );
        }
        
        public function get fields ( ) : Dict
        {
            return _fields;
        }
        
        public function set data ( value : Object ) : void
        {
            _data = value;
        }
		
        public function get shortName():String
        {
            return _shortName;
        }

        public function get type() : Type
        {
            return _type;
        }

        public function get primaryKey():Field
        {
            return _primaryKey;
        }
    }
}