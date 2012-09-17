package me.imcj.as3object.responder {

import me.imcj.as3object.AS3ObjectResponder;
import me.imcj.as3object.Responder;
import me.imcj.as3object.Result;
import me.imcj.as3object.hook.HookEntry;
import me.imcj.as3object.hook.HookManager;

import mx.rpc.AsyncToken;
import mx.rpc.IResponder;

public class InsertResponder implements Responder
{
    protected var object : Object;
    protected var hook   : HookManager;
    protected var token  : AsyncToken;
    
    public function InsertResponder ( object : Object, token : AsyncToken, hook : HookManager )
    {
        this.token  = token;
        this.object = object;
        this.hook   = hook;
        
    }
    
    public function result ( data : Result ) : void
    {
        if ( object.hasOwnProperty ( "id" ) && data.lastInsertRowID )
            object["id"] = data.lastInsertRowID;
        
        hook.execute ( HookEntry.ADD_SUCCESS, { "data" : object } );
        
        var responder : IResponder;
        for each ( responder in token.responders )
            responder.result ( object );
    }
    
    public function fault ( info : Object ) : void
    {
        var responder : IResponder;
        for each ( responder in token.responders )
            responder.fault ( info );
            
        hook.execute ( HookEntry.ADD_FAULT, { "error" : info } );
    }
}

}