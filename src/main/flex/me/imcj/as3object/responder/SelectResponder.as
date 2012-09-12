package me.imcj.as3object.responder {
    
import me.imcj.as3object.Result;
import me.imcj.as3object.Table;
import me.imcj.as3object.hook.HookEntry;
import me.imcj.as3object.hook.HookManager;

import mx.rpc.IResponder;


public class SelectResponder extends ErrorResponder
{
    protected var table : Table;
    protected var hook  : HookManager;
    
    public function SelectResponder ( table : Table, responder : IResponder, hook : HookManager )
    {
        this.table = table;
        this.hook = hook;
        
        super ( responder );
    }
    
    override public function result ( result : Result ) : void
    {
        var objects  : Array = new Array ( );
        var object   : Object;
        var instance : Object;
        
        for each ( object in result.data ) {
            objects[objects.length] = instance = table.createInstance ( object );
            hook.execute ( HookEntry.REBUILD_INSTANCE, { "instance" : instance, "table" : table } );
        }
        
        responder.result ( objects );
    }
    
}

}