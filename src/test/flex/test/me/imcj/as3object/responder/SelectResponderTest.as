package test.me.imcj.as3object.responder
{
import me.imcj.as3object.AS3ObjectResponder;
import me.imcj.as3object.Config;
import me.imcj.as3object.Result;
import me.imcj.as3object.Table;
import me.imcj.as3object.TableFactory;
import me.imcj.as3object.hook.HookManager;
import me.imcj.as3object.hook.impl.HookManagerImpl;
import me.imcj.as3object.responder.SelectResponder;

import mx.rpc.IResponder;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertTrue;
import org.flexunit.async.Async;

import test.me.imcj.as3object.fixture.Cat;

public class SelectResponderTest
{
    public var table : Table;
    public var hookManager : HookManager;
    
    [Before]
    public function setUp():void
    {
        var tableFactory : TableFactory = TableFactory.createFactory ( );
        table = TableFactory.createFactory().create(Cat);
        hookManager = HookManagerImpl.create (
            Config.createInMemory ( ),
            tableFactory,
            tableFactory.tableCache
        )
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test(async)]
    public function testResult ( ) : void
    {
        var responder : IResponder = Async.asyncResponder (
            this,
            new AS3ObjectResponder (
                function ( result : Object ) : void
                {
                    assertTrue ( result is Array );
                    assertTrue ( ( result as Array ).length > 0 );
                    var cat : Cat = Cat ( result[0] );
                    assertEquals ( "2B", cat.name );
                },
                function ( fault  : Object ) : void
                {
                    
                }
            ),
            10
        );
        var select : SelectResponder = new SelectResponder (
            table,
            responder,
            hookManager
        );
        
        select.result (
            new Result (
                [
                    {
                        "id": 1,
                        "name" : "2B"
                    }
                ]
            )
        );
    }
}
}