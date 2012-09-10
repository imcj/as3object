package me.imcj.as3object.hook.impl
{
    
import flash.utils.Dictionary;

import me.imcj.as3object.Config;
import me.imcj.as3object.Connection;
import me.imcj.as3object.Facade;
import me.imcj.as3object.TableCache;
import me.imcj.as3object.TableFactory;
import me.imcj.as3object.hook.Hook;
import me.imcj.as3object.hook.HookManager;

import test.me.imcj.as3object.hook.HookAction;

public class HookManagerImpl implements HookManager
{
    protected var hooks : Dictionary;
    
    protected var _tableFactory : TableFactory;
    protected var _tableCache   : TableCache;
    protected var _config       : Config;
    
    public function HookManagerImpl ( )
    {
        hooks = new Dictionary ( );
    }
    
    static public function create ( config : Config, tableFactory : TableFactory, tableCache : TableCache ) : HookManager
    {
        var hook : HookManager = new HookManagerImpl ( );
        hook.config = config;
        hook.tableFactory = tableFactory;
        hook.tableCache = tableCache;
        
        new InstallDefaultHooks ( hook );
        
        return hook;
    }
    
    public function execute ( name : String, data : Object ) : void
    {
        var h : Array;
        var i : int = 0;
        var size : int;
        if ( ! hooks.hasOwnProperty ( name ) )
            return;
        h = hooks [ name ];
        size = h.length;
        data [ "$name" ] = name;
        for ( ; i < size; i++ ) {
            var hookAction : HookAction = Hook ( h[i] ).execute ( data );
            if ( hookAction.interrupting )
                break;
        }
    }
    
    public function add ( name : String, hook : Hook ) : void
    {
        var h : Array = new Array ( );
        if ( hooks.hasOwnProperty ( name ) )
            h = hooks [ name ];
        else
            hooks [ name ] = h = new Array ( );
        
        h[h.length] = hook;
        h.sort ( sortOnPriority );
    }
    
    protected function sortOnPriority ( a : Hook, b : Hook ) : Number
    {
        var aPriority : int = a.priority;
        var bPriority : int = b.priority;
        
        if ( aPriority > bPriority )
            return 1;
        else if ( aPriority < bPriority )
            return -1;
        else
            return 0;
    }

    public function get tableFactory():TableFactory
    {
        return _tableFactory;
    }

    public function set tableFactory(value:TableFactory):void
    {
        _tableFactory = value;
    }

    public function get tableCache():TableCache
    {
        return _tableCache;
    }

    public function set tableCache(value:TableCache):void
    {
        _tableCache = value;
    }

    public function get config():Config
    {
        return _config;
    }

    public function set config(value:Config):void
    {
        _config = value;
    }


}

}