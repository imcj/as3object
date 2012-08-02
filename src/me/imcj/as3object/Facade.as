package me.imcj.as3object
{
    import avmplus.getQualifiedClassName;
    
    import flash.filesystem.File;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.core.Dict;
    import me.imcj.as3object.core.newInstance;
    import me.imcj.as3object.hook.HookManager;
    import me.imcj.as3object.hook.HookManagerDefault;
    import me.imcj.as3object.hook.InstallDefaultHooks;
    import me.imcj.as3object.sqlite.SQLiteTable;
    
    import mx.rpc.IResponder;
    import mx.utils.UIDUtil;
    
    import org.as3commons.reflect.Type;

    public class Facade
    {
        static protected var _instance : Facade;
        
        protected var _config : Config;
        
        protected var _types : Dictionary;
        protected var _tableCache : Dict = new Dict ( );
        protected var _asyncRepositories : Dict = new Dict ( );
        protected var pool : ConnectionPool;
        
        protected var _hook        : HookManager;
        protected var tableFactory : TableFactory;
        
        public function Facade ( )
        {
            _types = new Dictionary ( );
            _config = Config.createInMemory ( );
            pool = new ConnectionPoolImpl ( _config, new ConnectionFactoryImpl ( ) );
            
            _hook = HookManagerDefault.create ( );
            tableFactory = new TableFactory ( _config, _hook );
        }
        
        public function create ( type : Class, attributes : Object = null ) : Object
        {
            var table : Table = getTable ( type );
            
            var instance : Object = newInstance ( type, attributes ) ;
            if ( instance.hasOwnProperty ( "uid" ) )
                instance['uid'] = UIDUtil.createUID ( );
            
            _hook.execute ( "create_instance", { "table" : table, "instance" : instance } );
            return instance;
        }
        
        public function useDefaultConfig ( ) : void
        {
            _config = Config.createInMemory ( );
        }
        
        public function forClass ( type : Class ) : *
        {
            var name : String = getQualifiedClassName ( type );
            if ( ! _types.hasOwnProperty ( name ) )
                getTable ( type );
            
            return forName ( name );
        }
        
        public function forName ( name : String ) : *
        {
            return new ( _types [ name ] );
        }
        
        public function createCriteria ( type : Class, responder : IResponder ) : void
        {
            pool.getConnection (
                new AS3ObjectResponder (
                    function ( connection : Connection ) : void
                    {
                        responder.result ( new CriteriaImplement ( getTable ( type ), connection ) );
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
                        trace ( "Facade create repository." );
                        responder.result ( new Repository ( connection ) );
                    }
                )
            );
        }
        
        static public function get instance ( ) : Facade
        {
            if ( ! _instance )
                _instance = new Facade ( );
            
            return _instance;
        }
        
        public function getTable ( object : Object ) : Table
        {
            var qname : String = getQualifiedClassName ( object );
            var table : Table;
            if ( _tableCache.has ( qname ) )
                table = Table ( _tableCache.get ( qname ) );
            else {
                
                table = tableFactory.create ( object );
                _tableCache.add ( qname, table );
            }
            return table;
        }
        
        public function getRepository ( type : Class ) : AsyncRepository
        {
            var asyncRepository : AsyncRepository = AsyncRepository ( _asyncRepositories.get ( flash.utils.getQualifiedClassName ( type ) ) );
            if ( ! asyncRepository ) {
                asyncRepository = new SQLiteAsyncRepository ( File.applicationStorageDirectory.resolvePath ( "db.sqlite3" ), type );
                _asyncRepositories.add ( flash.utils.getQualifiedClassName ( type ), asyncRepository );
            }
            return asyncRepository;
        }

        public function get config():Config
        {
            return _config;
        }

        public function set config(value:Config):void
        {
            _config = value;
            pool.config = value;
            tableFactory.config = value;
        }

    }
}