package me.imcj.as3object
{
    import avmplus.getQualifiedClassName;
    
    import flash.filesystem.File;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.sqlite.SQLiteTable;
    
    import mx.rpc.IResponder;

    public class Facade
    {
        static protected var _instance : Facade;
        
        protected var _config : Config;
        
        protected var _types : Dictionary;
        protected var _tableCache : Dict = new Dict ( );
        protected var _asyncRepositories : Dict = new Dict ( );
        
        protected var pool : ConnectionPool;
        
        public function Facade ( )
        {
            _types = new Dictionary ( );
            pool = new ConnectionPoolImpl ( Config.createInMemory ( ), new ConnectionFactoryImpl ( ) );
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
                        responder.result ( new CriteriaImplement ( getTable ( type ), pool ) );
                    }
                )
            );
        }
        
        public function createRepository ( type : Class, responder : IResponder ) : void
        {
            return new Repository ( getTable ( type ), pool );
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
            var table : SQLiteTable;
            if ( _tableCache.has ( qname ) )
                table = SQLiteTable ( _tableCache.get ( qname ) );
            else {
                table = new SQLiteTable ( object  );
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
        }

    }
}