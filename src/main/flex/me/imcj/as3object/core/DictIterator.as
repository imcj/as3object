package me.imcj.as3object.core
{
    public class DictIterator implements Iterator
    {
        private var dict:Dict;
        private var keys:Array;
        private var i:int;
        
        protected var _value : KeyValue;
        
        public function DictIterator ( dict : Dict )
        {
            this.dict = dict;
            this.keys = new Array ( );
            for each ( var key : String in dict.keys )
                keys[keys.length] = key;
            i = 0;
        }
        
        public function get hasNext():Boolean
        {
            if ( i < keys.length )
                return true;
            return false;
        }
        
        public function get value ( ) : KeyValue
        {
            return _value;
        }
        
        public function next():Object
        {
            if ( ! hasNext )
                return null;
            
            var obj : Object = dict.get(keys[i]);
            
            _value = new KeyValue ( keys[i], obj );
            i += 1;
            return obj;
        }
        
        public function remove():Object
        {
            var length : int = keys.length - 1;
            var object : Object = dict [ keys [ length ] ];
            delete keys [ length ];
            return object;
        }
    }
}