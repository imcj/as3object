package me.imcj.as3object
{
    import flash.events.Event;
    
    public class ConnectionEvent extends Event
    {
        static public const CONNECT : String = "connect";
        
        public function ConnectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
    }
}