package me.imcj.as3object
{
    import flash.utils.Dictionary;
    
    import me.imcj.as3object.field.Field;
    
    public class Dict extends Object
    {
        protected var _data : Object = new Object ( );
        
        public function Dict ( )
        {
        }
        
        public function get keys ( ) : Array
        {
            var key : String;
            var keys : Array = new Array ( );
            for each ( key in _data )
                keys.push ( key );
                
            return keys;
        }
        
        public function get ( key : String ) : Object
        {
            return _data[key];
        }
            
        
        public function add ( key : String, value : Object ) : void
        {
            _data[key]=value;
        }
    }
}