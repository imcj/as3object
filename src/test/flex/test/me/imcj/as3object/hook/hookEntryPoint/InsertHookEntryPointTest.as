package test.me.imcj.as3object.hook.hookEntryPoint
{
    import me.imcj.as3object.Facade;
    
    import test.me.imcj.as3object.fixture.Cat;

    public class InsertHookEntryPointTest
    {		
        public var facade : Facade
        
        [Before(async)]
        public function setUp():void
        {
            facade = Facade.instance;
            facade.createTable ( Cat, new InsertHookEntryPointResponder ( this ) , true );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testExecute ( ) : void
        {
            var cat : Cat = new Cat ( );
            cat.name = "2B";
            cat.setAge ( 2 );
            
//            facade.save ( cat,  );
        }
    }
}
import flash.events.Event;
import flash.events.EventDispatcher;

import me.imcj.as3object.AS3ObjectResponder;

import org.flexunit.async.Async;

import test.me.imcj.as3object.hook.hookEntryPoint.InsertHookEntryPointTest;

class InsertHookEntryPointResponder extends AS3ObjectResponder
{
    private var testCase:InsertHookEntryPointTest;
    public var dispatcher : EventDispatcher = new EventDispatcher ( );
    
    public function InsertHookEntryPointResponder ( testCase : InsertHookEntryPointTest )
    {
        this.testCase = testCase;
        
        super ( onResult );
    }
    
    public function onResult(data:Object):void
    {
        Async.proceedOnEvent ( testCase, dispatcher, Event.COMPLETE );
        dispatcher.dispatchEvent ( new Event ( Event.COMPLETE ) );
    }
    
    public function onFault ( info : Object ) : void
    {
        
    }
}