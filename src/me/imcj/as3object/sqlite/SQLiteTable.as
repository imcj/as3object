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
	
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Field;
    
	public class SQLiteTable extends Table implements SQL
	{
		public function SQLiteTable ( type : Object = null )
		{
			super ( type );
            
            buildFields ( );
		}
        
        protected function buildFields ( ) : void
        {
            var field : org.as3commons.reflect.Field;
            var sqliteField : me.imcj.as3object.field.Field;
            
            for each ( field in _type.fields ) {
                if ( field ) {
                    sqliteField = SQLiteField.create ( field );
                    if ( sqliteField )
                        _fields.add ( sqliteField );
                }
            }
        }
        
        protected function filterFields ( field : org.as3commons.reflect.Field ) : org.as3commons.reflect.Field
        {
            var accessor : Accessor;
            if ( field is Accessor ) {
                accessor = Accessor ( field );
                if ( ! accessor.readable )
                    return null;
            }
            
            if ( field.hasMetadata ( "Ignore" ) )
                return null;
            
            return field;
        }
        
        public function creationStatement ( ifNotExists : Boolean = false ) : String
        {
            // TODO 表字段类型和数据类型的映射
            // TODO 查阅所有的SQLite的数据类型作映射
            var field : Field;
            var i : int = 0, size : int = fields.length;
            var keys : Array = fields.keys;
            var statement : ByteArray = new ByteArray ( );
            statement.writeUTFBytes ( "CREATE TABLE " );
            if ( ifNotExists )
                statement.writeUTFBytes ( "IF NOT EXISTS " );
            statement.writeUTFBytes ( shortName );
            statement.writeUTFBytes ( " ( " );
            for ( ; i < size; i++ ) {
                field = Field ( fields.get ( keys[i] ) );
                statement.writeUTFBytes ( field.name );
                statement.writeUTFBytes ( " " );
                statement.writeUTFBytes ( field.type );
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
            var field   : Field;
            
            if ( object is Array )
                objects = new ArrayIterator ( object as Array );
            else
                objects =  new ArrayIterator ( [ object ] );
            
            buffer.writeUTFBytes ( "INSERT INTO " );
            buffer.writeUTFBytes ( shortName );
            buffer.writeUTFBytes ( " ( " );
            buffer.writeUTFBytes ( fields.keys.join ( ", " ) );
            buffer.writeUTFBytes ( " ) " );
            
            buffer.writeUTFBytes ( "VALUES " );
            
            while ( objects.hasNext ) {
                object = objects.next ( );
                buffer.writeUTFBytes ( " ( " );
                keys = new ArrayIterator ( fields.keys );
                values = new Array ( );
                while ( keys.hasNext ) {
                    key = String ( keys.next ( ) );
                    field = Field (  fields.get ( key ) );
                    
                    //					if ( field.primaryKey && field.name == "id" )
                    //						continue;
                    
                    if ( fields.get ( key ) is TextField )
                        buffer.writeUTFBytes ( "'" + object[key] + "'" );
                    else if ( field.primaryKey && field.name == "id" )
                        buffer.writeUTFBytes ( "NULL" );
                    else
                        buffer.writeUTFBytes (  object[key] );
                    
                    if ( keys.hasNext )
                        buffer.writeUTFBytes ( ", " );
                }
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
            buffer.writeUTFBytes ( shortName );
            
            var notCondition : Boolean = 0 == arguments.length;
            if ( notCondition ) {
                buffer.position = 0;
                return buffer.readUTFBytes ( buffer.length );
            }
            
            return null;
        }
        
        public function update ( object : Object, expression : Expression ) : String
        {
            var buffer : ByteArray = new ByteArray ( );
            buffer.writeUTFBytes ( "UPDATE " );
            buffer.writeUTFBytes ( shortName );
            buffer.writeUTFBytes ( " SET " );
            
            var iter : Iterator = new ArrayIterator ( fields.keys );
            var key : String;
            while ( iter.hasNext ) {
                key = String ( iter.next ( ) );
                
                buffer.writeUTFBytes ( key );
                buffer.writeUTFBytes ( " = " );
                if ( fields.get ( key ) is TextField )
                    buffer.writeUTFBytes ( "'" + object[key] + "'" );
                else
                    buffer.writeUTFBytes ( object[key] );
                
                if ( iter.hasNext )
                    buffer.writeUTFBytes ( ", " );
            }
            
            if ( expression ) {
                buffer.writeUTFBytes ( " WHERE " );
                dumpExpressionSQLCondition ( buffer, expression );
            }
            
            buffer.position = 0;
            return buffer.readUTFBytes ( buffer.length );
        }
        
        public function select ( expression : Expression ) : String
        {
            var select : ByteArray = new ByteArray ( );
            select.writeUTFBytes ( "SELECT * FROM " );
            select.writeUTFBytes ( shortName );
            
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