package me.imcj.as3object.responder {
    

import mx.rpc.IResponder;
import me.imcj.as3object.Result;
import me.imcj.as3object.Responder;

public class ErrorResponder implements Responder
{
    protected var responder : IResponder;
    
    public function ErrorResponder ( responder : IResponder )
    {
        this.responder = responder;
    }
    
    public function result ( result : Result ) : void
    {
        throw new Error ( "This method is not implement." );
    }
    
    public function fault(info:Object):void
    {
        if ( null != responder )
            if ( null != responder.fault )
                responder.fault ( info );
    }
}
}