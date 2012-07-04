package me.imcj.as3object.sqlite
{
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.field.Field;
    import me.imcj.as3object.sqlite.field.IntegerField;
    import me.imcj.as3object.sqlite.field.NumberField;
    import me.imcj.as3object.sqlite.field.TextField;
    
    import mx.utils.StringUtil;
    
    public class SQLiteField extends Field
    {
        static protected var mapping : Object = {
            "String"  : "TEXT",
            "int"     : "INTEGER",
            "uint"    : "INTEGER",
            "Number"  : "REAL",
            "Date"    : "TEXT",
            "Boolean" : "INTEGER"
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
        
        static public function create ( name : String, type : String ) : SQLiteField
        {
            TextField;
            NumberField;
            IntegerField;
            
            type = String ( mapping[type] ).substr ( 0, 1 ).toUpperCase ( ) + String ( mapping[type] ).substr ( 1 ).toLowerCase ( );
            
            var fieldClass : Class = Class ( getDefinitionByName ( StringUtil.substitute ( "me.imcj.as3object.sqlite.field.{0}Field", type ) ) );  
            return new fieldClass ( name );
        }
    }
}