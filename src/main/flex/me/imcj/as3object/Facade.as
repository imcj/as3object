package me.imcj.as3object
{
    import me.imcj.as3object.core.newInstance;
    import me.imcj.as3object.hook.HookManager;
    import me.imcj.as3object.hook.HookManagerDefault;
    
    import mx.rpc.IResponder;
    import mx.utils.UIDUtil;

    public class Facade
    {
        static protected var _instance : Facade;
        
        protected var _config : Config;
        protected var pool : ConnectionPool;
        protected var hook : HookManager;
        protected var tableFactory : TableFactory;
        
        public var cache : TableCache;
        public var connection : Connection;
        
        public function Facade ( config : Config )
        {
            _config = config;
            pool = new ConnectionPoolImpl ( config, new ConnectionFactoryImpl ( ) );
            
            
            hook = HookManagerDefault.create ( );
            
            tableFactory = new TableFactory ( config, hook );
            
            cache = new TableCache ( );
            cache.factory = tableFactory;
        }
        
        public function create ( type : Class, attributes : Object = null ) : Object
        {
            var table : Table = cache.getWithType ( type );
            
            var instance : Object = newInstance ( type, attributes ) ;
            if ( instance.hasOwnProperty ( "uid" ) )
                instance['uid'] = UIDUtil.createUID ( );
            
            hook.execute ( "create_instance", { "table" : table, "instance" : instance } );
            return instance;
        }
        
        public function useDefaultConfig ( ) : void
        {
            _config = Config.createInMemory ( );
        }
        
        public function createCriteria ( type : Class, responder : IResponder ) : void
        {
            pool.getConnection (
                new AS3ObjectResponder (
                    function ( connection : Connection ) : void
                    {
                        responder.result ( new CriteriaImplement ( cache.getWithObject ( type ), connection ) );
                    }
                )
            );
        }
        
        public function createRepository ( responder : IResponder ) : void
        {
            pool.getConnection (
                new AS3ObjectResponder (
                    function ( connection : Connection ) : void
                    {
                        responder.result ( new Repository ( connection, cache ) );
                    }
                )
            );
        }
        
        static public function get instance ( ) : Facade
        {
            if ( ! _instance )
                _instance = new Facade ( Config.createInMemory ( ) );
            
            return _instance;
        }

        public function get config ( ) : Config
        {
            return _config;
        }

        public function set config ( value : Config ) : void
        {
            _config = value;
            pool.config = value;
            tableFactory.config = value;
        }

    }
}