package me.imcj.as3object
{
    import flash.data.SQLConnection;
    import flash.data.SQLMode;
    import flash.filesystem.File;

    public class SQLiteRepository extends Repository
    {
        static protected var _connection : SQLConnection;
        static protected var _factory : Factory;
        
        public function SQLiteRepository ( connection : Object )
        {
            if ( null == connection ) {
                _connection = new SQLConnection ( );
                _connection.openAsync ( File.applicationStorageDirectory, SQLMode.CREATE );
                return;
            }
            
            _connection = new SQLConnection ( );
            if ( connection is String )
                _connection.openAsync ( new File ( connection ), SQLMode.CREATE );
            else if ( connection is File )
                _connection.openAsync ( connection, SQLMode.CREATE );
            
            super();
        }
        
        override public function save ( object : Object ) : Object
        {
            _factory.cache.get ( object ).insert ( );
            return object;
        }
        
        protected function convertToSQL(object:Object):void
        {
        }
    }
}