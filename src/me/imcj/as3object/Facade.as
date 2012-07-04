package me.imcj.as3object
{
    import avmplus.getQualifiedClassName;
    
    import flash.utils.Dictionary;
    
    import me.imcj.as3object.sqlite.SQLiteTable;

    public class Facade
    {
        static protected var _instance : Facade;
        
        protected var _types : Dictionary;
        protected var metadataProcessor : MetadataProcessor;
        protected var _tableCache : Dict = new Dict ( );
        
        public function Facade ( )
        {
            _types = new Dictionary ( );
            metadataProcessor = new MetadataProcessor ( );
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
//			table.data = object;
            return table;
        }
    }
}