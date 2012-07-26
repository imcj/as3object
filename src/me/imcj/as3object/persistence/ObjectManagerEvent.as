package me.imcj.as3object.persistence
{
    import flash.events.Event;
    
    import me.imcj.as3object.AS3Object;
    
    public class ObjectManagerEvent extends Event
    {
        static public const SAVE : String = "save";
        static public const PERSISTENCE_ADD : String = "persistenceAdd";
        
        private var _object:AS3Object;
        
        public function ObjectManagerEvent(type:String, object : AS3Object, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            _object = object;
            super(type, bubbles, cancelable);
        }

        public function get object():AS3Object
        {
            return _object;
        }

    }
}