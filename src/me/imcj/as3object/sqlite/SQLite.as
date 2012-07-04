package me.imcj.as3object.sqlite
{
	import flash.utils.ByteArray;
	
	import me.imcj.as3object.SQL;
	import me.imcj.as3object.Table;
	import me.imcj.as3object.core.ArrayIterator;
	import me.imcj.as3object.core.Iterator;
	import me.imcj.as3object.expression.Expression;
	import me.imcj.as3object.field.Field;
	import me.imcj.as3object.sqlite.field.TextField;

	public class SQLite implements SQL
	{
		protected var _table : Table;
		
		public function SQLite ( table : Table )
		{
			_table = table;
		}
        
        public function creationStatement () : String
        {
            // FIXME 迭代器模式
            // TODO 表字段类型和数据类型的映射
            // TODO 查阅所有的SQLite的数据类型作映射
            var field : Field;
            var i : int = 0, size : int = _table.fields.length;
            var keys : Array = _table.fields.keys;
            var statement : ByteArray = new ByteArray ( );
            statement.writeUTFBytes ( "CREATE TABLE " );
            statement.writeUTFBytes ( _table.shortName );
            statement.writeUTFBytes ( " ( " );
            for ( ; i < size; i++ ) {
                field = Field ( _table.fields.get ( keys[i] ) );
                statement.writeUTFBytes ( field.name );
                statement.writeUTFBytes ( " " );
                statement.writeUTFBytes ( field.dataType );
                if ( field.primaryKey ) {
                    statement.writeUTFBytes ( " " );
                    statement.writeUTFBytes ( "PRIMARY KEY" );
                    statement.writeUTFBytes ( " " );
                    statement.writeUTFBytes ( field.order );
                    if ( field.autoIncrement )
                        statement.writeUTFBytes ( " AUTOINCREMENT" );
                }
                
                if ( size - 1 > i )
                    statement.writeUTFBytes ( ", " );
                
            }
            
            statement.writeUTFBytes ( " );" );
            statement.position = 0;
            var statementSQL : String = statement.readUTFBytes ( statement.length );
            return statementSQL;
        }
		
		public function insert ( object : Object ) : String
		{
            var buffer    : ByteArray = new ByteArray ( );
            var object : Object;
            var keys   : Iterator;
            var key    : String;
            var size   : int;
            var values : Array;
            var objects : Iterator;
            
            if ( object is Array )
                objects = new ArrayIterator ( Array ( object ) );
            else
                objects =  new ArrayIterator ( [ object ] );
            
            buffer.writeUTFBytes ( "INSERT INTO " );
            buffer.writeUTFBytes ( _table.shortName );
            buffer.writeUTFBytes ( " ( " );
            buffer.writeUTFBytes ( _table.fields.keys.join ( ", " ) );
            buffer.writeUTFBytes ( " ) " );
            
            buffer.writeUTFBytes ( "VALUES " );
            
            while ( object = objects.next ) {
                buffer.writeUTFBytes ( " ( " );
                
                keys = new ArrayIterator ( _table.fields.keys );
                values = new Array ( );
                while ( key = String ( keys.next ) )
                    if ( _table.fields.get ( key ) is TextField )
                        buffer.writeUTFBytes ( "'" + object[key] + "'" + keys.hasNext ? ", " : "" );
                    else
                        buffer.writeUTFBytes (  object[key] + keys.hasNext ? ", " : "" );
                
                buffer.writeUTFBytes ( " )" );
                
                if ( objects.hasNext )
                    buffer.writeUTFBytes ( ", \n" );
            }
            
            buffer.writeUTFBytes ( ";" );
            
            buffer.position = 0;
			return buffer.readUTFBytes ( buffer.length );
		}
        
		public function remove ( object : Object, expression : Expression ) : String
		{
            var buffer : ByteArray = new ByteArray ( );
            buffer.writeUTFBytes ( "DELETE FROM " );
            buffer.writeUTFBytes ( _table.shortName );

            var notCondition : Boolean = 0 == arguments.length;
            if ( notCondition ) {
                buffer.position = 0;
                return buffer.readUTFBytes ( buffer.length );
            }
            
			return null;
		}
		
		public function update ( arguments : Array ) : String
		{
			return null;
		}
		
		public function select ( expression : Expression ) : String
		{
			var select : ByteArray = new ByteArray ( );
            select.writeUTFBytes ( "SELECT * FROM " );
            select.writeUTFBytes ( _table.shortName );
            
            if ( expression ) {
                select.writeUTFBytes ( " WHERE " );
                dumpExpressionSQLCondition ( select, expression );
            }
            
            select.position = 0;
            return select.readUTFBytes ( select.length );
		}
        
        protected function dumpExpressionSQLCondition ( buffer : ByteArray, expression : Expression ) : ByteArray
        {
            var dump : SQLiteDumpExpression =  new SQLiteDumpExpression ( buffer, expression );
            return dump.toByteArray ( );
        }
    }
}