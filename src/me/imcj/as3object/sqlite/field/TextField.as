package me.imcj.as3object.sqlite.field
{
	import flash.utils.ByteArray;
	
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
        
        override public function setPOAOValue ( instance : Object, data : Object ) : void
        {
            instance[name] = String ( data[name] );
        }
        
        override public function buildInsertValue(buffer:ByteArray, object:Object):void
        {
            if ( primaryKey && autoIncrement )
                buffer.writeUTFBytes ( "NULL" );
            else
                buffer.writeUTFBytes ( "'" + String ( getPOAOValue ( object ) ) + "'" );
        }
        
//        public function dataType ( ) : String
//        {
//            return "TEXT";
//        }
    }
}