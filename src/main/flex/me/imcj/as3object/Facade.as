package me.imcj.as3object {
import flash.events.EventDispatcher;

import me.imcj.as3object.core.newInstance;
import me.imcj.as3object.expression.Expression;
import me.imcj.as3object.hook.Hook;
import me.imcj.as3object.hook.HookEntry;
import me.imcj.as3object.hook.HookManager;
import me.imcj.as3object.hook.impl.HookManagerImpl;
import me.imcj.as3object.responder.CreateTableResponder;
import me.imcj.as3object.responder.InsertResponder;

import mx.rpc.AsyncToken;
import mx.rpc.IResponder;
import mx.utils.UIDUtil;

public class Facade extends EventDispatcher
{
    static protected var _instance : Facade;
    
    protected var _config : Config;
    protected var pool : ConnectionPool;
    protected var hook : HookManager;
    protected var tableFactory : TableFactory;
    
    public var cache : TableCache;
    public var connection : Connection;
    
    public function Facade ( config : Config )
    {
        _config = config;
        cache = new TableCache ( );
        tableFactory = new TableFactory ( config, cache );
        hook = HookManagerImpl.create ( config, tableFactory, cache );
        tableFactory.hook = hook;
        pool = new ConnectionPoolImpl ( config, new ConnectionFactoryImpl ( hook ) );
		
    }
	
	
    public function open ( ) : void
    {
        pool.getConnection ( new ConnectionResponder ( this ) );
    }
    
    public function addHook ( hookName : String, hook : Hook ) : Hook
    {
        this.hook.add ( hookName, hook );
        hook.hookManager = this.hook;
        return hook;
    }
    
    public function addTable ( table : Table ) : void
    {
        cache.add ( table.name, table );
    }
    
    public function getTable ( name : String ) : Table
    {
        return cache.getWithName ( name );
    }
    
    public function create ( type : Class, attributes : Object = null ) : Object
    {
        var table : Table = cache.getWithType ( type );
        
        var instance : Object = newInstance ( type, attributes ) ;
        if ( instance.hasOwnProperty ( "uid" ) )
            instance['uid'] = UIDUtil.createUID ( );
        
        hook.execute ( HookEntry.CREATE_INSTANCE, { "table" : table, "instance" : instance } );
        return instance;
    }
    
    public function useDefaultConfig ( ) : void
    {
        _config = Config.createInMemory ( );
    }
    
    public function createCriteria ( type : Class, responder : IResponder ) : void
    {
        pool.getConnection (
            new AS3ObjectResponder (
                function ( connection : Connection ) : void
                {
                    responder.result ( new CriteriaImpl ( cache.getWithType ( type ), connection, hook ) );
                }
            )
        );
    }
    
    public function createCriteriaSync ( type : Class ) : Criteria
    {
        return new CriteriaImpl ( cache.getWithType ( type ), connection, hook );
    }
    
    public function add ( object : Object, addNew : Boolean = true ) : AsyncToken
    {
        var table : Table = cache.getWithObject ( object );
        // Save all object
//        var missSavedForeign : int = 0;
//        table.eachForeign ( function ( column : Column ) : void
//        {
//            var foreign : int = column.getValue ( object );
//            if ( foreign == 0 )
//                missSavedForeign += 1
//        } );
//        
//        if ( missSavedForeign > 1 )
//            return;
        
        hook.execute ( HookEntry.ADD, { "data" : object } );
        var token : AsyncToken = new AsyncToken ( null );
        var text : String = table.dml.insert ( object );
        pool.getConnection ( new AS3ObjectResponder (
            function ( connection : Connection ) : void
            {
                var statement : Statement = connection.createStatement ( text );
                statement.execute ( new InsertResponder ( object, token, hook ) );
            }
        ) );
        
        return token;
    }
    
    public function save ( object : Object, addNew : Boolean = true ) : AsyncToken
    {
        return add ( object, addNew );
    }
    
    public function update ( data : Object, object : Object, responder : IResponder ) : void
    {
        var token : AsyncToken = new AsyncToken ( null );
        var table : Table = cache.getWithObject ( object );
        var expression : Expression;
        var primary : String = table.primaryKey.name;
        
        if ( primary )
            expression = Expression.eq ( primary, table.primaryKey.getSqlValue ( object ) );
        
        var text : String = table.dml.update ( data, expression );
        pool.getConnection ( new AS3ObjectResponder (
            function ( connection : Connection ) : void
            {
                var statement : Statement = connection.createStatement ( text );
                statement.execute ( new InsertResponder ( object, token, hook ) );
            }
        ) );
    }
    
    public function remove(object:Object):void
    {
    }
    
    public function createTable ( type : Class, responder:IResponder, ifNotExists:Boolean=false):void
    {
        var text : String = cache.getWithType ( type ).ddl.createTable ( ifNotExists );
        
        pool.getConnection ( new AS3ObjectResponder (
            function ( connection : Connection ) : void
            {
                var statement : Statement = connection.createStatement ( text );
                statement.execute ( new CreateTableResponder ( responder ) );
            }
        ) );
    }
    
    static public function get instance ( ) : Facade
    {
        if ( ! _instance )
            _instance = new Facade ( Config.createInMemory ( ) );
        
        return _instance;
    }

    public function get config ( ) : Config
    {
        return _config;
    }

    public function set config ( value : Config ) : void
    {
        _config = value;
        pool.config = value;
        tableFactory.config = value;
    }
}
}
import me.imcj.as3object.AS3ObjectResponder;
import me.imcj.as3object.Connection;
import me.imcj.as3object.ConnectionEvent;
import me.imcj.as3object.Facade;

class ConnectionResponder extends AS3ObjectResponder
{
    private var facade:Facade;
    
    public function ConnectionResponder ( facade : Facade )
    {
        this.facade = facade;
        
        super ( success, fault2 );
    }
    
    public function success ( connection : Connection ) : void
    {
        facade.connection = connection;
        facade.dispatchEvent ( new ConnectionEvent ( ConnectionEvent.OPEN ) );
    }
    
    public function fault2 ( info : Object ) : void
    {
        throw new Error ( info.message );
    }
}