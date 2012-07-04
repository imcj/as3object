package flexUnitTests
{
	import flash.events.Event;
	import flash.events.SQLEvent;
	
	import me.imcj.as3object.AsyncRepository;
	import me.imcj.as3object.ObjectEvent;
	import me.imcj.as3object.SQLiteAsyncRepository;
	import me.imcj.as3object.fixture.Cat;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	public class TestSQLiteAsyncRepository
	{
		public var repository : AsyncRepository;
		
		[Before(async,order=1)]
		public function setUp():void
		{
			repository = new SQLiteAsyncRepository ( null );
			Async.proceedOnEvent ( this, repository, SQLEvent.OPEN );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Before(order=2)]
		public function setUp2 () : void
		{
			repository.creationStatement ( Cat );
		}
		
		
		[Test(async,order=1)]
		public function testAdd ( ) : void
		{
			var cat : Cat = new Cat ( );
			cat.name = "2B";
			cat.age = 2;
            
			var handlerAssert : Function = function ( event : ObjectEvent, passThroughData : Object = null ) : void
			{
				assertEquals ( 2, Cat ( event.result ).age );
			};
			var handlerAsync : Function = Async.asyncHandler ( this, handlerAssert, 10 );
			
			repository.add ( cat );
			repository.addEventListener ( ObjectEvent.RESULT, handlerAsync );
		}
		
		[Test(async,order=2)]
		public function testFindAll ( ) : void
		{
			
		}
	}
}