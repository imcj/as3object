package me.imcj.as3object
{
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.field.*;
    
    import mx.core.ClassFactory;
    import mx.utils.StringUtil;

    public class Table
    {
        protected var _data : Object;
        protected var _fields : Dict;
        protected var _name : String;
        protected var _package : String;
        protected var _shortName : String;
        
        public function Table ( type : Class = null )
        {
            _fields = new Dict ( );
            
            _name = getQualifiedClassName ( type );
            var fullName : Array = _name.split ( ":" );
            _shortName = fullName[1];
            _package = fullName[0];
            
            generateFields ( type );
        }
        
        protected function generateFields ( type : Class ):void
        {
            var describe : XML = describeType ( type );
            var variable : XML;
            var metadata : XML;
            var ignore   : Boolean = false;
            var objectFields : XML = <fields />;
            var objectField  : XML;
            var name : String;
            
            for each ( variable in describe.factory.variable ) {
                objectField = <field name={variable.@name} type={variable.@type} />;
                objectField.metadata += variable.metadata;
                objectFields.appendChild ( objectField )
            }
            
            for each ( variable in describe.factory.accessor.( @access == "readonly" || @access == "readwrite" ) ) {
                objectField = <field name={variable.@name} type={variable.@type} declaredBy={variable.@declaredBy} />;
                objectField.metadata += variable.metadata;
                objectFields.appendChild ( objectField )
            }
            
            for each ( variable in describe.factory.method ) {
                
                if ( ! String ( variable.@name ).substr ( 0, 3 ) == "get" )
                    continue;
                
                name = String ( variable.@name ).substr ( 3 );
                
                objectField = <field name={name} type={variable.@returnType} declareBy={variable.@declareBy} />;
                objectField.metadata += variable.metadata;
                objectFields.appendChild ( objectField )
            }
            
            for each ( variable in objectFields.field ) {
                if ( hasMetadata ( "Exclude", variable.metadata ) )
                    continue;
                
                var fieldName : String = StringUtil.substitute ( "me.imcj.as3object.field.{0}Field", variable.@type );
                trace ( fieldName );
                getDefinitionByName ( fieldName );
                if ( "int" == String ( variable.@type ) )
                    addField ( new IntegerField (  String ( variable.@name ) ) )
                else if ( "String" == String ( variable.@type ) )
                    addField ( new TextField (  String ( variable.@name ) ) )
                else if ( "Point" == String ( variable.@type ) )
                    addField ( new Field ( String ( variable.@type )  ) );
            }
        }
        
        protected function hasMetadata ( name : String, metadata : XMLList ) : Boolean
        {
            return metadata.( @name == name ).length () > 0 ? true : false;
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
        
        public function insert ( ...params ) : void
        {
        }
        
        public function get fields ( ) : Dict
        {
            return _fields;
        }
        
        public function set data ( value : Object ) : void
        {
            _data = value;
        }
    }
}