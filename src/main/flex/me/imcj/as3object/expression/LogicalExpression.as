package me.imcj.as3object.expression
{
    public class LogicalExpression extends Expression
    {
		protected var _expressions : Array;
        
        public function LogicalExpression ( argument : Array )
        {
			_expressions = argument;
			
            super ( );
        }

        public function get expressions ( ) : Array
        {
            return _expressions;
        }

    }
}