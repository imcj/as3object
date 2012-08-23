package test.me.imcj.as3object.responder
{
import me.imcj.as3object.AS3ObjectResponder;
import me.imcj.as3object.Result;
import me.imcj.as3object.Table;
import me.imcj.as3object.fixture.Cat;
import me.imcj.as3object.responder.ResponderSelect;
import me.imcj.as3object.sqlite.SQLiteTable;

import mx.rpc.IResponder;

import org.as3commons.reflect.Type;

public class ResponderSelectTest
{
    public var select : ResponderSelect;
    
    [Before]
    public function setUp():void
    {
        var table : Table = new SQLiteTable ( Type.forClass ( Cat ) );
        var responder : IResponder = new AS3ObjectResponder (
            function ( result : Object ) : void { },
            function ( fault  : Object ) : void { }
        );
        select = new ResponderSelect ( table, responder );
    }
    
    [After]
    public function tearDown():void
    {
    }
    
    [Test]
    public function testResult ( ) : void
    {
        select.result (
            new Result (
                {
                    "data" : [
                        {
                            "id": 1,
                            "name" : "2B"
                        }
                    ]
                }
            )
        );
    }
}
}