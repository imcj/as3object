package me.imcj.as3object.sqlite.field
{
	import me.imcj.as3object.AS3ObjectField;
	import me.imcj.as3object.sqlite.SQLiteField;

    public class TextField extends SQLiteField
    {
        public function TextField ( name : String )
        {
            super ( name );
        }
        
        override public function get type ( ) : String
        {
            return "TEXT";
        }
        
        override public function assignValue ( instance : Object, data : Object ) : void
        {
            instance[name] = String ( data[name] );
        }
        
//        public function dataType ( ) : String
//        {
//            return "TEXT";
//        }
    }
}