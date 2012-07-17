package me.imcj.as3object
{
    import avmplus.getQualifiedClassName;
    
    import flash.filesystem.File;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;
    
    import me.imcj.as3object.sqlite.SQLiteTable;

    public class Facade
    {
        static protected var _instance : Facade;
        
        public var config : Config;
        
        protected var _types : Dictionary;
        protected var _tableCache : Dict = new Dict ( );
        protected var _asyncRepositories : Dict = new Dict ( );
        
        protected var pool : ConnectionPool;
        
        public function Facade ( )
        {
            _types = new Dictionary ( );
            pool = new ConnectionPoolImpl ( config, new ConnectionFactoryImpl ( ) );
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
        
        public function createCriteria ( type : Class ) : Criteria
        {
            var criteria : Criteria = new CriteriaImplement ( type, pool );
            return criteria;
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
            // TODO 通过配置实例化对象
            var asyncRepository : AsyncRepository = AsyncRepository ( _asyncRepositories.get ( flash.utils.getQualifiedClassName ( type ) ) );
            if ( ! asyncRepository ) {
                asyncRepository = new SQLiteAsyncRepository ( File.applicationStorageDirectory.resolvePath ( "db.sqlite3" ), type );
                _asyncRepositories.add ( flash.utils.getQualifiedClassName ( type ), asyncRepository );
            }
            return asyncRepository;
        }
    }
}