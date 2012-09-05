package me.imcj.as3object.responder {
import me.imcj.as3object.Responder;
import me.imcj.as3object.Result;

import mx.rpc.IResponder;

public class CreateTableResponder extends ErrorResponder implements Responder
{
    protected var _responder : IResponder;
    
    public function CreateTableResponder ( responder : IResponder )
    {
        super ( responder );
    }
    
    override public function result ( data : Result ) : void
    {
        if ( responder )
            responder.result ( "success" );
    }
}

}