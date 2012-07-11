package me.imcj.as3object.sqlite
{
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.field.Field;
    import me.imcj.as3object.sqlite.field.ArrayCollectionField;
    import me.imcj.as3object.sqlite.field.IntegerField;
    import me.imcj.as3object.sqlite.field.RealField;
    import me.imcj.as3object.sqlite.field.TextField;
    
    import mx.utils.StringUtil;
    
    public class SQLiteField extends Field
    {
        static protected var mapping : Object = {
            "String"  : "Text",
            "int"     : "Integer",
            "uint"    : "Integer",
            "Number"  : "Real",
            "Date"    : "DateTime",
            "Boolean" : "Integer",
            "mx.collections::ArrayCollection" : "ArrayCollection"
        };
        
        public function SQLiteField(name:String)
        {
            
            super(name);
        }
        
        override public function get dataType ( ) : String
        {
            var qname : String = getQualifiedClassName ( this );
            var fullName : Array = qname.split ( "::" );
            var name : String = fullName[1];
            name = name.substring ( 0, name.lastIndexOf ( "Field" ) );
            return String ( name ).toUpperCase ( );
        }
        
        static public function create ( variable : XML ) : SQLiteField
        {
            TextField;
            RealField;
            IntegerField;
            ArrayCollectionField;
            
            var name : String = variable.@name, type : String = variable.@type;
            var qname : String;
//            type = String ( mapping[type] ).substr ( 0, 1 ).toUpperCase ( ) + String ( mapping[type] ).substr ( 1 ).toLowerCase ( );
            type = mapping[type];
            
            if ( hasMetadata ( "Ignore", variable.metadata ) )
                return null;
            
            // TODO as3-commons-reflection
//            var isDomain : XML = variable.metadata.( @name == "Domain" )[0];
            if ( "ArrayCollection" == type )
                return null;
            
            qname = StringUtil.substitute ( "me.imcj.as3object.sqlite.field.{0}Field", type );
			var fieldClass : Class = Class ( getDefinitionByName ( qname ) );
			var instance : Field;
			switch ( type ) {
				case "ArrayCollection":
//					return new fieldClass ( name, 
					break;
				default:
					instance = new fieldClass ( name );
					break;
			}
			
			return instance;
        }
        
        static protected function hasMetadata ( name : String, metadata : XMLList ) : Boolean
        {
            return metadata.( @name == name ).length () > 0 ? true : false;
        }
    }
}