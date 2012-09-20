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
        var statement : ByteArray = new ByteArray ( );
        statement.writeUTFBytes ( "CREATE TABLE " );
        if ( ifNotExists )
            statement.writeUTFBytes ( "IF NOT EXISTS " );
        statement.writeUTFBytes ( table.name );
        statement.writeUTFBytes ( " ( " );
        
        table.eachAllColumn ( function ( column : Column ) : void {
            cloumnDefine ( statement, column );
            statement.writeUTFBytes ( ", " );
        } );
        
        statement.position -= 2;
        
        statement.writeUTFBytes ( " );" );
        statement.position = 0;
        var statementSQL : String = statement.readUTFBytes ( statement.length );
        
        return statementSQL;
    }
    
    protected function cloumnDefine ( buffer : ByteArray, column : Column ) : void
    {
        buffer.writeUTFBytes ( column.sqlName );
        buffer.writeUTFBytes ( " " );
        buffer.writeUTFBytes ( column.sqlType );
        
        if ( column.primary ) {
            buffer.writeUTFBytes ( " " );
            buffer.writeUTFBytes ( "PRIMARY KEY" );
            
            if ( column.autoIncrement )
                buffer.writeUTFBytes ( " AUTOINCREMENT" );
        }
    }
}

}