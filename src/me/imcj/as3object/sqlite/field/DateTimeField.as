package me.imcj.as3object.sqlite.field
{
	import me.imcj.as3object.AS3ObjectField;
	import me.imcj.as3object.sqlite.SQLiteField;
	
	import mx.formatters.DateFormatter;

    public class DateTimeField extends SQLiteField
    {
        public function DateTimeField ( name : String )
        {
            super ( name );
        }
        
        override public function setPOAOValue ( instance : Object, data : Object ) : void
        {
            var format : DateFormatter = new DateFormatter ( );
            format.formatString = "YY-MM-DD H:i";
            instance[name] = format.format ( data[name] );
        }
        
        override public function get type():String
        {
            return "DateTime";
        }
    }
}