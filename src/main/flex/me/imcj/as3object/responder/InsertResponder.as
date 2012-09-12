package me.imcj.as3object.responder {
import flash.events.EventDispatcher;

import me.imcj.as3object.Responder;
import me.imcj.as3object.Result;
import me.imcj.as3object.hook.HookEntry;
import me.imcj.as3object.hook.HookManager;

import mx.rpc.IResponder;

public class InsertResponder extends ErrorResponder
{
    protected var _object : Object;
    protected var hook  :HookManager;
    
    public function InsertResponder ( object : Object, responder : IResponder, hook : HookManager )
    {
        _object = object;
        this.hook = hook;
        
        super ( responder );
    }
    
    override public function result ( data : Result ) : void
    {
        if ( _object.hasOwnProperty ( "id" ) && data.lastInsertRowID )
            _object["id"] = data.lastInsertRowID;
        
        responder.result ( _object );
        
//        if ( _object is EventDispatcher )
//            hook.execute ( HookEntry
    }
}
}