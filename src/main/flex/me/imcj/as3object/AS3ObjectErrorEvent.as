package me.imcj.as3object {
import flash.events.Event;

public class AS3ObjectErrorEvent extends Event
{
    static public const OBJECT_ERROR : String = "objectError";
    public var msg:String;
    
    public function AS3ObjectErrorEvent ( msg : String, bubbles : Boolean = false, cancelable : Boolean = false )
    {
        this.msg = msg;
        super ( OBJECT_ERROR, bubbles, cancelable );
    }
}

}