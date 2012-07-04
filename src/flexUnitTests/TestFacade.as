package flexUnitTests
{
    import me.imcj.as3object.Facade;
    import me.imcj.as3object.fixture.Cat;

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
		
		[Test]
		public function testGetTable ( ) : void
		{
			var cat : Cat = new Cat ( );
			cat.name = "2B";
			cat.age  = 2;
			
			facade.getTable ( cat );
		}
    }
}