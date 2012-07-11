package me.imcj.as3object.sqlite.field
{
	import me.imcj.as3object.field.Field;
	import me.imcj.as3object.sqlite.SQLiteField;

    public class IntegerField extends SQLiteField
    {
        public function IntegerField ( name : String )
        {
            super(name);
        }
        
        override public function fill ( instance : Object, data : Object ) : void
        {
            instance[name] = int ( data[name] );
        }
    }
}