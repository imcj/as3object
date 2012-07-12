package me.imcj.as3object.sqlite.field
{
	import me.imcj.as3object.field.Field;
	import me.imcj.as3object.sqlite.SQLiteField;
	
	import mx.formatters.DateFormatter;

    public class DateTimeField extends SQLiteField
    {
        public function DateTimeField ( name : String )
        {
            super ( name );
        }
        
        override public function fill ( instance : Object, data : Object ) : void
        {
            var format : DateFormatter = new DateFormatter ( );
            format.formatString = "YY-MM-DD H:i";
            instance[name] = format.format ( data[name] );
        }
    }
}