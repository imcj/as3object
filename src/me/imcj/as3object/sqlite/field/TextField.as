package me.imcj.as3object.sqlite.field
{
	import me.imcj.as3object.field.Field;
	import me.imcj.as3object.sqlite.SQLiteField;

    public class TextField extends SQLiteField
    {
        public function TextField ( name : String )
        {
            super ( name );
        }
        
        override public function fill ( instance : Object, data : Object ) : void
        {
            instance[name] = String ( data[name] );
        }
        
//        public function dataType ( ) : String
//        {
//            return "TEXT";
//        }
    }
}