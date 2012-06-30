package me.imcj.as3object
{
    import me.imcj.as3object.expression.Expression;

    public class Criteria
    {
        protected var _expression:Array;
        
        public function Criteria ( )
        {
            _expression = new Array ( );
        }
        
        public function add ( expression : Expression ) : Criteria
        {
            _expression.push ( expression );
            return this;
        }
        
        public function list ( ) : Array
        {
            
        }
    }
}