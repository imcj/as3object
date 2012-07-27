package me.imcj.as3object.core
{
    
    
    public class Dict extends Object
    {
        protected var _data : Object = new Object ( );
        protected var _keys : Array;
        
        public function Dict ( )
        {
        }
        
        public function get keys ( ) : Array
        {
            if ( _keys )
                return _keys;
            
            var key : String;
            var keys : Array = new Array ( );
            for ( key in _data )
                keys.push ( key );
            
            _keys = keys;
            return keys;
        }
        
        public function get ( key : String ) : Object
        {
            return _data[key];
        }
        
        public function has ( key : String ) : Boolean
        {
            return _data.hasOwnProperty ( key );
        }
            
        
        public function add ( key : String, value : Object ) : void
        {
            _keys = null;
            _data[key]=value;
        }
        
        public function get length ( ) : int
        {
            var size : int = 0;
            var key : String;
            for ( key in _data )
                size += 1;
            
            return size;
        }
    }
}