package me.imcj.as3object.core
{
    public class DictIterator implements Iterator
    {
        private var dict:Dict;
        private var keys:Array;
        private var i:int;
        
        public function DictIterator ( dict : Dict )
        {
            this.dict = dict;
            this.keys = dict.keys;
            i = 0;
        }
        
        public function get hasNext():Boolean
        {
            if ( i < keys.length )
                return true;
            return false;
        }
        
        public function next():Object
        {
            if ( ! hasNext )
                return null;
            
            var obj : Object = dict.get(keys[i]);
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