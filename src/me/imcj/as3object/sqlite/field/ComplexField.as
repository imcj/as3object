package me.imcj.as3object.sqlite.field
{
    import me.imcj.as3object.field.Field;

    public class ComplexField extends Field
    {
        protected var _fields : Array;
        
        public function ComplexField ( )
        {
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