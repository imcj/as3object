package me.imcj.as3object.sqlite.field
{
	import flash.utils.ByteArray;
	
	import me.imcj.as3object.field.Field;
	import me.imcj.as3object.sqlite.SQLiteField;

    public class IntegerField extends SQLiteField
    {
        public function IntegerField ( name : String )
        {
            super(name);
        }
        
        
        override public function adapt ( instance : Object, queryResult : Object ) : void
        {
            instance[name] = int ( queryResult[name] );
        }
    }
}