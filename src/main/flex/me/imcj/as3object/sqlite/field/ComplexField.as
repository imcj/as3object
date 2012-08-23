package me.imcj.as3object.sqlite.field
{
    import me.imcj.as3object.AS3ObjectField;

    public class ComplexField extends AS3ObjectField
    {
        protected var _fields : Array;
        
        public function ComplexField ( name : String )
        {
            super ( name );
            _fields = new Array ( );
        }

        public function get fields():Array
        {
            return _fields;
        }

        public function set fields(value:Array):void
        {
            _fields = value;
        }

    }
}