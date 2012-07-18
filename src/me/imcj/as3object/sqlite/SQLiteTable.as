package me.imcj.as3object.sqlite
{
	import flash.utils.ByteArray;
	
	import me.imcj.as3object.AS3ObjectField;
	import me.imcj.as3object.Order;
	import me.imcj.as3object.SQL;
	import me.imcj.as3object.Table;
	import me.imcj.as3object.core.ArrayIterator;
	import me.imcj.as3object.core.Iterator;
	import me.imcj.as3object.expression.Expression;
	import me.imcj.as3object.sqlite.field.TextField;
	
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Field;
	import org.as3commons.reflect.Method;
    
	public class SQLiteTable extends Table
	{
		public function SQLiteTable ( type : Object = null )
		{
			super ( type );
            
            buildFields ( );
		}
        
        protected function buildFields ( ) : void
        {
            var field : org.as3commons.reflect.Field;
            var sqliteField : me.imcj.as3object.AS3ObjectField;
            var method : Method;
            var factory : FieldFactory = FieldFactory.instance;
            
            for each ( field in _type.fields ) {
                if ( filterField ( field ) ) {
                    sqliteField = factory.createByField ( field );
                    if ( sqliteField )
                        _fields.add ( sqliteField.name, sqliteField );
                }
            }
            
            for each ( method in _type.methods ) {
                if ( method.hasMetadata ( "Field" ) )
                    if ( _type.getMethod ( getSetMethodName ( method.name ) ) )
                        if ( ( sqliteField = factory.createByMethod ( method ) ) )
                            _fields.add ( sqliteField.name, sqliteField );
            }
        }
        
        protected function getSetMethodName ( name : String ) : String
        {
            if ( "get" == name.substr ( 0, 3 ) )
                return "set" + name.substr ( 3 );
            return null;
        }
        
        protected function filterField ( field : org.as3commons.reflect.Field ) : org.as3commons.reflect.Field
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
        
        override public function creationStatement ( ifNotExists : Boolean = false ) : String
        {
            // TODO 表字段类型和数据类型的映射
            // TODO 查阅所有的SQLite的数据类型作映射
            var field : AS3ObjectField;
            var i : int = 0, size : int = fields.length;
            var keys : Array = fields.keys;
            var statement : ByteArray = new ByteArray ( );
            statement.writeUTFBytes ( "CREATE TABLE " );
            if ( ifNotExists )
                statement.writeUTFBytes ( "IF NOT EXISTS " );
            statement.writeUTFBytes ( shortName );
            statement.writeUTFBytes ( " ( " );
            for ( ; i < size; i++ ) {
                field = AS3ObjectField ( fields.get ( keys[i] ) );
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
            var object : Object;
            var keys   : Iterator;
            var key    : String;
            var size   : int;
            var values : Array;
            var objects : Iterator;
            var field   : AS3ObjectField;
            
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
                    field = AS3ObjectField (  fields.get ( key ) );
                    
                    if ( field is TextField )
                        buffer.writeUTFBytes ( "'" + field.getValue ( object ) + "'" );
                    else if ( field.primaryKey && field.name == "id" )
                        buffer.writeUTFBytes ( "NULL" );
                    else {
                        try {
                            buffer.writeUTFBytes ( String ( field.getValue ( object ) ) );
                        } catch ( error : TypeError ) {
                        }
                    }
                    
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
            if ( orders ) {
                select.writeUTFBytes ( " ORDER BY " );
                
                for ( iter = new ArrayIterator ( orders ); ; ) {
                    order = Order ( iter.next ( ) );
                    
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