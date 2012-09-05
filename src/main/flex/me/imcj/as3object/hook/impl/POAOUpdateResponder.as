package me.imcj.as3object.hook.impl {
    
import flash.events.Event;
import flash.events.EventDispatcher;

import me.imcj.as3object.AS3Object;
import me.imcj.as3object.AS3ObjectError;
import me.imcj.as3object.AS3ObjectErrorEvent;
import me.imcj.as3object.AS3ObjectResponder;

public class POAOUpdateResponder extends AS3ObjectResponder
{
    public var object : EventDispatcher;
    
    public function POAOUpdateResponder ( object : Object )
    {
        if ( object is EventDispatcher )
            this.object = object as EventDispatcher;
        
        super ( result, fault );
    }
    
    override public function result ( data : Object ) : void
    {
        object.dispatchEvent ( new Event ( AS3Object.UPDATE_SUCCESS ) );
    }
    
    override public function fault ( info : Object ) : void
    {
        object.dispatchEvent ( new AS3ObjectErrorEvent ( AS3ObjectError ( info ).message ) );
    }
}

}