package flexUnitTests
{
    import me.imcj.as3object.Facade;

    public class TestFacade
    {		
        public var facade : Facade;
        
        [Before]
        public function setUp():void
        {
            facade = new Facade ( );
        }
        
        [After]
        public function tearDown():void
        {
        }
    }
}