package me.imcj.as3object.expression
{
    public class EquationExpression extends Expression
    {
        protected var _field : String;
        protected var _value : String;
        
        public function EquationExpression ( field : String, value : String )
        {
            _field = field;
            _value = value;
            super();
        }
        
        public function get left ( ) : String
        {
            return _field;
        }
        
        public function get right ( ) : String
        {
            return _value;
        }
    }
}