package me.imcj.as3object.sqlite
{
	import flash.utils.ByteArray;
	
	import me.imcj.as3object.AS3ObjectField;
	import me.imcj.as3object.FieldFactory;
	import me.imcj.as3object.Order;
	import me.imcj.as3object.SQLField;
	import me.imcj.as3object.Table;
	import me.imcj.as3object.core.ArrayIterator;
	import me.imcj.as3object.core.Iterator;
	import me.imcj.as3object.expression.Expression;
	import me.imcj.as3object.sqlite.field.TextField;
	
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Field;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
    
	public class SQLiteTable extends Table
	{
        
		public function SQLiteTable ( type : Type = null )
		{
			super ( type );
            factory = new FieldFactorySQLite ( this );
            factory.create ();
		}
        
        override public function creationStatement ( ifNotExists : Boolean = false ) : String
        {
            // TODO 表字段类型和数据类型的映射
            // TODO 查阅所有的SQLite的数据类型作映射
            var field : SQLField;
            var i : int = 0, size : int = fields.length;
            var keys : Array = fields.keys;
            var statement : ByteArray = new ByteArray ( );
            statement.writeUTFBytes ( "CREATE TABLE " );
            if ( ifNotExists )
                statement.writeUTFBytes ( "IF NOT EXISTS " );
            statement.writeUTFBytes ( shortName );
            statement.writeUTFBytes ( " ( " );
            for ( ; i < size; i++ ) {
                field = SQLField ( fields.get ( keys[i] ) );
                field.buildCreateTableColumnDefine ( statement );
                
                if ( size - 1 > i )
                    statement.writeUTFBytes ( ", " );
                
            }
            
            statement.writeUTFBytes ( " );" );
            statement.position = 0;
            var statementSQL : String = statement.readUTFBytes ( statement.length );
            return statementSQL;
        }
        
        override public function insert ( object : Object ) : String
        {
            var buffer    : ByteArray = new ByteArray ( );
            var keys      : Iterator;
            var key       : String;
            var objects   : Iterator;
            var field     : SQLField;
            
            if ( object is Array )
                objects = new ArrayIterator ( object as Array );
            else
                objects =  new ArrayIterator ( [ object ] );
            
            buffer.writeUTFBytes ( "INSERT INTO " );
            buffer.writeUTFBytes ( shortName );
            buffer.writeUTFBytes ( " ( " );
            
            for ( keys = new ArrayIterator ( fields.keys ); keys.hasNext;  ) {
                key = String ( keys.next ( ) );
                field = SQLField ( fields.get ( key ) );
                
                field.buildInsertColumn ( buffer );
                
                if ( keys.hasNext )
                    buffer.writeUTFBytes ( ", " );
            }
            
            buffer.writeUTFBytes ( " ) " );
            
            buffer.writeUTFBytes ( "VALUES " );
            
            while ( objects.hasNext ) {
                object = objects.next ( );
                buffer.writeUTFBytes ( " ( " );
                keys = new ArrayIterator ( fields.keys );
                while ( keys.hasNext ) {
                    key = String ( keys.next ( ) );
                    field = SQLField (  fields.get ( key ) );
                    field.buildInsertValue ( buffer, object );
                    
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
        
        override public function remove ( object : Object, expression : Expression ) : String
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
        
        override public function update ( object : Object, expression : Expression ) : String
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
        
        override public function select ( expression : Expression, orders : Array = null ) : String
        {
            var select : ByteArray = new ByteArray ( );
            select.writeUTFBytes ( "SELECT * FROM " );
            select.writeUTFBytes ( shortName );
            
            if ( expression ) {
                select.writeUTFBytes ( " WHERE " );
                dumpExpressionSQLCondition ( select, expression );
            }
            
            var iter : Iterator;
            var order : Order;
            if ( orders && orders.length > 0 ) {
                select.writeUTFBytes ( " ORDER BY " );
                
                for ( iter = new ArrayIterator ( orders ); order = Order ( iter.next ( ) ); ) {
                    select.writeUTFBytes ( order.propertyName );
                    select.writeUTFBytes ( " " );
                    select.writeUTFBytes ( order.sort );
                    
                    if ( iter.hasNext )
                        select.writeUTFBytes ( ", " );
                    else
                        break;
                }
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