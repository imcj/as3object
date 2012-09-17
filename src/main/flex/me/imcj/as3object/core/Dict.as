package me.imcj.as3object.core
{
    import flash.utils.Dictionary;
    
    public class Dict extends Object
    {
        protected var _data : Dictionary = new Dictionary ( true );
        protected var _keys : Array;
        protected var _merge: Array;
        
        protected var _length : int = 0;
        
        public function Dict ( )
        {
            _keys = new Array ( );
            _merge = new Array ( );
        }
        
        public function get keys ( ) : Array
        {
            return _keys;
        }
        
        
        public function get ( key : String ) : Object
        {
            return _data[key];
        }
        
        public function has ( key : String ) : Boolean
        {
            return _data.hasOwnProperty ( key );
        }
        
        public function hasArray ( keys : Array ) : Boolean
        {
            var key : String;
            for each ( key in keys )
                if ( ! _data.hasOwnProperty ( key ) )
                    return false;
                
            return true;
        }
            
        
        public function add ( key : String, value : Object ) : void
        {
            if ( ! has ( key ) )
                _keys[_keys.length] = key;
            
            _data[key]=value;
            _length ++;
        }
        
        public function get length ( ) : int
        {
            return _length;
        }
        
        public function createIterator ( ) : DictIterator
        {
            return new DictIterator ( this );
        }
        
        public function remove ( deleteKey : String ) : void
        {
            var i : int = 0;
            var size : int = _keys.length;
            
            for ( ; i < size; i++ )
                if ( _keys[i] == deleteKey )
                    delete _keys[i];
            
            delete _data[deleteKey];
            _length--;
        }
        
        public function removeAll():void
        {
            var key : String;
            for each ( key in keys )
                remove ( key );
        }
        
        public function clone():Dict
        {
            var dict : Dict = new Dict ( );
            var key : String;
            for each ( key in keys )
                dict.add ( key, get ( key ) );
                
            return dict;
        }
        
        public function merge ( target : Dict ) : Dict
        {
            _merge[_merge.length] = target;
            return this;
        }
        
        public function forEach ( func : Function ) : void
        {
            var iter : DictIterator = createIterator();
            while ( iter.hasNext ) {
                iter.next ( );
                
                func ( iter.value );
            }
            
            var mergeDict : Dict;
            var i : int = 0;
            var size : int = _merge.length;
            if ( _merge.length > 0 ) {
                for ( ; i < size; i++ ) {
                    mergeDict = _merge[i];
                    mergeDict.forEach ( func );
                }
            }
            
            while ( _merge.length > 0 )
                _merge.pop ( );
            
        }
    }
}