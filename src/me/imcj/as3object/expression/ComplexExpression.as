package me.imcj.as3object.expression
{
	public class ComplexExpression extends Expression
	{
		protected var _expressions : Array = new Array ( );
		
		public function ComplexExpression ( )
		{
		}
		
		public function addExpression ( expression : Expression ) : Expression
		{
			_expressions.push ( expression );
		}
	}
}