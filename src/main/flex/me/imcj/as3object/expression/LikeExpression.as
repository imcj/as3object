package me.imcj.as3object.expression
{
    public class LikeExpression extends Expression
    {
        protected var _value:String;
        protected var _field:String;
        
        public function LikeExpression ( field : String, value : String )
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