package me.imcj.as3object.sqlite
{
    import flash.utils.ByteArray;
    
    import me.imcj.as3object.AS3ObjectField;
    import me.imcj.as3object.SQLField;
    import me.imcj.as3object.sqlite.field.TextField;
    
    public class SQLiteField extends AS3ObjectField implements SQLField
    {
        public function SQLiteField(name:String)
        {
            super(name);
        }
        
        /**
         * 构造CREATE TABLE 的字段定义部分
         * 
         * @example 
         * <listing version="3.0">
         * var buffer : ByteArray = new ByteArray ( );
         * buffer.writeUTFString ( "CREATE TABLE pet ( " );
         * 
         * var field : IntegerField = new IntegerField ( "id" );
         * field.primaryKey = true;
         * field.autoIncrement = true;
         * field.order = Order.ASC;
         * field.buildCreateTableColumnDefine ( buffer );
         * // CREATE TABLE pet ( id INTEGER PRIMARY KEY ASC AUTOINCREMENT )
         * </listing>
         */
        public function buildCreateTableColumnDefine ( buffer : ByteArray ) : void
        {
            buffer.writeUTFBytes ( name );
            buffer.writeUTFBytes ( " " );
            buffer.writeUTFBytes ( type );
            
            if ( primaryKey ) {
                buffer.writeUTFBytes ( " " );
                buffer.writeUTFBytes ( "PRIMARY KEY" );
                buffer.writeUTFBytes ( " " );
                buffer.writeUTFBytes ( order );
                
                if ( autoIncrement )
                    buffer.writeUTFBytes ( " AUTOINCREMENT" );
            }
        }
        
        public function buildInsertColumn ( buffer : ByteArray ) : void
        {
            buffer.writeUTFBytes ( name );
        }
        
        public function buildInsertValue ( buffer : ByteArray, object : Object ) : void
        {
            if ( primaryKey && autoIncrement )
                buffer.writeUTFBytes ( "NULL" );
            else
                buffer.writeUTFBytes ( String ( getPOAOValue ( object ) ) );
        }
        
        public function buildUpdateAssign ( buffer : ByteArray, object : Object ) : void
        {
            throw new Error ( "Not implement the method." );
        }
    }
}