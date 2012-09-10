package test.me.imcj.as3object.hook
{
    
    import me.imcj.as3object.hook.Hook;
    import me.imcj.as3object.hook.HookManager;
    import me.imcj.as3object.hook.impl.HookManagerImpl;
    
    import org.flexunit.asserts.assertEquals;

    public class TestHookManagerDefault
    {
        public var manager : HookManager;
        public var theCat  : Object = { "age" : 2 };
        public var hook1   : Hook = new Hook1 ( );
        public var hook2   : Hook = new Hook2 ( );
        public var hook3   : Hook = new Hook3 ( );
        
        [Before]
        public function setUp():void
        {
            manager = new HookManagerImpl ( );
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [Test]
        public function testSingle ( ) : void
        {
            manager.add ( "hook1", hook1 );
            manager.execute ( "hook1", theCat );
            
            assertEquals ( 1, theCat['age'] );
        }
        
        [Test]
        public function testMulti ( ) : void
        {
            manager.add ( "hook1", hook1 );
            manager.add ( "hook1", hook2 );
            manager.execute ( "hook1", theCat );
            
            assertEquals ( 1, theCat['age'] );
            assertEquals ( "2B", theCat['name'] );
        }
        
        [Test]
        public function testPriority ( ) : void
        {
            hook3.priority = 1;
            manager.add ( "setAge", hook1 );
            manager.add ( "setAge", hook3 );
            
            manager.execute ( "setAge", theCat );
            
            assertEquals ( 1, theCat['age'] );
        }
        
        [Test]
        public function testInterrupting ( ) : void
        {
            
        }
    }
}
import me.imcj.as3object.hook.Hook;
import me.imcj.as3object.hook.impl.HookImpl;

import test.me.imcj.as3object.hook.HookAction;

class Hook1 extends HookImpl
{
    override public function execute ( data : Object ) : HookAction
    {
        data['age'] = 1;
    }
}

class Hook2 extends HookImpl
{
    override public function execute ( data : Object ) : HookAction
    {
        data['name'] = "2B";
    }
}

class Hook3 extends HookImpl
{
    override public function execute ( data : Object ) : HookAction
    {
        data['age'] = 2;
    }
}