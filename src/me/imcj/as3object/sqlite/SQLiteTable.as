package me.imcj.as3object.sqlite
{
	import me.imcj.as3object.Table;
	
	public class SQLiteTable extends Table
	{
		public function SQLiteTable ( type : Class = null )
		{
			_builder = new SQLiteFieldBuilder ( );
			_sql     = new SQLite ( this );
			super(type);
		}
	}
}