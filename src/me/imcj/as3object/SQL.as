package me.imcj.as3object
{
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;

    public class SQL extends Object
    {
        static protected var factory : Factory;
        
        public function SQL ( table : Table )
        {
            super ( );
        }
        
        static public function insert ( object : Object ) : void
        {
//            var name : String = getDefinitionByName ( object );
//            var accessor : Object;
//            var key : String;
//            var table : Table = factory.cache.get ( name );
//            var sql : ByteArray = new ByteArray ( );
//            sql.writeUTFBytes ( "INSERT INTO " );
//            sql.writeUTFBytes ( table.tableName );
//            sql.writeUTFBytes ( " ( " );
//            
//            table.sql.insert ( object );
        }
        
        override public function toString ( ) : String
        {
            
        }
    }
}