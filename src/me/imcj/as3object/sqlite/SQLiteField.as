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
    
    import org.as3commons.reflect.Field;
    import flash.utils.ByteArray;
    
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
        
        /**
         * 构造CREATE TABLE 的字段定义部分
         * 
         * @example 
         * <listing version="3.0">
         * var buffer : ByteArray = new ByteArray ( );
         * buffer.writeUTFString ( "CREATE TABLE pet ( " );
         * 
         * var field : IntegerField = new IntegerField ( "id" );
         * field.primaryKey = true;
         * field.autoIncrement = true;
         * field.order = Order.ASC;
         * field.buildCreateTableColumnDefine ( buffer );
         * // CREATE TABLE pet ( id INTEGER PRIMARY KEY ASC AUTOINCREMENT )
         * </listing>
         */
        override public function buildCreateTableColumnDefine ( buffer : ByteArray ) : void
        {
            buffer.writeUTFBytes ( name );
            buffer.writeUTFBytes ( " " );
            buffer.writeUTFBytes ( type );
            
            if ( primaryKey ) {
                buffer.writeUTFBytes ( " " );
                buffer.writeUTFBytes ( "PRIMARY KEY" );
                buffer.writeUTFBytes ( " " );
                buffer.writeUTFBytes ( order );
                
                if ( autoIncrement )
                    buffer.writeUTFBytes ( " AUTOINCREMENT" );
            }
        }
        
        // TODO 清理TODO 完成这些部分
        override public function buildInsertColumn ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
        
        override public function buildInsertValue ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
        
        override public function buildUpdateAssign ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
        
        static public function create ( field : org.as3commons.reflect.Field ) : SQLiteField
        {
            TextField;
            RealField;
            IntegerField;
            ArrayCollectionField;
            
            var qname : String;
            var type : String;
            var name : String;
            type = mapping[type];
            
            if ( "ArrayCollection" == type )
                return null;
            
            qname = StringUtil.substitute ( "me.imcj.as3object.sqlite.field.{0}Field", type );
			var fieldClass : Class = Class ( getDefinitionByName ( qname ) );
			var instance : SQLiteField;
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