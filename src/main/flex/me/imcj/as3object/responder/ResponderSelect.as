package me.imcj.as3object.responder
{
    
import me.imcj.as3object.AS3ObjectField;
import me.imcj.as3object.Responder;
import me.imcj.as3object.Result;
import me.imcj.as3object.Table;
import me.imcj.as3object.hook.HookManager;
import me.imcj.as3object.hook.HookManagerDefault;

import mx.rpc.IResponder;


public class ResponderSelect implements Responder
{
    
    protected var _responder : IResponder;
    protected var _table : Table;
    protected var _hook  : HookManager;
    
    public function ResponderSelect ( table : Table, responder : IResponder )
    {
        _table = table;
        _responder = responder;
        _hook = HookManagerDefault.create ( );
    }
    
    public function result ( result : Result ) : void
    {
        var objects : Array = new Array ( );
        var object  : Object;
        
        for each ( object in result.data ) {
            objects[objects.length] = create ( object );
        }
        
        _responder.result ( objects );
    }
    
    protected function create ( object : Object ) : Object
    {
        var field : String;
        var instance : Object = new _table.type.clazz ();
        
        _hook.execute ( "rebuild_instance", { "instance" : instance, "table" : _table } );
        trace ( "POAO hook execute:", _table.type.name );
        
        for each ( field in _table.fields.keys )
            AS3ObjectField ( _table.fields.get ( field ) ).setPOAOValue ( instance, object );
        
        return instance;
    }
    
    public function fault ( info : Object ) : void
    {
        if ( null != _responder.fault ) {
            try {
                _responder.fault ( info );
            } catch ( error : Error ) {
                _responder.fault ( null );
            }
        } else
            _responder.result ( null );
    }
}

}