package me.imcj.as3object.sqlite.field
{
	import me.imcj.as3object.sqlite.SQLiteField;

    public class RealField extends SQLiteField
    {
        public function RealField ( name : String )
        {
            super ( name );
        }
        
        override public function get type ( ) : String
        {
            return "REAL";
        }
        
        override public function setPOAOValue ( instance : Object, data : Object ) : void
        {
            instance[name] = new Number ( data[name] );
        }
    }
}