package me.imcj.as3object.responder {
import me.imcj.as3object.Responder;
import me.imcj.as3object.Result;

import mx.rpc.IResponder;

public class InsertResponder extends ErrorResponder
{
    protected var _object : Object;
    
    public function InsertResponder ( object : Object, responder : IResponder )
    {
        _object = object;
        
        super ( responder );
    }
    
    override public function result ( data : Result ) : void
    {
        if ( _object.hasOwnProperty ( "id" ) && data.lastInsertRowID )
            _object["id"] = data.lastInsertRowID;
        
        responder.result ( _object );
    }
}
}