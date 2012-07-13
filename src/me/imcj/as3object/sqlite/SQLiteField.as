package me.imcj.as3object.sqlite
{
    import flash.utils.ByteArray;
    
    import me.imcj.as3object.AS3ObjectField;
    import me.imcj.as3object.sqlite.field.TextField;
    
    public class SQLiteField extends AS3ObjectField
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
        override public function buildCreateTableColumnDefine ( buffer : ByteArray ) : void
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
        
        // TODO 清理TODO 完成这些部分
        override public function buildInsertColumn ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
        
        override public function buildInsertValue ( buffer : ByteArray ) : void
        {
        }
        
        override public function buildUpdateAssign ( buffer : ByteArray ) : void
        {
            throw new Error ( "Not implement the method." );
        }
    }
}