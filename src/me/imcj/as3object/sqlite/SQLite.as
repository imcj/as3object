package me.imcj.as3object.sqlite
{
	import me.imcj.as3object.ISQL;
	import me.imcj.as3object.Table;

	public class SQLite implements ISQL
	{
		protected var _table : Table;
		
		public function SQLite ( table : Table )
		{
			_table = table;
		}
		
		public function insert ( ...arg ) : String
		{
			var fields : Array;
//			if ( arg.length > 1 )
			//            var name : String = getDefinitionByName ( object );
			//            var accessor : Object;
			//            var key : String;
			//            var table : Table = factory.cache.get ( name );
			//            var sql : ByteArray = new ByteArray ( );
			//            sql.writeUTFBytes ( "INSERT INTO " );
			//            sql.writeUTFBytes ( table.tableName );
			//            sql.writeUTFBytes ( " ( " );
			//            
			return null;
		}
		
		public function remove ( ...arg ) : String
		{
			return null;
		}
		
		public function update ( ...arg ) : String
		{
			return null;
		}
		
		public function select ( ...arg ) : String
		{
			return null;
		}
	}
}