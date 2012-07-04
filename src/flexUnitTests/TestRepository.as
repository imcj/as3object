package flexUnitTests
{
	import me.imcj.as3object.IRepository;
	import me.imcj.as3object.SQLiteRepository;
	import me.imcj.as3object.fixture.Cat;
	
	import org.flexunit.asserts.assertEquals;

	public class TestRepository
	{
		public var repository : IRepository;
		
		[Before]
		public function setUp():void
		{
			repository = new SQLiteRepository ( null );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test]
		public function testAdd ( ) : void
		{
			var cat : Cat = new Cat ( );
			cat.name = "2B";
			cat.age = 2;
            
			repository.add ( cat );
            assertEquals ( 1, cat.id );
		}
		
		[Test]
		public function testFindAll ( ) : void
		{
			
		}
	}
}