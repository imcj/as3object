package me.imcj.as3object.expression
{
    import org.hamcrest.mxml.number.GreaterThan;

    public class Expression
    {
        public function Expression ( )
        {
        }
        
        static public function eq ( key : String, value : * ) : Expression
        {
            return new EqualExpression ( key, value );
        }
        
        static public function In ( key : String, value : Array )  : Expression
        {
            return new InExpression ( key, value );
        }
        
        static public function not  ( key : String, value : String )  : Expression
        {
            return new NotExpression ( key, value );
        }
        
        static public function gt  ( key : String, value : String )  : Expression
        {
            return new GreaterThanExpression ( key, value );
        }
        
        static public function ge  ( key : String, value : String )  : Expression
        {
            return new GreaterThanEqualExpression ( key, value );
        }
        
        static public function lt  ( key : String, value : String )  : Expression
        {
            return new LessThanExpression ( key, value );
        }
        
        static public function le  ( key : String, value : String )  : Expression
        {
            return new LessThanEqualExpression ( key, value );
        }
        
        static public function like  ( key : String, value : String )  : Expression
        {
            return new LikeExpression ( key, value );
        }
        
        static public  function and ( argument : Array ) : LogicalExpression
        {
			return new AndExpression ( argument );
        }
		
		static public function or ( ... argument ) : OrExpression
		{
			return new OrExpression ( argument );
		}
	}
}