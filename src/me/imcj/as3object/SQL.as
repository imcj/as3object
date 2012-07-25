package me.imcj.as3object
{
    import me.imcj.as3object.expression.Expression;

	public interface SQL
	{
        function creationStatement ( ifNotExists : Boolean = false ) : String;
		function insert ( object : Object ) : String;
		function update ( object : Object, expression : Expression ) : String;
		function remove ( object : Object, expression : Expression ) : String;
		function select ( expression : Expression, order : Array = null ) : String;
	}
}