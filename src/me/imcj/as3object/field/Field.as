package me.imcj.as3object.field
{
    public class Field extends Object
    {
        protected var _name : String;
        
        public function Field ( name : String )
        {
            _name = name;
            super();
        }
        
        public function get name ( ) : String
        {
            return _name;
        }
    }
}