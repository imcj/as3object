package test.me.imcj.as3object
{
    import me.imcj.as3object.AS3ObjectResponder;
    import me.imcj.as3object.AsyncRepository;
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.Table;
    import test.me.imcj.as3object.fixture.Cat;
    
    import org.flexunit.asserts.assertEquals;

    public class TestFacade
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
        
        [Test]
        public function testGetTable ( ) : void
        {
            var table : Table = facade.cache.getWithType ( Cat );
            assertEquals ( table.name, "Cat" );
        }
        
    }
}