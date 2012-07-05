package me.imcj.as3object
{
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.expression.Expression;
    import me.imcj.as3object.field.Field;
    import me.imcj.as3object.field.IFieldBuilder;
    import me.imcj.as3object.sqlite.SQLite;
    import me.imcj.as3object.sqlite.field.*;

    public class Table implements SQL
    {
        protected var _data      : Object;
        protected var _fields    : Dict;
        protected var _name      : String;
        protected var _package   : String;
        protected var _shortName : String;
		
		protected var _sql     : SQL;
		protected var _builder : IFieldBuilder;
		protected var _type    : Class;
		
        public function Table ( type : Object = null )
        {
			var fullName : Array;
			var field    : Field;
			
            _fields    = new Dict ( );
			_type      = type is Class ? Class ( type ) : Class ( getDefinitionByName ( getQualifiedClassName ( type ) ) );
            _name      = getQualifiedClassName ( type );
            fullName   = _name.split ( "::" );
            _shortName = fullName[1];
            _package   = fullName[0];
			
			if ( null == _builder )
				throw new Error ( "_builder is require." );
			
			for each ( field in _builder.generate ( _type ) )
				addField ( field );
        }
        
        
        public function addField ( field : Field ) : Field
        {
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

        public function creationStatement ( ifNotExists : Boolean = false ) : String
        {
            throw new Error ( "Not implement this method." );
        }
        
        public function insert ( object : Object ) : String
        {
            throw new Error ( "Not implement this method." );
        }
        
        public function update ( object : Object, expression : Expression ) : String
        {
            throw new Error ( "Not implement this method." );
        }
        
        public function remove ( object : Object, expression : Expression ) : String
        {
            throw new Error ( "Not implement this method." );
        }
        
        public function select ( expression : Expression ) : String
        {
            throw new Error ( "Not implement this method." );
        }
    }
}