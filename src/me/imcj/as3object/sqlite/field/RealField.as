package me.imcj.as3object.sqlite.field
{
	import me.imcj.as3object.field.Field;
	import me.imcj.as3object.sqlite.SQLiteField;

    public class RealField extends SQLiteField
    {
        public function RealField ( name : String )
        {
            super ( name );
        }
        
        override public function fill ( instance : Object, data : Object ) : void
        {
            instance[name] = new Number ( data[name] );
        }
    }
}