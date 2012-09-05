package me.imcj.as3object.core
{
    public class KeyValue extends Key
    {
        public var value : Object;
        
        public function KeyValue ( key : String = null, value : Object = null )
        {
            this.value = value;
            
            super ( key );
        }
    }
}