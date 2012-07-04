package me.imcj.as3object.sqlite
{
	import me.imcj.as3object.Table;
	import me.imcj.as3object.expression.Expression;
	
	public class SQLiteTable extends Table
	{
		public function SQLiteTable ( type : Class = null )
		{
			_builder = new SQLiteFieldBuilder ( );
			_sql     = new SQLite ( this );
			super(type);
		}
        
        override public function creationStatement () : String
        {
            return _sql.creationStatement ( );
        }
        
        override public function insert ( object : Object ) : String
        {
            return _sql.insert ( object );
        }
        
        override public function update ( object : Object, expression : Expression ) : String
        {
            return _sql.update ( object, expression );
        }
        
        override public function remove ( object : Object, expression : Expression ) : String
        {
            return _sql.remove ( object, expression );
        }
        
        override public function select ( expression : Expression ) : String
        {
            return _sql.select ( expression );
        }
	}
}