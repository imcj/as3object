package me.imcj.as3object.sqlite.field
{
	import flash.utils.ByteArray;
	
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
//            var format : DateFormatter = new DateFormatter ( );
//            format.formatString = "YY-MM-DD H:i";
//            instance[name] = format.format ( data[name] );
            instance[name] = data[name];
        }
        
        
        override public function buildInsertValue(buffer:ByteArray, object:Object):void
        {
            if ( "created_at" == name || "updated_at" == name ) {
                try {
                    if ( null == object['id'] || 0 == object['id'] )
                        buffer.writeUTFBytes ( "datetime()" );
                } catch ( error : ReferenceError ) {
                    buffer.writeUTFBytes ( "datetime()" );
                }
            }
            
            if ( object.hasOwnProperty ( "id" ) )
                if ( object["id"] > 0 && "updated_at" == name )
                    buffer.writeUTFBytes ( "datetime()" );
            
            
        }
        
        override public function get type():String
        {
            return "DateTime";
        }
    }
}