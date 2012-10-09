package me.imcj.as3object.responder {
import me.imcj.as3object.Responder;
import me.imcj.as3object.Result;
import me.imcj.as3object.hook.HookEntry;
import me.imcj.as3object.hook.HookManager;

import mx.rpc.AsyncToken;
import mx.rpc.IResponder;

public class CreateTableResponder implements Responder
{
    private var token : AsyncToken;
    private var hook  : HookManager;
    private var table : Class;
    
    public function CreateTableResponder ( table : Class, token : AsyncToken, hook : HookManager )
    {
        this.token = token;
        this.hook  = hook;
        this.table = table;
    }
    
    public function result ( data : Result ) : void
    {
        hook.execute ( HookEntry.CREATE_TABLE_SUCCESS, { "data" : table } );
        
        var responder : IResponder;
        for each ( responder in token.responders )
            responder.result ( table );
    }
    
    public function fault ( info : Object ) : void
    {
        var responder : IResponder;
        for each ( responder in token.responders )
            responder.fault ( info );
        
        hook.execute ( HookEntry.CREATE_TABLE_FAULT, { "error" : info } );
    }
}

}