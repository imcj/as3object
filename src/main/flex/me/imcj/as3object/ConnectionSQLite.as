package me.imcj.as3object
{
    import flash.data.SQLConnection;
    import flash.data.SQLMode;
    import flash.data.SQLStatement;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    
    import me.imcj.as3object.hook.HookManager;
    
    import mx.rpc.IResponder;
    
    public class ConnectionSQLite extends EventDispatcher implements Connection
    {
        protected var _connection : SQLConnection;
        protected var _config:Config;
        protected var db : File;
        private var hook:HookManager;
        
        public function ConnectionSQLite ( config : Config, hook : HookManager )
        {
            _config = config;
            _connection = new SQLConnection ( );
            this.hook = hook;
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
            wrapper.hook = hook;
            
            return wrapper;
        }
    }
}