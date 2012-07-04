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
        
//        public function dataType ( ) : String
//        {
//            return "TEXT";
//        }
    }
}