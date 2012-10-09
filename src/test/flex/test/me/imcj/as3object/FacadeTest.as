package test.me.imcj.as3object
{
    import me.imcj.as3object.Facade;
    
    import mx.rpc.IResponder;
    
    import org.flexunit.async.Async;
    
    import test.me.imcj.as3object.fixture.Blog;

    public class FacadeTest
    {
        public var facade : Facade;
        
        [Before]
        public function setUp():void
        {
            facade = Facade.instance;
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test(async)]
        public function testCreateTable ( ) : void
        {
            var responder : IResponder = Async.asyncResponder ( this, new CreateTableResponder ( ), 100 );
            facade.createTable ( Blog, true ).addResponder ( responder );
        }
    }
}
import me.imcj.as3object.AS3ObjectResponder;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;

import test.me.imcj.as3object.fixture.Blog;

class CreateTableResponder extends AS3ObjectResponder
{
    public function CreateTableResponder ( ) 
    {
        super ( onResult, onFault );
    }
    
    public function onResult(data:Object):void
    {
        assertEquals ( Class ( data ), Blog );
    }
    
    public function onFault(info:Object):void
    {
        assertFalse ( true );
    }
}