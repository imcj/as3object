package me.imcj.as3object.expression
{
    public class InExpression extends Expression
    {
        protected var _field : String;
        protected var _value : Array;
        
        public function InExpression ( field : String, value : Array )
        {
            _field = field;
            _value = value;
        }
        
        public function get left ( ) : String
        {
            return _field;
        }
        
        public function get right ( ) : Array
        {
            return _value;
        }
    }
}