package me.imcj.as3object
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import mx.rpc.IResponder;
    
    /**
    * 没弄，简单返回连接
    */
    public class ConnectionPoolImpl extends EventDispatcher implements ConnectionPool
    {
        protected var _config : Config;
        protected var _connectionFactory : ConnectionFactory;
        
        static protected var connection : Connection;
        
        public function ConnectionPoolImpl ( config : Config, connectionFactory : ConnectionFactory )
        {
            _config = config;
            _connectionFactory = connectionFactory;
        }
        
        public function getConnection ( responder : IResponder ) : void
        {
            if ( connection )
                responder.result ( connection );
            
            connection = _connectionFactory.create ( _config );
            connection.openAsync (
                new AS3ObjectResponder (
                    function ( event : ConnectionEvent ) : void
                    {
                        responder.result ( connection );
                    }
                )
            );
        }

        public function get config():Config
        {
            return _config;
        }

        public function set config(value:Config):void
        {
            _config = value;
        }

    }
}