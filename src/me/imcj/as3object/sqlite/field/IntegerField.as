package me.imcj.as3object.sqlite.field
{
	import flash.utils.ByteArray;
	
	import me.imcj.as3object.AS3ObjectField;
	import me.imcj.as3object.sqlite.SQLiteField;

    public class IntegerField extends SQLiteField
    {
        public function IntegerField ( name : String )
        {
            super(name);
        }
        
        override public function get type ( ) : String
        {
            return "Integer";
        }
        
        override public function setPOAOValue(instance:Object, data:Object):void
        {
            if ( isMethod )
                instance[setMethodName ( )] ( data[name] );
            else
                instance[name] = data[name];
        }
    }
}