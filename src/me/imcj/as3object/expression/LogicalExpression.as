package me.imcj.as3object.expression
{
    public class LogicalExpression extends Expression
    {
		protected var _left  : Expression;
		protected var _right : Expression;
		
        public function LogicalExpression ( left : Expression, right : Expression )
        {
			_left  = left;
			_right = right;
			
            super ( );
        }
    }
}