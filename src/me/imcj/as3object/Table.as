package me.imcj.as3object
{
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.expression.Expression;
    import me.imcj.as3object.sqlite.field.*;
    
    import mx.core.ClassFactory;
    
    import org.as3commons.reflect.Type;
    import me.imcj.as3object.core.Dict;

    public class Table implements SQL
    {
        protected var _data       : Object;
        protected var _fields     : Dict;
        protected var _name       : String;
        protected var _package    : String;
        protected var _shortName  : String;
		protected var _sql        : SQL;
		protected var _type       : Type;
		protected var _primaryKey : AS3ObjectField;
        
        protected var hierarchical : Boolean;
		
        public function Table ( type : Type )
        {
			var fullName : Array;
			var field    : AS3ObjectField;
			
            _fields    = new Dict ( );
			_type      = type
            _name      = _type.fullName;
            fullName   = _name.split ( "::" );
            _shortName = fullName[1];
            _package   = fullName[0];
            
            if ( hasInterface ( _type.interfaces, "mx.controls.treeClasses.ITreeDataDescriptor" ) ||
                 hasInterface ( _type.interfaces, "mx.controls.menuClasses.IMenuDataDescriptor" ) ) {
                
            }
            // "mx.controls.treeClasses.ITreeDataDescriptor"
        }
        
        protected function hasInterface ( interfaces : Array, type : String ) : Boolean
        {
            var i : int = 0, size : int = interfaces.length;
            for ( ; i < size; i++ )
                if ( interfaces[i] == type )
                    return true;
            return false;
        }
        
        public function addField ( field : AS3ObjectField ) : AS3ObjectField
        {
            if ( field.primaryKey )
                _primaryKey = field;
            
            _fields.add ( field.name, field );
            return field;
        }
        
        public function getField ( fieldName : String ) : AS3ObjectField
        {
            return AS3ObjectField ( _fields[fieldName] );
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

        public function get primaryKey():AS3ObjectField
        {
            return _primaryKey;
        }
        
        public function create ( attribute : Object = null ) : Object
        {
            var factory : ClassFactory = new ClassFactory ( _type.clazz );
            var instance : Object = factory.newInstance ( );
            
            // Hooks
            return instance;
        }
        
        public function creationStatement ( ifNotExists : Boolean = false ) : String
        {
            return null;
        }
        
        public function insert ( object : Object ) : String
        {
            return null;
        }
        
        public function update ( object : Object, expression : Expression ) : String
        {
            return null;
        }
        
        public function remove ( object : Object, expression : Expression ) : String
        {
            return null;
        }
        
        public function select ( expression : Expression, order : Array = null ) : String
        {
            return null;
        }
    }
}