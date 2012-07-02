package me.imcj.as3object.expression
{
    import org.hamcrest.mxml.number.GreaterThan;

    public class Expression
    {
        public function Expression ( )
        {
        }
        
        static public function eq ( key : String, value : String ) : Expression
        {
        }
        
        static public function In ( key : String, value : Array )  : Expression
        {
        }
        
        static public function not  ( key : String, value : Array )  : Expression
        {
            
        }
        
        static public function gt  ( key : String, value : String )  : Expression
        {
            return new GreaterThan ( key, value );
        }
        
        static public function ge  ( key : String, value : String )  : Expression
        {
            
        }
        
        static public function lt  ( key : String, value : String )  : Expression
        {
            
        }
        
        static public function le  ( key : String, value : String )  : Expression
        {
            
        }
        
        static public  function and ( left : Expression, right : Expression ) : LogicalExpression
        {
			return new AndExpression ( left, right );
        }
		
		static public function or ( left : Expression, right : Expression ) : OrExpression
		{
			return new OrExpression ( left, right );
		}
	}
}