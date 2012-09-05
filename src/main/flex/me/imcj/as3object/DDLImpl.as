package me.imcj.as3object {
import flash.utils.ByteArray;

import me.imcj.as3object.core.Dict;

import org.as3commons.reflect.Type;

public class DDLImpl implements DDL
{
    protected var table:Table;
    
    public function DDLImpl ( table : Table ) : void
    {
        this.table = table;            
    }
    
    public function createTable ( ifNotExists : Boolean ) : String
    {
        var fields : Dict = table.columns;
        var field : Column;
        var i : int = 0, size : int = fields.length;
        var keys : Array = fields.keys;
        
        var statement : ByteArray = new ByteArray ( );
        statement.writeUTFBytes ( "CREATE TABLE " );
        if ( ifNotExists )
            statement.writeUTFBytes ( "IF NOT EXISTS " );
        statement.writeUTFBytes ( table.name );
        statement.writeUTFBytes ( " ( " );
        
        for ( ; i < size; i++ ) {
            field = Column ( fields.get ( keys[i] ) );
            cloumnDefine ( statement, field );
            if ( size - 1 > i )
                statement.writeUTFBytes ( ", " );
        }
        
        statement.writeUTFBytes ( " );" );
        statement.position = 0;
        var statementSQL : String = statement.readUTFBytes ( statement.length );
        
        return statementSQL;
    }
    
    protected function cloumnDefine ( buffer : ByteArray, field : Column ) : void
    {
        buffer.writeUTFBytes ( field.sqlName );
        buffer.writeUTFBytes ( " " );
        buffer.writeUTFBytes ( getDataType ( field.type ) );
        
        if ( field.primary ) {
            buffer.writeUTFBytes ( " " );
            buffer.writeUTFBytes ( "PRIMARY KEY" );
            
            if ( field.autoIncrement )
                buffer.writeUTFBytes ( " AUTOINCREMENT" );
        }
    }
    
    protected function getDataType ( type : Type ) : String
    {
        switch ( type.name ) {
            case "String":
                return "TEXT";
            case "Number":
                return "REAL";
            case "uint":
            case "int":
            default:
                return "INTEGER";
        }
        return null;
    }
}

}