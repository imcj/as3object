package flexUnitTests.me.imcj.as3object.hook
{
    import me.imcj.as3object.hook.Hook;
    import me.imcj.as3object.hook.HookManager;
    import me.imcj.as3object.hook.HookManagerDefault;
    
    import org.flexunit.asserts.assertEquals;

    public class TestHookManagerDefault
    {
        public var manager : HookManager;
        public var theCat  : Object = { "age" : 2 };
        public var hook1   : Hook = new Hook1 ( );
        public var hook2   : Hook = new Hook2 ( );
        
        [Before]
        public function setUp():void
        {
            manager = new HookManagerDefault ( );
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
    }
}
import me.imcj.as3object.hook.Hook;

class Hook1 implements Hook
{
    public function execute ( data : Object ) : void
    {
        data['age'] = 1;
    }
}

class Hook2 implements Hook
{
    public function execute ( data : Object ) : void
    {
        data['name'] = "2B";
    }
}