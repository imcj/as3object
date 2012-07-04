package me.imcj.as3object.core
{
    public class ArrayIterator implements Iterator
    {
        protected var _array : Array;
        protected var _index : int = 0;
        
        public function ArrayIterator ( array : Array )
        {
            _array = array;
        }
        
        public function get hasNext():Boolean
        {
            if ( _index < _array.length - 1)
                return true;
            
            return false;
        }
        
        public function get next():Object
        {
            if ( ! hasNext )
                return null;
            
            _index += 1;
            return _array [ _index ];
        }
        
        public function remove():Object
        {
            var length : int = _array.length - 1;
            var object : Object = _array [ length ];
            delete _array [ length ];
            return object;
        }
    }
}