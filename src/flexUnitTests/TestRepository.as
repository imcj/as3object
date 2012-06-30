package flexUnitTests
{
	import me.imcj.as3object.IRepository;
	import me.imcj.as3object.SQLiteRepository;
	import me.imcj.as3object.fixture.Cat;

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
		}
		
		[Test]
		public function testFindAll ( ) : void
		{
			
		}
	}
}