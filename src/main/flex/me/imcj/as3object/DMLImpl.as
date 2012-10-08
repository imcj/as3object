package me.imcj.as3object {
import flash.utils.ByteArray;

import me.imcj.as3object.core.ArrayIterator;
import me.imcj.as3object.core.DictIterator;
import me.imcj.as3object.core.Iterator;
import me.imcj.as3object.core.KeyValue;
import me.imcj.as3object.expression.Expression;
import me.imcj.as3object.sqlite.SQLiteDumpExpression;

public class DMLImpl implements DML
{
    private var table:Table;
    
    public function DMLImpl ( table : Table )
    {
        this.table = table;
    }
    
    public function insert ( object : Object ) : String
    {
        var buffer    : ByteArray = new ByteArray ( );
        var objects   : Iterator;
        var iter : DictIterator;
        var columnValue : String;
        
        if ( object is Array )
            objects = new ArrayIterator ( object as Array );
        else
            objects =  new ArrayIterator ( [ object ] );
        
        buffer.writeUTFBytes ( "INSERT INTO " );
        buffer.writeUTFBytes ( table.name );
        buffer.writeUTFBytes ( " ( " );
        
        table.eachAllColumn ( function ( column : Column ) : void {
            if ( column.isOneToMany )
                return;
            
            buffer.writeUTFBytes ( column.sqlName );
            buffer.writeUTFBytes ( ", " );
        } );
        
        buffer.position -= 2;
        
        buffer.writeUTFBytes ( " ) " );
        buffer.writeUTFBytes ( "VALUES " );
        
        while ( objects.hasNext ) {
            object = objects.next ( );
            buffer.writeUTFBytes ( " ( " );
            
            table.eachAllColumn ( function ( column : Column ) : void {
                if ( column.isOneToMany )
                    return;
                columnValue = getValue ( column, object );
                buffer.writeUTFBytes ( columnValue );
                buffer.writeUTFBytes ( ", " );
            } );
            
            buffer.position -= 2;
            buffer.writeUTFBytes ( " )" );
            
            if ( objects.hasNext )
                buffer.writeUTFBytes ( ", \n" );
        }
        
        buffer.writeUTFBytes ( ";" );
        
        buffer.position = 0;
        return buffer.readUTFBytes ( buffer.length );
    }
    
    protected function getValue ( column : Column, object : Object ) : String
    {
        return column.getSqlValue ( object );
    }
    
    public function remove ( object : Object, expression : Expression ) : String
    {
        var buffer : ByteArray = new ByteArray ( );
        buffer.writeUTFBytes ( "DELETE FROM " );
        buffer.writeUTFBytes ( table.name );
        
        var notCondition : Boolean = 0 == arguments.length;
        if ( notCondition ) {
            buffer.position = 0;
            return buffer.readUTFBytes ( buffer.length );
        }
        
        return null;
    }
    
    public function update (  object : Object, expression : Expression ) : String
    {
        var buffer : ByteArray = new ByteArray ( );
        buffer.writeUTFBytes ( "UPDATE " );
        buffer.writeUTFBytes ( table.name );
        buffer.writeUTFBytes ( " SET " );
        
        
        
        table.eachAllColumn ( function ( column : Column ) : void
        {
            var value : String;
            
            if ( ! object.hasOwnProperty ( column.name ) )
                return;
            
            try {
                value = column.getSqlValue ( object );
            } catch ( e : Error ) {
                return;
            }
            
            if ( ! value )
                return;
            
            buffer.writeUTFBytes ( column.name );
            buffer.writeUTFBytes ( " = " );
            buffer.writeUTFBytes ( "'" + value + "'" );
            
            buffer.writeUTFBytes ( ", " );
        } );
        
        buffer.position -= 2;
        
        if ( expression ) {
            buffer.writeUTFBytes ( " WHERE " );
            dumpExpressionSQLCondition ( buffer, expression );
        }
            
        
        buffer.position = 0;
        return buffer.readUTFBytes ( buffer.length );
    }
    
    public function select ( expression : Expression, orders : Array = null ) : String
    {
        var select : ByteArray = new ByteArray ( );
        select.writeUTFBytes ( "SELECT * FROM " );
        select.writeUTFBytes ( table.name );
        
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