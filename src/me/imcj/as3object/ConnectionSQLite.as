package me.imcj.as3object
{
    import flash.data.SQLConnection;
    import flash.data.SQLMode;
    import flash.data.SQLStatement;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    
    import mx.rpc.IResponder;
    
    public class ConnectionSQLite extends EventDispatcher implements Connection
    {
        protected var _connection : SQLConnection;
        protected var _config:Config;
        protected var db : File;
        
        public function ConnectionSQLite ( config : Config )
        {
            _config = config;
            _connection = new SQLConnection ( );
            
            if ( _config.IN_MEMORY )
                db = null;
            else
                db = new File ( _config.DATABASE_NAME );
        }
        
        public function open( ) : void
        {
            
        }
        
        public function openAsync ( responder:IResponder) : void
        {
            var rsp : AS3ObjectResponder = new AS3ObjectResponder (
                function ( data : Object ) : void
                {
                    responder.result ( new ConnectionEvent ( ConnectionEvent.CONNECT ) );
                }
            );
            _connection.openAsync ( db, SQLMode.CREATE, rsp );
        }
        
        public function get connected():Boolean
        {
            return false;
        }
        
        public function createStatement ( text : String = null ) : Statement
        {
            var real : SQLStatement = new SQLStatement ( );
            real.sqlConnection = _connection;
            
            var wrapper : Statement;
            wrapper = new StatementSQLite ( real );
            wrapper.text = text;
            
            return wrapper;
        }
    }
}