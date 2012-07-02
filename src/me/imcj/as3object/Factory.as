package me.imcj.as3object
{
    import avmplus.getQualifiedClassName;
    
    import flash.utils.Dictionary;
    import flash.utils.describeType;

    public class Factory
    {
        static protected var _instance : Factory;
        
        protected var _types : Dictionary;
        
        protected var metadataProcessor : MetadataProcessor;
        
        protected var _tableCache : TableCache;
        
        public function Factory ( )
        {
            _types = new Dictionary ( );
            metadataProcessor = new MetadataProcessor ( );
        }
        
        public function forClass ( type : Class ) : *
        {
            var name : String = getQualifiedClassName ( type );
            if ( ! _types.hasOwnProperty ( name ) )
                register ( type );
            
            return forName ( name );
        }
        
        public function forName ( name : String ) : *
        {
            return new ( _types [ name ] );
        }
        
        public function register ( type : Class ) : void
        {
            _types [ getQualifiedClassName ( type ) ] = type;
            
            metadataProcessor.process ( type );
        }
        
        static public function get instance ( ) : Factory
        {
            if ( ! _instance )
                _instance = new Factory ( );
            
            return _instance;
        }
    }
}