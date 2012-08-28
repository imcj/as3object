package me.imcj
{
    import me.imcj.as3object.expression.Expression;

    public interface DMS
    {
        function insert ( object : Object ) : String;
        function update ( object : Object, expression : Expression ) : String;
        function remove ( object : Object, expression : Expression ) : String;
        function select ( expression : Expression, order : Array = null ) : String;
    }
}